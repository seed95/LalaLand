#ifndef HHM_CHAPAR_H
#define HHM_CHAPAR_H

#include <QObject>
#include <QDebug>
#include <QFileDialog>
#include <QQmlProperty>
#include <QCryptographicHash>

#include "hhm_config.h"
#include "hhm_mail.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_attach.h"

class HhmChapar : public QObject
{
    Q_OBJECT
public:
    explicit HhmChapar(QObject *item, QObject *parent = nullptr);

private slots:
    void loginUser(QString uname, QString pass);
    void newBtnClicked();
    void replyBtnClicked();
    void approveBtnClicked(int caseNumber);
    void rejectBtnClicked(int caseNumber);
    void archiveBtnClicked();
    void scanBtnClicked();
    void sendBtnClicked(QString caseNumber, QString subject);
    void flagBtnClicked(int id);
    void uploadFileClicked();
    void downloadFileClicked(QString src, int caseNumber);
    void syncInbox();
    void syncOutbox();
    void openEmail(int idEmail);

private:
    void addNewDocToDocuments();
    QVariant getConfig(QString key);

private:
    QObject *ui;

    HhmMail *mail;
    HhmDatabase *db;
    HhmUser *user;
    HhmAttach *ftp;

    QString upload_filepath;
    QString last_directory;

};

#endif // HHM_CHAPAR_H
