#ifndef HhmAdminRoles_H
#define HhmAdminRoles_H

#include <QObject>
#include <QQmlProperty>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"

class HhmAdminRoles : public QObject
{
    Q_OBJECT
public:
    explicit HhmAdminRoles(QObject *root, HhmDatabase *database,
                        QObject *parent = nullptr);
    ~HhmAdminRoles();

private slots:
    void qmlComplete();
    void removeRole(int role_index);


public:
    void readRoles();
    void *getPermmissionsA(QSqlQuery query, int *data);
    void setPermissionUi(int row, int column);
    int  getRoleIndex(int permisson_id);
    int  getRoleID(int permission_index);
    void removeUserRole(int role_id);
    int  getLastUserRoleId();
    int  getLastRolesId();
    QString getRoleName(int role_id);

private:
    QObject *departments_ui;
    QObject *roles_ui;
    QObject *users_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
    QTimer      *timer;

};

#endif // HhmAdminRoles_H
