#include "hhm_attach.h"

HhmAttach::HhmAttach(QString server, QString username, QString password, QObject *parent) : QObject(parent)
{
    ftp_server = server;
    ftp_username = username;
    ftp_password = password;

    m_manager = new QNetworkAccessManager(this);
//    connect(m_manager, SIGNAL(finished(QNetworkReply*)), this, SLOT(finishedRequest()));

    m_file = new QFile();

    hhm_log("Ftp --> server: " + server + ", username: " + username);
}

HhmAttach::~HhmAttach()
{
    m_file->close();
    delete m_file;
    delete m_manager;
    delete m_response;
}

void HhmAttach::uploadFile(QString srcFilename, QString dstFilename)
{
    m_file->setFileName(srcFilename);

    QUrl url(ftp_server + dstFilename);
    url.setUserName(ftp_username);
    url.setPassword(ftp_password);
    url.setPort(21);

    if( m_file->open(QIODevice::ReadOnly) )
    {
        m_response = m_manager->put(QNetworkRequest(url), m_file);
        connect(m_response, SIGNAL(finished()), this, SLOT(uploadFinished()));
        connect(m_response, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(uploadError(QNetworkReply::NetworkError)));
    }
    else
    {
        hhm_showMessage(tr("Upload failed ") + url.toString(), 3000);
        hhm_log("Cannot open file " + m_file->fileName());
    }
}

void HhmAttach::downloadFile(QString src, QString dst)
{
    QUrl url(QString(ftp_server) + src);
    url.setUserName(ftp_username);
    url.setPassword(ftp_password);
    url.setPort(21);
    d_file.setFileName(dst);

    if( d_file.exists() )
    {
        d_file.setPermissions(d_file.permissions() |
                              QFileDevice::ReadOwner |
                              QFileDevice::WriteOwner |
                              QFileDevice::ReadGroup |
                              QFileDevice::WriteGroup);
    }

    if( !d_file.open(QIODevice::ReadWrite) )//if file not exist create new file
    {
        hhm_showMessage(tr("Download file failed"), 3000);
        hhm_log("Cannot open file " + d_file.fileName());
        return;
    }
    m_response = m_manager->get(QNetworkRequest(url));
    connect(m_response, SIGNAL(readyRead()), this, SLOT(downloadReady()));
    connect(m_response, SIGNAL(finished()), this, SLOT(downloadFinished()));
    connect(m_response, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(downloadError(QNetworkReply::NetworkError)));
}

void HhmAttach::downloadReady()
{
    d_file.write(m_response->readAll());
}

void HhmAttach::downloadFinished()
{
    d_file.write(m_response->readAll());
    d_file.close();
    if( m_response->error()==QNetworkReply::NoError )
    {
        hhm_showMessage(tr("File successfully downloaded"), 3000);
        hhm_log("Download successfully from url: " + m_response->url().toString());
    }
    else if( m_response->error()==QNetworkReply::ContentNotFoundError )
    {
        hhm_showMessage(tr("Download failed, file not found"), 3000);
        hhm_log("Download error: " + m_response->errorString() + ", url: " + m_response->url().toString());
    }
    else
    {
        hhm_showMessage(tr("Download from ") + m_response->url().toString() + tr(" failed"), 3000);
        hhm_log("Download error: " + m_response->errorString() + ", url: " + m_response->url().toString());
    }
}

void HhmAttach::downloadError(QNetworkReply::NetworkError error)
{
    hhm_showMessage(tr("Download from ") + m_response->url().toString() + tr(" failed"), 3000);
    hhm_log("Download error: " + m_response->errorString() + ", url: " + m_response->url().toString());
}

void HhmAttach::uploadFinished()
{
    if( m_file->isOpen() )
    {
        m_file->close();
    }
    if( m_response->error()==QNetworkReply::NoError )
    {
        hhm_showMessage(tr("File successfully uploaded"), 3000);
        hhm_log("Upload successfully from url: " + m_response->url().toString());
    }
    else
    {
        hhm_showMessage(tr("Upload failed ") + m_response->url().toString(), 3000);
        hhm_log("Upload error: " + m_response->errorString() + ", url: " + m_response->url().toString());
    }
}

void HhmAttach::uploadError(QNetworkReply::NetworkError error)
{
    hhm_showMessage(tr("Upload failed ") + m_response->url().toString(), 3000);
    hhm_log("Upload error: " + m_response->errorString() + ", url: " + m_response->url().toString());
}

//void HhmAttach::finishedRequest()
//{
//    qDebug() << "$$$$$$$$$$$";
//}
