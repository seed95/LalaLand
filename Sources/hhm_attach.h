#ifndef HHM_ATTACH_H
#define HHM_ATTACH_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QString>
#include <QFileDialog>

#include "hhm_config.h"

class HhmAttach : public QObject
{
    Q_OBJECT

public:
    explicit HhmAttach(QObject *parent = 0);
    ~HhmAttach();

    void uploadFile(QString srcFilename, QString dstFilename);
    void downloadFile(QString src, QString dst);

private slots:
//    void uploadFinished(QNetworkReply *reply);  // Upload finish slot
    void finishedRequest(QNetworkReply *reply);

private:
    QNetworkAccessManager *m_manager;
    // You must save the file on the heap
    // If you create a file object on the stack, the program will crash.
    QFile *m_file;
    QString dst_filepath;

    bool downloading;
};

#endif // HHM_ATTACH_H
