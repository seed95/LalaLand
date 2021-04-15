#ifndef HHM_MAIL_H
#define HHM_MAIL_H

#include <QObject>
#include <QVector>
#include <QDate>
#include <QQmlProperty>
#include <QFileInfo>

#include "hhm_database.h"
#include "hhm_user.h"

typedef struct HhmEmailTable
{
    int emailId;
    int documentId;
    int flag;//0,1
    int opened;//0,1
    QDateTime date;
    int sentEmail;//0,1
    int receiveEmail;//0,1
} HhmEmailTable;

class HhmMail : public QObject
{
    Q_OBJECT
public:
    explicit HhmMail(QObject *item, HhmDatabase *database, QObject *parent = nullptr);

    void loadEmails(QString username);
    void loadInboxEmails(int idUser);
    void loadOutboxEmails(int idUser);

    void approveDoc(int caseNumber);
    void rejectDoc(int caseNumber);

    void sendNewEmail(QString caseNumber, QString subject, int senderId, int receiverId, QString filepath, QString senderName);
    bool checkCaseNumber(QString caseNumber);

private:
    QStringList getIdReceivedEmails(int userID);
    QStringList getIdSendEmails(int userID);
    void showEmailInSidebar(QStringList emailIds);//emailsIds: csv format
    HhmEmailTable getEmail(int idEmail);
    int addNewDocument(QString caseNumber, QString filepath, int senderId, int receiverId, QString subject, QString senderName);
    int addNewEmail(int docId);
    bool updateEmail(QString field, int userId, int emailId);

private:
    QObject *ui;

    HhmDatabase *db;
};

#endif // HHM_MAIL_H
