#ifndef HHM_CHAPAR_H
#define HHM_CHAPAR_H

#include <QObject>
#include <QDebug>
#include <QFileDialog>

#include "hhm_config.h"
#include "hhm_mail.h"
#include "hhm_database.h"
#include "hhm_user.h"

class HhmChapar : public QObject
{
    Q_OBJECT
public:
    explicit HhmChapar(QObject *item, QObject *parent = nullptr);

private slots:
    void newBtnClicked();
    void replyBtnClicked();
    void forwardBtnClicked();
    void deleteBtnClicked();
    void archiveBtnClicked();
    void scanBtnClicked();
    void sendBtnClicked(int caseNumber, QString subject);
    void syncBtnClicked();
    void flagBtnClicked(int id);
    void uploadFileClicked();

private:
    void addNewDocToDocuments();

private:
    QObject *ui;

    HhmMail *mail;
    HhmDatabase *db;
    HhmUser *user;


    QString upload_file;

};

#endif // HHM_CHAPAR_H
