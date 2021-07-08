#ifndef HHMUSER_H
#define HHMUSER_H

#include <QObject>
#include <QDateTime>

#include "hhm_database.h"
#include "hhm_config.h"

class HhmUser : public QObject
{
    Q_OBJECT
public:
    explicit HhmUser(QObject *item, HhmDatabase *database, QObject *parent = nullptr);

    bool loadUser(QString username, QString password);

    int         getId();
    QString     getFirstname();
    QString     getLastname();
    QString     getName() {return getFirstname() + " " + getLastname();}
    QString     getUsername();
    QDateTime   getLastLogin();
    int         getStatus();
    QString     getBio();
    QString     getImage();
    int         getDepartmentId();
    int         getPermission();

    QString     getFirstname(int id);
    QString     getLastname(int id);
    QString     getName(int id);
    QString     getUsername(int id);

private:
    void printUser();

    int getRolePermission(int roleId);

private:
    HhmDatabase *db;
    QObject *ui;
};

#endif // HHMUSER_H
