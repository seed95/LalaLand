#ifndef HHMADMINDEPARTMENTS_H
#define HHMADMINDEPARTMENTS_H

#include <QObject>
#include <QQmlProperty>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"

#define HHM_NULL_ID 0

class HhmAdminDepartments : public QObject
{
    Q_OBJECT
public:
    explicit HhmAdminDepartments(QObject *root, HhmDatabase *database,
                        QObject *parent = nullptr);
    ~HhmAdminDepartments();

private slots:
    void qmlComplete();
    void addDepartmentGroup(int department_index, int group_index);
    void removeDepartment(int department_index);
    void removeDepartmentGroup(int department_index, QString group_name);
    void removeUserDepartment(int department_id);

public:
    void    readDepartments();
    void    readGroups(int department_index);
    void    setGroupUi(int department_index, QString group_name);
    int     getDepartmentIndex(int department_id);
    int     getDepartmentID(int department_index);
    int     getDepartmentID(QString department_name);
    QString getDepartmentName(int department_id);

private:
    QObject *departments_ui;
    QObject *roles_ui;
    QObject *users_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
    QTimer      *timer;

};

#endif // HHMADMINDEPARTMENTS_H
