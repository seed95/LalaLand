#ifndef HHMDOCUMENT_H
#define HHMDOCUMENT_H

#include <QObject>
#include <QQmlProperty>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"
#include "hhm_mail.h"

typedef struct DocumentData
{
    int             casenumber;
    int             senderId;
    int             receiverId;
    QString         senderName;
    QString         subject;
    QString         filepath;
    QString         tableContent;
    QString         date;
}DocumentData;

class HhmDocument : public QObject
{
    Q_OBJECT
public:
    explicit HhmDocument(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                         QObject *parent=nullptr);
    ~HhmDocument();

private slots:
    //Ftp Slots
    void uploadSuccess(QString filename);
    void uploadFailed(QString filename);
    void downloadSuccess(QString filename);
    void downloadFailed(QString filename);

    //Action Slots
    void newDocumentClicked();

    //Main Slots

    //New Slots
    void checkUsername(QString username);
    void uploadFileClicked();
    void sendNewDocument(int caseNumber, int receiverId,
                         QString subject, QString filepath,
                         QString tableContent);

private:
    void setDocumentBaseId();
    void updateDocument();
    QVariant getConfig(QString key);

private:
    QObject *main_ui;
    QObject *action_ui;

    QObject *new_ui;
    QObject *new_input_cc_ui;
    QObject *new_input_to_ui;

    QObject *show_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
    HhmFtp      *ftp;
    HhmMail     *mail;

    int doc_base_id;//Document Base id in 'HHM_TABLE_CONFIG'
    DocumentData new_data;
};

#endif // HHMDOCUMENT_H
