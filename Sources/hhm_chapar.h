#ifndef HHM_CHAPAR_H
#define HHM_CHAPAR_H

#include <QObject>
#include <QDebug>
#include <QFileDialog>
#include <QQmlProperty>

#include "hhm_config.h"
#include "hhm_mail.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_attach.h"
#include "hhm_news.h"

class HhmChapar : public QObject
{
    Q_OBJECT
public:
    explicit HhmChapar(QObject *item, QObject *parent = nullptr);

private slots:
    //Ui slots
    void loginUser(QString uname, QString pass);
    void newBtnClicked();
    void replyBtnClicked();
    void approveBtnClicked(int caseNumber, QString tableContent, int emailId);
    void rejectBtnClicked(int caseNumber);
    void archiveBtnClicked();
    void scanBtnClicked();
    void sendBtnClicked(int receiverId, int caseNumber, QString subject,
                        QString filepath, QString tableContent);
    void flagBtnClicked(int id);
    void uploadFileClicked();
    void downloadFileClicked(QString src, int caseNumber);
    void syncInbox();
    void syncOutbox();
    void openEmail(int idEmail);
    void checkUsername(QString username);

private:
    void addNewDocToDocuments();
    QVariant getConfig(QString key);

private:
    QObject *ui;
    HhmMail     *mail;
    HhmDatabase *db;
    HhmUser     *user;
    HhmAttach   *ftp;
    HhmNews     *news;

    QString last_directory;
    int doc_base_id;
};

#endif // HHM_CHAPAR_H
