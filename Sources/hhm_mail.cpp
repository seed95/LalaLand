#include "hhm_mail.h"

HhmMail::HhmMail(QObject *item, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    ui = item;
    db = database;

    loadReceivedEmails(102);
}

void HhmMail::loadReceivedEmails(int userID)
{

    QStringList received_emails = getIdReceivedEmails(userID);
    QString query = "";
    for(int i=0; i<received_emails.size(); i++)
    {
        QString condition = "`id`=" + received_emails.at(i);
        QSqlQuery res = db->select("doc_id", HHM_TABLE_EMAILS, condition);
        if(res.next())
        {
            QString condition = "`id`=" + res.value(0).toString();
            res = db->select("*", HHM_TABLE_DOCUMENTS, condition);
            int num_rec = res.record().count(); //Number of record
//            db->printQuery(res);
            while(res.next())
            {
                QVariant data = res.value(HHM_DOCUMENTS_SENDER_NAME);
                if(data.isValid())
                {
                    QQmlProperty::write(ui, "r_email_sender_name", data.toString());
                }
                data = res.value(HHM_DOCUMENTS_DATE);
                if(data.isValid())
                {
                    QString datetime = data.toDateTime().toString("hh:mmAP");
                    QQmlProperty::write(ui, "r_email_date", datetime);
                }

                QMetaObject::invokeMethod(ui, "receivedNewEmail");

            }
        }
    }


//    int month = (QDate::currentDate().year() - HHM_START_YEAR) * 12 + QDate::currentDate().month();
//    QString query = "SELECT (`received_emails`) FROM `"DATABASE_NAME"`.`user_emails` ";
//    query += "WHERE `id`=" + QString::number(userID) + " AND `date`=" + QString::number(month);
//    QSqlQuery res = db->sendQuery(query);
////    db->printQuery(res);
//    if(res.next())
//    {
//        qDebug() << res.value(0).toString();
//        QStringList received_emails = res.value(0).toString().split(",");
//        query = "SELECT (`doc_id`) FROM `"DATABASE_NAME"`.`emails` WHERE";
//        for(int i=0; i<received_emails.size(); i++)
//        {
//            query += " `id`=" + received_emails.at(i);
//            if( i<(received_emails.size()-1) )
//            {
//                query += " OR";
//            }
//        }
//        query += ";";
//    }
//    res = db->sendQuery(query);
//    query = "SELECT firstname_sender,lastname_sender FROM `"DATABASE_NAME"`.`documents` WHERE";
//    QString doc_ids = "";
//    res.next();
//    for(int i=0; i<res.size(); i++)
//    {
//        doc_ids += " `id`=" + res.value(0).toString();
//        if(res.next())
//        {
//            doc_ids += " OR";
//        }
//    }
//    query += doc_ids;
//    res = db->sendQuery(query);
//    while(res.next())
//    {
//        for(int i=0; i<res.record().count(); i++)
//        {
//            qDebug() << res.value(i);
//        }
//    }

//    db.sendQuery()
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
