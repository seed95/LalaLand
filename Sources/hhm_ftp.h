#ifndef HHM_FTP_H
#define HHM_FTP_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QString>
#include <QFileDialog>

#include "hhm_config.h"
#include "backend.h"

class HhmFtp : public QObject
{
    Q_OBJECT

public:
    explicit HhmFtp(QObject *parent=nullptr);
    ~HhmFtp();

    void uploadFile(QString srcFilename, QString dstFilename);
    void downloadFile(QString src, QString dst);

private slots:
    void uploadFinished();
    void uploadError(QNetworkReply::NetworkError error);

    void downloadReady();
    void downloadFinished();
    void downloadError(QNetworkReply::NetworkError error);

signals:
    void uploadSuccess(QString filename);
    void uploadFailed(QString filename);

    void downloadSuccess(QString filename);
    void downloadFailed(QString filename);


private:
    QNetworkAccessManager *m_manager;
    QNetworkReply         *m_response;
    // You must save the file on the heap
    // If you create a file object on the stack, the program will crash.
    QFile *u_file;//upload file
    QFile d_file;//download file
};

#endif // HHM_FTP_H
