#ifndef HHM_MAIL_H
#define HHM_MAIL_H

#include <QObject>
#include <QVector>
#include <QDate>
#include <QQmlProperty>
#include <QFileInfo>

#include "hhm_database.h"
#include "hhm_user.h"



class HhmMail : public QObject
{
    Q_OBJECT
public:
    explicit HhmMail(QObject *item, HhmDatabase *database, QObject *parent = nullptr);

private:

//    HhmEmailTable getEmail(int idEmail);
    bool updateEmail(QString field, int userId, int emailId);
//    HhmUserTable getUser(int idUser);

private:
    QObject *ui;

    HhmDatabase *db;
};

#endif // HHM_MAIL_H
