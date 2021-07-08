#include "hhm_admin_permissions.h"
#include <QTimer>
#include <QThread>

HhmAdminPermissions::HhmAdminPermissions(QObject *root, HhmDatabase *database, QObject *parent): QObject(parent)
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
    qDebug() << count;
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

