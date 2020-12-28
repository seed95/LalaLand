#ifndef HHM_MAIL_H
#define HHM_MAIL_H

#include <QObject>
#include <QVector>
#include <QDate>
#include <QQmlProperty>

#include "hhm_database.h"
#include "hhm_user.h"

class HhmMail : public QObject
{
    Q_OBJECT
public:
    explicit HhmMail(QObject *item, HhmDatabase *database, QObject *parent = nullptr);

    void loadEmails(QString username);

private:
    QStringList getIdReceivedEmails(int userID);
    QStringList getIdSendEmails(int userID);
    void showEmailInSidebar(QStringList emailIds);//emailsIds: csv format

private:
    QObject *ui;

    HhmDatabase *db;
};

#endif // HHM_MAIL_H
