#ifndef HHM_MAIL_H
#define HHM_MAIL_H

#include <QObject>
#include <QVector>
#include <QDate>
#include <QQmlProperty>

#include "hhm_database.h"

class HhmMail : public QObject
{
    Q_OBJECT
public:
    explicit HhmMail(QObject *item, HhmDatabase *database, QObject *parent = nullptr);

    void loadReceivedEmails(int userID);

private:
    QStringList getIdReceivedEmails(int userID);

private:
    QObject *ui;

    HhmDatabase *db;
};

#endif // HHM_MAIL_H
