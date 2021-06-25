#ifndef HHMADMIN_H
#define HHMADMIN_H

#include <QObject>
#include <QQmlProperty>
#include <QFileDialog>
#include <QJsonArray>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"

class HhmAdmin : public QObject
{
    Q_OBJECT
public:
    explicit HhmAdmin(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                        QObject *parent = nullptr);
    ~HhmAdmin();

private slots:
    void addNewPermission(QString permission);
    void changePermission(int permission, int userID, int value);

private:
    QObject *admin_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
};

#endif // HHMADMIN_H
