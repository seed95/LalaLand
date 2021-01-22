#include "hhm_mail.h"

HhmMail::HhmMail(QObject *item, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    ui = item;
    db = database;
}

void HhmMail::loadInboxEmails(int idUser)
{
    showEmailInSidebar(getIdReceivedEmails(idUser));
}

void HhmMail::loadOutboxEmails(int idUser)
{
    showEmailInSidebar(getIdSendEmails(idUser));
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

void HhmMail::approveDoc(int caseNumber)
{
    QString condition = "`" + QString(HHM_DOCUMENTS_DOCID) + "`=" + QString::number(caseNumber);
    QString value = "`" + QString(HHM_DOCUMENTS_STATUS) + "`=\"" + QString::number(HHM_DOC_STATUS_SUCCESS) + "\"";
    db->update(condition, value, HHM_TABLE_DOCUMENT);
}

void HhmMail::rejectDoc(int caseNumber)
{
    QString condition = "`" + QString(HHM_DOCUMENTS_DOCID) + "`=" + QString::number(caseNumber);
    QString value = "`" + QString(HHM_DOCUMENTS_STATUS) + "`=\"" + QString::number(HHM_DOC_STATUS_REJECT) + "\"";
    db->update(condition, value, HHM_TABLE_DOCUMENT);
}

//input in csv format
void HhmMail::showEmailInSidebar(QStringList emailIds)
{
    QString query = "";
    for(int i=0; i<emailIds.size(); i++)
    {
        HhmEmailTable email = getEmail(emailIds.at(i).toInt());

        QString condition = "`" + QString(HHM_DOCUMENTS_ID) + "`=" + QString::number(email.documentId);
        QSqlQuery res = db->select("*", HHM_TABLE_DOCUMENT, condition);
        if(res.next())
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

            data = res.value(HHM_DOCUMENTS_FILEPATH);
            if(data.isValid())
            {
                QQmlProperty::write(ui, "filepath", data.toString());
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

            QQmlProperty::write(ui, "id_email_in_emails_table", emailIds.at(i));
            QQmlProperty::write(ui, "email_opened", email.opened==1);

            QMetaObject::invokeMethod(ui, "addToBox");

        }
    }
}

HhmEmailTable HhmMail::getEmail(int idEmail)
{
    QString condition = "`" + QString(HHM_EMAILS_ID) + "`=" + QString::number(idEmail);
    QSqlQuery res = db->select("*", HHM_TABLE_EMAIL, condition);
    HhmEmailTable email;
    if(res.next())
    {
        email.emailId = idEmail;
        QVariant data = res.value(HHM_EMAILS_DOCID);
        if(data.isValid())
        {
            email.documentId = data.toInt();
        }

        data = res.value(HHM_EMAILS_FLAG);
        if(data.isValid())
        {
            email.flag = data.toInt();
        }

        data = res.value(HHM_EMAILS_OPENED);
        if(data.isValid())
        {
            email.opened = data.toInt();
        }

        data = res.value(HHM_EMAILS_OPEN_TIME);
        if(data.isValid())
        {
            email.date = data.toDateTime();
        }

    }
    return email;
}

//return in csv format
QStringList HhmMail::getIdReceivedEmails(int userID)
{
    int month = (QDate::currentDate().year() - HHM_START_YEAR)*12 + QDate::currentDate().month();
    QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(userID);
//    condition += " AND `" + QString(HHM_UE_DATE) + "`=" + QString::number(month);
    QSqlQuery res = db->select(HHM_UE_RECEIVED_EMAILS, HHM_TABLE_USER_EMAIL, condition);
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
//    condition += " AND `" + QString(HHM_UE_DATE) + "`=" + QString::number(month);
    QSqlQuery res = db->select(HHM_UE_SENT_EMAILS, HHM_TABLE_USER_EMAIL, condition);
    QStringList result;
    if(res.next())
    {
        result = res.value(0).toString().split(",");
        result.removeAll(QString(""));
        return result;
    }
    return result;
}
