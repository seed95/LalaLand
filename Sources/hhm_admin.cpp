#include "hhm_admin.h"

HhmAdmin::HhmAdmin(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                       QObject *parent) : QObject(parent)
{
    db = database;
    m_user = userLoggedIn;

    admin_ui = root->findChild<QObject*>("Admin");

    connect(admin_ui, SIGNAL(checkBoxChanged(int, int, int)), this, SLOT(changePermission(int, int, int)));
    connect(admin_ui, SIGNAL(crtePermission(QString)), this, SLOT(addNewPermission(QString)));
}

HhmAdmin::~HhmAdmin()
{
    ;
}

void HhmAdmin::addNewPermission(QString permission)
{
    qDebug() << permission;
}

void HhmAdmin::changePermission(int permission, int userID, int value)
{
    qDebug() << permission << userID << value;
}
