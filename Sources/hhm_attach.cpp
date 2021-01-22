#include "hhm_attach.h"

HhmAttach::HhmAttach(QObject *parent) : QObject(parent)
{
    m_manager = new QNetworkAccessManager(this);
    connect(m_manager, &QNetworkAccessManager::finished, this, &HhmAttach::finishedRequest);

    m_file = new QFile();
}

HhmAttach::~HhmAttach()
{
    m_file->close();
    delete m_file;
    delete m_manager;
}

void HhmAttach::uploadFile(QString srcFilename, QString dstFilename)
{
    downloading = false;
    m_file->setFileName(srcFilename);
    QFileInfo fileInfo(*m_file);

    QUrl url(QString(FTP_SERVER) + dstFilename);
    url.setUserName(FTP_USERNAME);
    url.setPassword(FTP_PASSWORD);
    url.setPort(21);

    if( m_file->open(QIODevice::ReadOnly) )
    {
        m_manager->put(QNetworkRequest(url), m_file);
    }
}

void HhmAttach::downloadFile(QString src, QString dst)
{
    QUrl url(QString(FTP_SERVER) + src);
    url.setUserName(FTP_USERNAME);
    url.setPassword(FTP_PASSWORD);
    url.setPort(21);
    dst_filepath = dst;
    downloading = true;
    m_manager->get(QNetworkRequest(url));
}

void HhmAttach::finishedRequest(QNetworkReply *reply)
{
    if (!reply->error())
    {
        qDebug() << "Finish request with out error";
        if(downloading)
        {
            QString src = reply->url().url();
            m_file->setFileName(dst_filepath);
            if( m_file->open(QIODevice::WriteOnly) )
            {
                m_file->resize(0);
                m_file->write(reply->readAll());
                m_file->close();
            }
            else
            {
                qDebug() << "Cannot open" << dst_filepath;
            }
        }
        else
        {
            if( m_file->isOpen() )
            {
                m_file->close();
            }
        }
    }
    else
    {
        qDebug() << "Finish request with error" << reply->errorString();
    }
}

