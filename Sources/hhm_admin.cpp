#include "hhm_admin.h"

HhmAdmin::HhmAdmin(QObject *root, HhmDatabase *database, QObject *parent): QObject(parent)
{
    db = database;

    departments_ui = root->findChild<QObject*>("AdminDepartments");
    roles_ui = root->findChild<QObject*>("AdminRoles");
    users_ui = root->findChild<QObject*>("AdminUsers");

    connect(users_ui, SIGNAL(setUserRole(int, int)),
            this, SLOT(addUserRole(int, int)));
    connect(users_ui, SIGNAL(setUserDepartment(int, int)),
            this, SLOT(setUserDepartment(int, int)));

    connect(roles_ui, SIGNAL(chkBoxChanged(int, int, int)),
            this, SLOT(setRolePermission(int, int, int)));
    connect(roles_ui, SIGNAL(createPermission(QString)),
            this, SLOT(addNewPermission(QString)));

    connect(departments_ui, SIGNAL(createDepartments(QString)),
            this, SLOT(addNewDepartment(QString)));

    m_auser = new HhmAdminUsers(root, db);
    m_arole = new HhmAdminPermissions(root, db);
    m_adepartment = new HhmAdminDepartments(root, db);

    getUsers();
    getDepartment();
    getRoles();

//    getUserRoles(4);
    setUserDepartment(4, 5);
}

HhmAdmin::~HhmAdmin()
{
    ;
}

void HhmAdmin::addNewPermission(QString permission)
{
    QSqlQuery res = db->select("*", HHM_TABLE_ROLE);
    int count = res.size();

    qDebug() << permission;
//    QString columns = "`" + QString(HHM_ROLE_ID)
    QString columns = "`id`, `role_name`, `permission_1`, `permission_2`, `permission_3`,";
    columns += " `permission_4`, `permission_5`, `permission_6`, `permission_7`, `permission_8`, `permission_9`";
    QString values = "'" + QString::number(count+1);
    values += "', '" + permission + "', '0', '0', '0', '0', '0', '0', '0', '0', '0'";

    db->insert(HHM_TABLE_ROLE, columns, values);
}

void HhmAdmin::addNewDepartment(QString department)
{
    QSqlQuery res = db->select("*", HHM_TABLE_DEPARTMENT);
    int count = res.size();

    QString columns = "`id`, `department_name`";
    QString values = "'" + QString::number(count+1) + "', '" + department + "'";
    db->insert(HHM_TABLE_DEPARTMENT, columns, values);
}

QString HhmAdmin::getPermissionName(int role_id)
{
    QSqlQuery query = db->select("*", HHM_TABLE_ROLE);
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
    QVariant data = query.value(HHM_ROLE_NAME);
    QString permissionName = data.toString();

    return permissionName;
}

int HhmAdmin::getUserID(int user_index)
{
    QSqlQuery query = db->select("*", HHM_TABLE_USER);
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
    QVariant data = query.value(HHM_USER_ID);
    int userID = data.toInt();

    return userID;
}

int HhmAdmin::getRoleID(int role_index)
{
    QSqlQuery query = db->selectOrder("*", HHM_TABLE_ROLE, HHM_ROLE_ID);

    for( int i=0 ; i<role_index ; i++ )
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
    QVariant data = query.value(HHM_ROLE_ID);
    int roleID = data.toInt();
    qDebug() << "getRoleID" << roleID;

    return roleID;
}

void HhmAdmin::setUserDepartment(int user_index, int department_index)
{
    int user_id = getUserID(user_index);
    int department_id = m_adepartment->getDepartmentID(department_index+1);

    QString condition = "(`id` = '" + QString::number(user_id) + "')";
    QString values = "`department_id` = '" + QString::number(department_id) + "'";
    db->update(condition, values, "user");
}

