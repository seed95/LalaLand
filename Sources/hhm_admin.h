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
    explicit HhmAdmin(QObject *root, HhmDatabase *database,
                        QObject *parent = nullptr);
    ~HhmAdmin();

private slots:
    void addNewPermission(QString permission);
    void addNewDepartment(QString department);
    void setUserRole(int user_id, int user_role);
    void setUserDepartment(int user_id, int user_department);
    void setRolePermission(int role_id, int permission_id, int value);
    void setDepartmentGroup(int department_id, int group_id);

private:
    void getRoles();
    void getDepartment();
    void getUsers();
    QString getUsername(int user_id);
    QString getName(int user_id);

    QObject *departments_ui;
    QObject *roles_ui;
    QObject *users_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
};

#endif // HHMADMIN_H
