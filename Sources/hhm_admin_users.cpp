#include "hhm_admin_users.h"
#include <QTimer>
#include <QThread>

HhmAdminUsers::HhmAdminUsers(QObject *root, HhmDatabase *database, QObject *parent): QObject(parent)
{
    db = database;
    timer = new QTimer();

    departments_ui = root->findChild<QObject*>("AdminDepartments");
    roles_ui = root->findChild<QObject*>("AdminRoles");
    users_ui = root->findChild<QObject*>("AdminUsers");

    connect(users_ui, SIGNAL(removeUserRole(int, QString)),
            this, SLOT(removeUserRole(int, QString)));

    connect(timer, SIGNAL(timeout()), this, SLOT(qmlComplete()));

    timer->setSingleShot(true);
    timer->start(100);
}

HhmAdminUsers::~HhmAdminUsers()
{
    ;
}

void HhmAdminUsers::qmlComplete()
{
    readTags();
}

void HhmAdminUsers::removeUserRole(int user_index, QString role_name)
{
    int user_id = getUserID(user_index);
    int role_id = getRoleID(role_name);

    QSqlQuery query = db->select("*", "user_role");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant user_id_v = query.value("user_id");
            int userID = user_id_v.toInt();

            if( userID == user_id)
            {
                QVariant role_id_v = query.value("role_id");
                int roleID = role_id_v.toInt();

                if( roleID == role_id)
                {
                    QVariant id_v = query.value("id");
                    int id = id_v.toInt();

                    db->remove("user_role", "id", QString::number(id));
                }
            }
        }
        else
        {
            qDebug() << "error getDepartments";
        }
    }
}

void HhmAdminUsers::readTags()
{
    QSqlQuery query = db->select("*", "user_role");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant data = query.value("role_id");
            int role_id = data.toInt();

            QVariant user_id_v = query.value("user_id");
            int user_id = user_id_v.toInt();

            if( role_id!=-1 )
            {
                readTagUser(user_id, role_id);
            }
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
}

void HhmAdminUsers::readTagUser(int user_id, int role_id)
{
    int user_index = getUserIndex(user_id);

    QSqlQuery query = db->select("*", "roles");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant data = query.value("role_name");
            QString  role_name = data.toString();

            QVariant data_role_id = query.value("id");
            int roleID = data_role_id.toInt();

            if( roleID==role_id )
            {
                setUiTag(user_index, role_name);
            }
        }
        else
        {
            qDebug() << "error getRoles";
        }
    }
}

void HhmAdminUsers::setUiTag(int user_index, QString tag_name)
{
    QQmlProperty::write(users_ui, "user_index", user_index);
    QQmlProperty::write(users_ui, "tag_name", tag_name);
    QMetaObject::invokeMethod(users_ui, "addTag");
}

int HhmAdminUsers::getUserIndex(int user_id)
{
    QSqlQuery query = db->selectOrder("*", "user", "id");

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

int HhmAdminUsers::getUserID(int user_index)
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

int HhmAdminUsers::getRoleID(QString role_name)
{
    QSqlQuery query = db->selectOrder("*", "roles", "id");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant role_name_v = query.value("role_name");
            QString roleName = role_name_v.toString();

            if( role_name == roleName)
            {
                QVariant role_id_v = query.value("id");
                int roleID = role_id_v.toInt();

                return roleID;
            }
        }
        else
        {
            qDebug() << "error getDepartments";
        }
    }

    return -1;
}

bool HhmAdminUsers::isRoleExist(int user_id, int role_id)
{
    QSqlQuery query = db->select("*", "user_role");
    int count = query.size();

    for( int i=0 ; i<count ; i++ )
    {
        if( query.next() )
        {
            QVariant user_id_v = query.value("user_id");
            int userID = user_id_v.toInt();

            if( userID == user_id)
            {
                QVariant role_id_v = query.value("role_id");
                int roleID = role_id_v.toInt();

                if( roleID == role_id)
                {
                    return true;
                }
            }
        }
        else
        {
            qDebug() << "error getDepartments";
        }
    }
    return false;
}
