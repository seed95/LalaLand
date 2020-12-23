#ifndef HHMUSER_H
#define HHMUSER_H

#include <QObject>

#include "hhm_database.h"
#include "hhm_config.h"

class HhmUser : public QObject
{
    Q_OBJECT
public:
    explicit HhmUser(QObject *item, HhmDatabase *database, QObject *parent = nullptr);

    void loadUser(QString username);
    QString getName() {return fname + " " + lname;}
    QString getUsername() {return uname;}
    int getId() {return id;}
    QString getFirstname() {return fname;}
    QString getLastname() {return lname;}


private:
    QString fname;//first name
    QString lname;//last name
    QString uname;//user name
    int id;

    HhmDatabase *db;
};

#endif // HHMUSER_H
