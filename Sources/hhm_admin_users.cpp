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

void HhmAdminUsers::readTags()
{
    QSqlQuery query = db->select("*", "user_role");
    int count = query.size();
    qDebug() << count;

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



