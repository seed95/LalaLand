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
#include "hhm_admin_users.h"
#include "hhm_admin_roles.h"
#include "hhm_admin_departments.h"

class HhmAdmin : public QObject
{
    Q_OBJECT
public:
    explicit HhmAdmin(QObject *root, HhmDatabase *database,
                        QObject *parent = nullptr);
    ~HhmAdmin();

private slots:
    void addNewRole(QString permission);
    void addNewDepartment(QString department);
    void setUserDepartment(int user_index, int department_index);
    void setRolePermission(int role_id, int permission_id, int value);
    void addUserRole(int user_index, int role_id);

private:
    void getRoles();
    void getDepartment();
    void getUsers();
    QString getUsername(int user_id);
    QString getName(int user_id);
    QString getRoleName(int role_id);
    int     getUserID(int user_index);
    int     getRoleID(int role_index);

    QObject *departments_ui;
    QObject *roles_ui;
    QObject *users_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
    HhmAdminUsers *m_auser;
    HhmAdminRoles *m_arole;
    HhmAdminDepartments *m_adepartment;
};

#endif // HHMADMIN_H
