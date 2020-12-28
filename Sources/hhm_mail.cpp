#include "hhm_mail.h"

HhmMail::HhmMail(QObject *item, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    ui = item;
    db = database;
}

void HhmMail::loadEmails(QString username)
{
    int id_user = db->getId(username);
    if( id_user!=-1 )
    {
        showEmailInSidebar(getIdReceivedEmails(id_user));
        showEmailInSidebar(getIdSendEmails(id_user));
    }
    else
    {
        qDebug() << "user with username`" << username << "` not found in database";
    }
}

//input in csv format
void HhmMail::showEmailInSidebar(QStringList emailIds)
{
    QString query = "";
    for(int i=0; i<emailIds.size(); i++)
    {
        QString condition = "`" + QString(HHM_EMAILS_ID) + "`=" + emailIds.at(i);
        QSqlQuery res = db->select(HHM_EMAILS_DOCID, HHM_TABLE_EMAILS, condition);
        if(res.next())
        {
            QString condition = "`" + QString(HHM_DOCUMENTS_ID) + "`=" + res.value(0).toString();
            res = db->select("*", HHM_TABLE_DOCUMENTS, condition);
//            db->printQuery(res);
            while(res.next())
            {
                QVariant data = res.value(HHM_DOCUMENTS_DOCID);
                if(data.isValid())
                {
                    QQmlProperty::write(ui, "case_number", data.toInt());
                }

                data = res.value(HHM_DOCUMENTS_SENDER_NAME);
                if(data.isValid())
                {
                    QQmlProperty::write(ui, "sender_name", data.toString());
                }

                data = res.value(HHM_DOCUMENTS_SUBJECT);
                if(data.isValid())
                {
                    QQmlProperty::write(ui, "subject", data.toString());
                }

                data = res.value(HHM_DOCUMENTS_STATUS);
                if(data.isValid())
                {
                    QQmlProperty::write(ui, "doc_status", data.toInt());
                }

                data = res.value(HHM_DOCUMENTS_DATE);
                if(data.isValid())
                {
                    QString datetime = data.toDateTime().toString("hh:mmAP");
                    QQmlProperty::write(ui, "r_email_date", datetime);
                }

                QMetaObject::invokeMethod(ui, "addToInbox");

            }
        }
    }
}

//return in csv format
QStringList HhmMail::getIdReceivedEmails(int userID)
{
    int month = (QDate::currentDate().year() - HHM_START_YEAR)*12 + QDate::currentDate().month();
    QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(userID);
    condition += " AND `" + QString(HHM_UE_DATE) + "`=" + QString::number(month);
    QSqlQuery res = db->select(HHM_UE_RECEIVED_EMAILS, HHM_TABLE_USER_EMAILS, condition);
    QStringList result;
    if(res.next())
    {
        result = res.value(0).toString().split(",");
        result.removeAll(QString(""));
        return result;
    }
    return result;
}

//return in csv format
QStringList HhmMail::getIdSendEmails(int userID)
{
    int month = (QDate::currentDate().year() - HHM_START_YEAR)*12 + QDate::currentDate().month();
    QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(userID);
    condition += " AND `" + QString(HHM_UE_DATE) + "`=" + QString::number(month);
    QSqlQuery res = db->select(HHM_UE_SENT_EMAILS, HHM_TABLE_USER_EMAILS, condition);
    QStringList result;
    if(res.next())
    {
        result = res.value(0).toString().split(",");
        result.removeAll(QString(""));
        return result;
    }
    return result;
}