void HhmAdmin::setRolePermission(int role_id, int permission_id, int value)
{
    QString column_name;
    QString condition = "`id` = '" + QString::number(role_id) + "'";

    if( permission_id==1 )
    {
        column_name = HHM_ROLE_PERMISSION1;
    }
    else if( permission_id==2 )
    {
        column_name = HHM_ROLE_PERMISSION2;
    }
    else if( permission_id==3 )
    {
        column_name = HHM_ROLE_PERMISSION3;
    }
    else if( permission_id==4 )
    {
        column_name = HHM_ROLE_PERMISSION4;
    }
    else if( permission_id==5 )
    {
        column_name = HHM_ROLE_PERMISSION5;
    }
    else if( permission_id==6 )
    {
        column_name = HHM_ROLE_PERMISSION6;
    }
    else if( permission_id==7 )
    {
        column_name = HHM_ROLE_PERMISSION7;
    }
    else if( permission_id==8 )
    {
        column_name = HHM_ROLE_PERMISSION8;
    }
    else if( permission_id==9 )
    {
        column_name = HHM_ROLE_PERMISSION9;
    }
    else
    {
        qDebug() << "Permission ID not supported";
    }

    QString values = "`" + column_name + "` = '" + QString::number(value) + "'";
    db->update(condition, values, HHM_TABLE_ROLE);
}

void HhmAdmin::addUserRole(int user_index, int role_index)
{
    int user_id = getUserID(user_index+1);
    int role_id = getRoleID(role_index);
    QSqlQuery res_ur = db->select("*", "user_role");

    QSqlRecord rec_ur = res_ur.record();
    int count_ur = res_ur.size();

    QString table = HHM_TABLE_JOIN_USER_ROLE;
    QString columns = "`id`, `user_id`, `department_id`, `role_id`";
    QString values = "'" + QString::number(count_ur+1) + "', '" + QString::number(user_id) + "', '-1', '" + QString::number(role_id) +"'";
    db->insert(table, columns, values);
}

void HhmAdmin::getRoles()
{
    QSqlQuery query = db->selectOrder("*", HHM_TABLE_ROLE, "id");

    QSqlRecord rec = query.record();
    int count = query.size();
    QString column_s;
    int return_val[9];

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant data = query.value("role_name");
            QString permissionName = data.toString();
            m_arole->getPermmissionsA(query, return_val);

            QQmlProperty::write(roles_ui, "permission_name", permissionName);
            QQmlProperty::write(roles_ui, "cpp_permission1", return_val[0]);
            QQmlProperty::write(roles_ui, "cpp_permission2", return_val[1]);
            QQmlProperty::write(roles_ui, "cpp_permission3", return_val[2]);
            QQmlProperty::write(roles_ui, "cpp_permission4", return_val[3]);
            QQmlProperty::write(roles_ui, "cpp_permission5", return_val[4]);
            QQmlProperty::write(roles_ui, "cpp_permission6", return_val[5]);
            QQmlProperty::write(roles_ui, "cpp_permission7", return_val[6]);
            QQmlProperty::write(roles_ui, "cpp_permission8", return_val[7]);
            QQmlProperty::write(roles_ui, "cpp_permission9", return_val[8]);
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
    QSqlQuery query = db->selectOrder("*", "departments", "id");

    int count = query.size();
    QString column_s;

    query.next();
    for( int i=1 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant data = query.value("department_name");
            QString departmentName = data.toString();
            QQmlProperty::write(departments_ui, "department_name", departmentName);
            QMetaObject::invokeMethod(departments_ui, "addDepartment");

            QQmlProperty::write(departments_ui, "group_name", departmentName);
            QMetaObject::invokeMethod(departments_ui, "addSelectGroup");

            QQmlProperty::write(users_ui, "department_name", departmentName);
            QMetaObject::invokeMethod(users_ui, "addDeprtment");
        }
        else
        {
            qDebug() << "error getDepartment";
        }
    }
}

void HhmAdmin::getUsers()
{
    QSqlQuery res = db->selectOrder("*", "user", "id");

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

            QVariant department_name_v = res.value("department_id");
            int department_id = department_name_v.toInt();
            QString department_name = m_adepartment->getDepartmentName(department_id);

            QQmlProperty::write(users_ui, "user_username", username);
            QQmlProperty::write(users_ui, "user_name", name);
            QQmlProperty::write(users_ui, "department_name", department_name);
            QMetaObject::invokeMethod(users_ui, "addUser");
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


