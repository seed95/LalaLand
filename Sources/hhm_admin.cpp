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
    values += "', '" + permission + "', '0', '0', '0', '0', '0', '0', '0', '0', '0'";

    db->insert(table, columns, values);
}

void HhmAdmin::addNewDepartment(QString department)
{
    qDebug() << department;

    QSqlQuery res = db->select("*", "departments");
    int count = res.size();

    QString table = "departments";
    QString columns = "`department_id`, `department_name`, `group_id`";
    QString values = "'" + QString::number(count+1) + "', '" + department + "', '2'";
    db->insert(table, columns, values);
}

void HhmAdmin::setUserRole(int user_index, int role_id)
{
    QSqlQuery res_ur = db->select("*", "user_role");

    QSqlRecord rec_ur = res_ur.record();
    int count_ur = res_ur.size();

    QString table = "user_role";
    QString columns = "`id_admin_users`, `user_id`, `department_id`, `role_id`";
    QString values = "'" + QString::number(count_ur+1) + "', '" + QString::number(user_index) + "', '-1', '" + QString::number(role_id) +"'";
    db->insert(table, columns, values);
}

QString HhmAdmin::getPermissionName(int role_id)
{
    QSqlQuery query = db->select("*", "roles");
    QSqlRecord rec_r = query.record();

    for( int i=0 ; i<role_id ; i++ )
    {
        if( query.next() )
        {
            ;///FIXME: A Bug Lies Here (Bijan)
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
    QVariant data = query.value("role_name");
    QString permissionName = data.toString();

    return permissionName;
}

int HhmAdmin::getUserID(int user_index)
{
    QSqlQuery query = db->select("*", "user");
    QSqlRecord rec_r = query.record();

    for( int i=0 ; i<user_index ; i++ )
    {
        if( query.next() )
        {
            ;///FIXME: A Bug Lies Here (Bijan)
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
    QVariant data = query.value("id");
    int userID = data.toInt();

    return userID;
}

int HhmAdmin::getUserIndex(int user_id)
{
    QSqlQuery query = db->select("*", "user");
    QSqlRecord rec = query.record();

    int count = query.size();


    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant data = query.value("id");
            int userID = data.toInt();
            if( user_id==userID )
            {
                return  i;
            }
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
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

            QQmlProperty::write(users_ui, "role", permissionName);
            QMetaObject::invokeMethod(users_ui, "addRole");
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

            QQmlProperty::write(departments_ui, "group", departmentName);
            QMetaObject::invokeMethod(departments_ui, "addGroup");
        }
        else
        {
            qDebug() << "error getDepartment";
        }
    }
}

void HhmAdmin::getUsers()
{
    QSqlQuery res = db->select("*", "user");

    QSqlRecord rec = res.record();
    int count = res.size();
    QString column_s;

    for( int i=0 ; i<count ; i++ )
    {
        if( res.next() )
        {
            QVariant data = res.value("id");
            int user_id = data.toInt();
            QString username = getUsername(user_id);
            QString name = getName(user_id);

            QQmlProperty::write(users_ui, "user_username", username);
            QQmlProperty::write(users_ui, "user_name", name);
            QMetaObject::invokeMethod(users_ui, "addUser");

            qDebug() << "Role's of user" << i << "are:";
            getUserRoles(i);
        }
        else
        {
            qDebug() << "error getUsers";
        }
    }
}

QString HhmAdmin::getUsername(int user_id)
{

    QString condition = "`id`='" + QString::number(user_id) + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);

    if( res.next() )
    {
        QVariant data = res.value("username");
        QString username = data.toString();
        return username;
    }
    else
    {
        qDebug() << "error getUsername";
        return "";
    }
}

QString HhmAdmin::getName(int user_id)
{
    QString condition = "`id`='" + QString::number(user_id) + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);

    if( res.next() )
    {
        QVariant data1 = res.value("firstname");
        QVariant data2 = res.value("lastname");
        QString name1 = data1.toString();
        QString name2 = data2.toString();
        QString name = name1 + " " + name2;
        return name;
    }
    else
    {
        qDebug() << "error getUsername";
        return "";
    }
}

void    HhmAdmin::getUserRoles(int user_index)
{
    int user_id = getUserID(user_index);

    QSqlQuery query = db->select("*", "user_role");
    QSqlRecord rec = query.record();

    int count = query.size();


    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant data = query.value("user_id");
            int user_id_server = data.toInt();

            if( user_id_server==user_id )
            {
               data = query.value("role_id");
               int role_id = data.toInt();
               qDebug() << role_id;
            }
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
}

