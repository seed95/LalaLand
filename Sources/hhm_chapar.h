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
#include "hhm_ftp.h"
#include "hhm_news.h"
#include "hhm_sidebar.h"
#include "hhm_message.h"
#include "hhm_document.h"
#include "hhm_admin.h"

class HhmChapar : public QObject
{
    Q_OBJECT
public:
    explicit HhmChapar(QObject *item, QObject *parent = nullptr);

private slots:
    //Ui slots
    void loginUser(QString uname, QString pass);
    void replyBtnClicked();
    void approveBtnClicked(int caseNumber, QString tableContent, int emailId);
    void rejectBtnClicked(int caseNumber);
    void archiveBtnClicked();
    void scanBtnClicked();
    void flagBtnClicked(int id);
    void downloadFileClicked(QString src, int caseNumber);

private:
    void        addNewDocToDocuments();
    QVariant    getConfig(QString key);
    void        setFtpConfigs();

private:
    QObject     *ui;
    HhmMail     *mail;
    HhmDatabase *db;
    HhmUser     *user;
    HhmFtp      *ftp;

    HhmNews     *news;
    HhmSidebar  *sidebar;
    HhmAdmin    *admin;
    HhmMessage  *message;
    HhmDocument *document;


    QString last_directory;
};

#endif // HHM_CHAPAR_H
