#ifndef HHMADMINPERMISSIONS_H
#define HHMADMINPERMISSIONS_H

#include <QObject>
#include <QQmlProperty>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"

class HhmAdminPermissions : public QObject
{
    Q_OBJECT
public:
    explicit HhmAdminPermissions(QObject *root, HhmDatabase *database,
                        QObject *parent = nullptr);
    ~HhmAdminPermissions();

private slots:
    void qmlComplete();


public:
    void readRoles();
    void *getPermmissionsA(QSqlQuery query, int *data);
    void setPermissionUi(int row, int column);

private:
    QObject *departments_ui;
    QObject *roles_ui;
    QObject *users_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
    QTimer      *timer;

};

#endif // HHMADMINPERMISSIONS_H
