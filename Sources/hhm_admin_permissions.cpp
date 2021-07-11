#include "hhm_admin_permissions.h"
#include <QTimer>
#include <QThread>

HhmAdminPermissions::HhmAdminPermissions(QObject *root, HhmDatabase *database,
                                         QObject *parent): QObject(parent)
{
    db = database;
    timer = new QTimer();

    departments_ui = root->findChild<QObject*>("AdminDepartments");
    roles_ui = root->findChild<QObject*>("AdminRoles");
    users_ui = root->findChild<QObject*>("AdminUsers");

    connect(roles_ui, SIGNAL(removePermission(int)), this, SLOT(removeRole(int)));

    connect(timer, SIGNAL(timeout()), this, SLOT(qmlComplete()));

    timer->setSingleShot(true);
    timer->start(100);
}

HhmAdminPermissions::~HhmAdminPermissions()
{
    ;
}

void HhmAdminPermissions::qmlComplete()
{
    readRoles();
}

void HhmAdminPermissions::readRoles()
{
    QSqlQuery query = db->select("*", "roles");
    int count = query.size();
    int return_val[9];

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            getPermmissionsA(query, return_val);
            for( int j=0 ; j<HHM_MAX_PERMISSION ; j++ )
            {
                if( return_val[j]==1 )
                {
                    setPermissionUi(i, j);
                }
            }
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
}

void *HhmAdminPermissions::getPermmissionsA(QSqlQuery query, int *data)
{
    QVariant permission1_v = query.value("permission_1");
    data[0] = permission1_v.toInt();

    QVariant permission2_v = query.value("permission_2");
    data[1] = permission2_v.toInt();

    QVariant permission3_v = query.value("permission_3");
    data[2] = permission3_v.toInt();

    QVariant permission4_v = query.value("permission_4");
    data[3] = permission4_v.toInt();

    QVariant permission5_v = query.value("permission_5");
    data[4] = permission5_v.toInt();

    QVariant permission6_v = query.value("permission_6");
    data[5] = permission6_v.toInt();

    QVariant permission7_v = query.value("permission_7");
    data[6] = permission7_v.toInt();

    QVariant permission8_v = query.value("permission_8");
    data[7] = permission8_v.toInt();

    QVariant permission9_v = query.value("permission_9");
    data[8] = permission9_v.toInt();
}

void HhmAdminPermissions::setPermissionUi(int row, int column)
{
    QQmlProperty::write(roles_ui, "permission_row", row);
    QQmlProperty::write(roles_ui, "permission_column", column);
    QMetaObject::invokeMethod(roles_ui, "setPermission");
}

void HhmAdminPermissions::removeRole(int role_index)
{
    int role_id = getRoleID(role_index+1);
    removeUserRole(role_id); //set user role to NULL

    QString table = "roles";
    QString columns = "id";
    QString values = QString::number(role_id);
    db->remove(table, columns, values);
}

int  HhmAdminPermissions::getRoleIndex(int permisson_id)
{
    QSqlQuery query = db->selectOrder("*", "roles", "id");

    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant id_v = query.value("id");
            int id = id_v.toInt();

            if( permisson_id==id )
            {
                return  i;
            }
        }
        else
        {
            qDebug() << "error getRoleIndex";
        }
    }

    return -1;
}

int HhmAdminPermissions::getRoleID(int permission_index)
{
    QSqlQuery query = db->selectOrder("*", "roles", "id");
    QSqlRecord rec_r = query.record();

    for( int i=0 ; i<permission_index ; i++ )
    {
        if( query.next() )
        {
            ;///FIXME: A Bug Lies Here (Bijan)
        }
        else
        {
            qDebug() << "error getRoleID";
        }
    }
    QVariant data = query.value("id");
    int permissionID = data.toInt();

    return permissionID;
}

void HhmAdminPermissions::removeUserRole(int role_id)
{
    //remove all role tags from ui
    QString role_name = getRoleName(role_id);
    QQmlProperty::write(users_ui, "role", role_name);
    QMetaObject::invokeMethod(users_ui, "removeRoleTable");

    QString table = "user_role";
    QString columns = "role_id";
    QString values = QString::number(role_id);
    db->remove(table, columns, values);
}

QString HhmAdminPermissions::getRoleName(int role_id)
{
    QSqlQuery query = db->selectOrder("*", "roles", "id");
    QSqlRecord rec_r = query.record();

    for( int i=0 ; i<role_id ; i++ )
    {
        if( query.next() )
        {
            QVariant id_v = query.value("id");
            int id = id_v.toInt();

            if( id==role_id )
            {
                QVariant role_name_v = query.value("role_name");
                QString role_name = role_name_v.toString();

                return role_name;
            }
        }
        else
        {
            qDebug() << "error getRoleID";
        }
    }

    QVariant data = query.value("role_name");
    QString permissionID = data.toString();

    return permissionID;
}

int HhmAdminPermissions::getLastUserRoleId()
{
    QSqlQuery query = db->selectOrder("*", "user_role", "id");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            ;///FIXME: A Bug Lies Here (Bijan)
        }
        else
        {
            qDebug() << "error getRoleID";
        }
    }
    QVariant userRoleID_v = query.value("id");
    int user_role_id = userRoleID_v.toInt();

    return user_role_id;
}

int HhmAdminPermissions::getLastRolesId()
{
    QSqlQuery query = db->selectOrder("*", "roles", "id");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            ;///FIXME: A Bug Lies Here (Bijan)
        }
        else
        {
            qDebug() << "error getLastUserRoleId";
        }
    }
    QVariant roles_id_v = query.value("id");
    int role_id = roles_id_v.toInt();

    return role_id;
}
