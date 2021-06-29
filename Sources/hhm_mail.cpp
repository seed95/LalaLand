#include "hhm_mail.h"

HhmMail::HhmMail(QObject *item, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    ui = item;
    db = database;
}


//Update sent-received emails in HHM_TABLE_USER_EMAIL
//return true if successfully update emails
bool HhmMail::updateEmail(QString field, int userId, int emailId)
{
    QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(userId);
    QSqlQuery res = db->select(field, HHM_TABLE_USER_EMAIL, condition);
    if( res.next() )
    {
        QString emails = res.value(0).toString();
        if( emails.isEmpty() )
        {
            emails = QString::number(emailId);
        }
        else
        {
            emails = QString::number(emailId) + "," + emails;
        }
        condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(userId);
        QString value = "`" + QString(field) + "`='" + emails + "'";
        db->update(condition, value, HHM_TABLE_USER_EMAIL);
        return true;
    }
    else
    {
        return false;
    }

}
