#include "hhm_admin.h"

HhmAdmin::HhmAdmin(QObject *root, HhmDatabase *database, QObject *parent): QObject(parent)
{
    db = database;

    departments_ui = root->findChild<QObject*>("AdminDepartments");
    roles_ui = root->findChild<QObject*>("AdminRoles");
    users_ui = root->findChild<QObject*>("AdminUsers");

    connect(roles_ui, SIGNAL(chkBoxChanged(int, int, int)), this, SLOT(setRolePermission(int, int, int)));
    connect(roles_ui, SIGNAL(createPermission(QString)), this, SLOT(addNewPermission(QString)));
    connect(departments_ui, SIGNAL(createDepartments(QString)), this, SLOT(addNewDepartment(QString)));
    connect(users_ui, SIGNAL(setUserRole(int, int)), this, SLOT(setUserRole(int, int)));

    getUsers();
    getDepartment();
    getRoles();

    setUserRole(4, 7);
    setUserDepartment(4, 5);
    setDepartmentGroup(6, 8);
}

HhmAdmin::~HhmAdmin()
{
    ;
}

void HhmAdmin::addNewPermission(QString permission)
{
    QSqlQuery res = db->select("*", "roles");
    int count = res.size();

    qDebug() << permission;
    QString table = "roles";
    QString columns = "`role_id`, `role_name`, `permission_1`, `permission_2`, `permission_3`,";
    columns += " `permission_4`, `permission_5`, `permission_6`, `permission_7`, `permission_8`, `permission_9`";
    QString values = "'" + QString::number(count+1);
    values += "', '" + permission + "', '0'"+ ", '0'"+ ", '0'"+ ", '0'"+ ", '0'"+ ", '0'"+ ", '0'"+ ", '0'"+ ", '0'";

    db->insert(table, columns, values);
}

void HhmAdmin::addNewDepartment(QString department)
{
    QSqlQuery res = db->select("*", "departments");
    int count = res.size();

    QString table = "departments";
    QString columns = "`department_id`, `department_name`, `group_id`";
    QString values = "'" + QString::number(count+1) + "', '" + department + "', '2'";
    db->insert(table, columns, values);
}

void HhmAdmin::setUserRole(int user_id, int user_role)
{
    QString condition = "`id_admin_users` = '" + QString::number(user_id) + "'";
    QString values = "`role_id` = '" + QString::number(user_role) + "'";
    db->update(condition, values, "user_role");
}

void HhmAdmin::setUserDepartment(int user_id, int user_department)
{
    QString condition = "`id_admin_users` = '" + QString::number(user_id) + "'";
    QString values = "`department_id` = '" + QString::number(user_department) + "'";
    db->update(condition, values, "user_role");
}

void HhmAdmin::setRolePermission(int role_id, int permission_id, int value)
{
    QString column_name;
    QString condition = "`role_id` = '" + QString::number(role_id) + "'";

    if( permission_id==1 )
    {
        column_name = "permission_1";
    }
    else if( permission_id==2 )
    {
        column_name = "permission_2";
    }
    else if( permission_id==3 )
    {
        column_name = "permission_3";
    }
    else if( permission_id==4 )
    {
        column_name = "permission_4";
    }
    else if( permission_id==5 )
    {
        column_name = "permission_5";
    }
    else if( permission_id==6 )
    {
        column_name = "permission_6";
    }
    else if( permission_id==7 )
    {
        column_name = "permission_7";
    }
    else if( permission_id==8 )
    {
        column_name = "permission_8";
    }
    else if( permission_id==9 )
    {
        column_name = "permission_9";
    }
    else
    {
        qDebug() << "Permission ID not supported";
    }

    QString values = "`" + column_name + "` = '" + QString::number(value) + "'";
    db->update(condition, values, "roles");
}

void HhmAdmin::setDepartmentGroup(int department_id, int group_id)
{
    QString condition = "`department_id` = '" + QString::number(department_id) + "'";
    QString values = "`group_id` = '" + QString::number(group_id) + "'";
    db->update(condition, values, "departments");
}

void HhmAdmin::getRoles()
{
    QSqlQuery res = db->select("*", "roles");

    QSqlRecord rec = res.record();
    int count = res.size();
    QString column_s;

    for( int i=0 ; i<count ; i++ )
    {
        if( res.next() )
        {
            QVariant data = res.value("role_name");
            QString permissionName = data.toString();
            QQmlProperty::write(roles_ui, "permission_name", permissionName);
            QMetaObject::invokeMethod(roles_ui, "addPermission");
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
}

void HhmAdmin::getDepartment()
{
    QSqlQuery res = db->select("*", "departments");

    QSqlRecord rec = res.record();
    int count = res.size();
    QString column_s;

    for( int i=0 ; i<count ; i++ )
    {
        if( res.next() )
        {
            QVariant data = res.value("department_name");
            QString departmentName = data.toString();
            QQmlProperty::write(departments_ui, "department_name", departmentName);
            QMetaObject::invokeMethod(departments_ui, "addDepartment");
        }
        else
        {
            qDebug() << "error getDepartment";
        }
    }
}

void HhmAdmin::getUsers()
{
    QSqlQuery res = db->select("*", "user_role");

    QSqlRecord rec = res.record();
    int count = res.size();
    QString column_s;

    for( int i=0 ; i<count ; i++ )
    {
        if( res.next() )
        {
            QVariant data = res.value("username");
            QString userName = data.toString();
            QQmlProperty::write(users_ui, "user_name", userName);
            QMetaObject::invokeMethod(users_ui, "addUser");
        }
        else
        {
            qDebug() << "error getUsers";
        }
    }
}
