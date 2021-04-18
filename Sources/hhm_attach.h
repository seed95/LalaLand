#ifndef HHM_ATTACH_H
#define HHM_ATTACH_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QString>
#include <QFileDialog>

#include "hhm_config.h"
#include "backend.h"

class HhmAttach : public QObject
{
    Q_OBJECT

public:
    explicit HhmAttach(QString server, QString username, QString password, QObject *parent = 0);
    ~HhmAttach();

    void uploadFile(QString srcFilename, QString dstFilename);
    void downloadFile(QString src, QString dst);

private slots:
    void uploadFinished();
    void uploadError(QNetworkReply::NetworkError error);
    void downloadReady();
    void downloadFinished();
    void downloadError(QNetworkReply::NetworkError error);

private:
    QNetworkAccessManager *m_manager;
    QNetworkReply         *m_response;
    // You must save the file on the heap
    // If you create a file object on the stack, the program will crash.
    QFile *m_file;
    QFile d_file;//download file

    QString ftp_server;
    QString ftp_username;
    QString ftp_password;
};

#endif // HHM_ATTACH_H
