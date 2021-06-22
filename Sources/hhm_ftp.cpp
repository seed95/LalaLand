#include "hhm_ftp.h"

HhmFtp::HhmFtp(QObject *parent) : QObject(parent)
{
    hhm_log("Ftp --> server: " + hhm_getFtpAddress() + ", username: " + hhm_getFtpUsername());

    m_manager = new QNetworkAccessManager();
    u_file = new QFile();
    m_response = nullptr;
}

HhmFtp::~HhmFtp()
{
    u_file->close();
    delete u_file;
    delete m_manager;
    if( m_response!=nullptr )
    {
        delete m_response;
    }
}

void HhmFtp::uploadFile(QString srcFilename, QString dstFilename)
{
    if( u_file->isOpen() )
    {
        u_file->close();
    }
    u_file->setFileName(srcFilename);

    QUrl url(hhm_getFtpAddress() + dstFilename);
    url.setUserName(hhm_getFtpUsername());
    url.setPassword(hhm_getFtpPassword());
    url.setPort(21);

    if( u_file->open(QIODevice::ReadOnly) )
    {
        m_response = m_manager->put(QNetworkRequest(url), u_file);
        connect(m_response, SIGNAL(finished()), this, SLOT(uploadFinished()));
        connect(m_response, SIGNAL(error(QNetworkReply::NetworkError)),
                this, SLOT(uploadError(QNetworkReply::NetworkError)));
    }
    else
    {
        emit uploadFailed(u_file->fileName());
        hhm_log("Cannot open file " + u_file->fileName());
    }
}

void HhmFtp::downloadFile(QString src, QString dst)
{
    QUrl url(hhm_getFtpAddress() + src);
    url.setUserName(hhm_getFtpUsername());
    url.setPassword(hhm_getFtpPassword());
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

    if( !d_file.open(QIODevice::ReadWrite) )//create new file if not exist
    {
        emit downloadFailed(d_file.fileName());
        hhm_log("Cannot open file " + d_file.fileName());
        return;
    }
    m_response = m_manager->get(QNetworkRequest(url));
    connect(m_response, SIGNAL(readyRead()), this, SLOT(downloadReady()));
    connect(m_response, SIGNAL(finished()), this, SLOT(downloadFinished()));
    connect(m_response, SIGNAL(error(QNetworkReply::NetworkError)),
            this, SLOT(downloadError(QNetworkReply::NetworkError)));
}

void HhmFtp::downloadReady()
{
    d_file.write(m_response->readAll());
}

void HhmFtp::downloadFinished()
{
    d_file.write(m_response->readAll());
    d_file.close();
    if( m_response->error()==QNetworkReply::NoError )
    {
        hhm_log("Download Success, Url: " + m_response->url().toString());
        emit downloadSuccess(d_file.fileName());
    }
    else
    {
        downloadError(m_response->error());
    }
}

void HhmFtp::downloadError(QNetworkReply::NetworkError error)
{
    hhm_log("Download Error: " + m_response->errorString() +
            "(" + QString::number(error) + ")" +
            ", Url: " + m_response->url().toString());
    emit downloadFailed(d_file.fileName());
}

void HhmFtp::uploadFinished()
{
    if( u_file->isOpen() )
    {
        u_file->close();
    }
    if( m_response->error()==QNetworkReply::NoError )
    {
        hhm_log("Upload Success, Url: " + m_response->url().toString());
        emit uploadSuccess(u_file->fileName());
    }
    else
    {
        uploadError(m_response->error());
    }
}

void HhmFtp::uploadError(QNetworkReply::NetworkError error)
{
    hhm_log("Upload Error: " + m_response->errorString() +
            "(" + QString::number(error) + ")" +
            ", Url: " + m_response->url().toString());
    emit uploadFailed(u_file->fileName());
}

