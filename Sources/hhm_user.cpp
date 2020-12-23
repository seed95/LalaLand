#include "hhm_user.h"

HhmUser::HhmUser(QObject *item, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    db = database;
}

void HhmUser::loadUser(QString username)
{
    uname = username;
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USERS, condition);
    QStringList result;

    int count = res.record().count();
    if(res.next())
    {
        for( int i=0 ; i<count ; i++ )
        {
            QVariant data = res.value(HHM_USER_FIRSTNAME);
            if(data.isValid())
            {
                fname = data.toString();
            }

            data = res.value(HHM_USER_LASTNAME);
            if(data.isValid())
            {
                lname = data.toString();
            }

            data = res.value(HHM_USER_ID);
            if(data.isValid())
            {
                id = data.toInt();
            }
        }
    }
    else
    {
        qDebug() << "Can't load user" << username;
    }

}
