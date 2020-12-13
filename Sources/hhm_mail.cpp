#include "hhm_mail.h"
#include <QDate>

HhmMail::HhmMail(QObject *item, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    ui = item;
    db = database;

    loadReceivedEmails(1);
}


void HhmMail::loadReceivedEmails(int userID)
{

    QStringList received_emails = getIdReceivedEmails(userID).split(",");
    QString query = "";
    for(int i=0; i<received_emails.size(); i++)
    {
        QString condition = "`id`=" + received_emails.at(i);
        QSqlQuery res = db->select("doc_id", HHM_TABLE_EMAILS, condition);
        if(res.next())
        {
            QString condition = "`id`=" + res.value(0).toString();
            res = db->select("*", HHM_TABLE_DOCUMENTS, condition);
            db->printQuery(res);
//            if(res.next())
//            {
//            }
        }
    }


//    int month = (QDate::currentDate().year() - START_YEAR) * 12 + QDate::currentDate().month();
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
QString HhmMail::getIdReceivedEmails(int userID)
{
    int month = (QDate::currentDate().year() - START_YEAR)*12 + QDate::currentDate().month();
    QString condition = "`id`=" + QString::number(userID) + " AND `date`=" + QString::number(month);
    QSqlQuery res = db->select("`received_emails`", "user_emails", condition);
    if(res.next())
    {
        return res.value(0).toString();
    }
    return "";
}
