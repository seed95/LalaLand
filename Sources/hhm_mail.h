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
    int docCasenumber;
    int flag;//0,1
    int opened;//0,1
    QDateTime date;
    int sentEmail;//0,1
    int receiveEmail;//0,1
} HhmEmailTable;

typedef struct HhmUserTable
{
    int userId;
    QString firstname;
    QString lastname;//0,1
    QString username;//0,1
} HhmUserTable;

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

    void sendNewEmail(QString caseNumber, QString subject, int senderId, int receiverId,
                      QString filepath, QString senderName, QString tableContent);

private:
    QStringList getIdReceivedEmails(int userID);
    QStringList getIdSendEmails(int userID);
    void showEmailInSidebar(QStringList emailIds);//emailsIds: csv format
    HhmEmailTable getEmail(int idEmail);
    void updateDocument(QString caseNumber, QString filepath, int senderId, int receiverId,
                        QString subject, QString senderName, QString tableContent);
    int addNewEmail(QString caseNumber);
    bool updateEmail(QString field, int userId, int emailId);
    HhmUserTable getUser(int idUser);

private:
    QObject *ui;

    HhmDatabase *db;
};

#endif // HHM_MAIL_H
