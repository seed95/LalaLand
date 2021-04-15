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

void HhmMail::sendNewEmail(QString caseNumber, QString subject,
                           int senderId, int receiverId,
                           QString filepath, QString senderName)
{
    if( !filepath.isEmpty() )
    {
        int doc_id = addNewDocument(caseNumber, filepath,
                                    senderId, receiverId,
                                    subject, senderName);

        int received_email_id = addNewEmail(doc_id);
        int sent_email_id = received_email_id - 1;

        if( !updateEmail(HHM_UE_SENT_EMAILS, senderId, sent_email_id) )
        {
            hhm_log("Error: error for updating sent emails in table " HHM_TABLE_USER_EMAIL);
        }
        if( !updateEmail(HHM_UE_RECEIVED_EMAILS, receiverId, received_email_id) )
        {
            hhm_log("Error: error for updating received mails in table " HHM_TABLE_USER_EMAIL);
        }

    }
    else
    {
        qDebug() << "document is empty";
    }
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

//return true if case number already exist
bool HhmMail::checkCaseNumber(QString caseNumber)
{
    ///FIXME:check case number arabic qstring
    QString condition = "`" + QString(HHM_DOCUMENTS_DOCID) + "`=" + caseNumber;
    QSqlQuery res = db->select("*", HHM_TABLE_DOCUMENT, condition);
    return res.size()!=0;
}

//Insert new document into HHM_TABLE_DOCUMENT
//and return document id
int HhmMail::addNewDocument(QString caseNumber, QString filepath,
                            int senderId, int receiverId,
                            QString subject, QString senderName)
{
    QString columns = "`" + QString(HHM_DOCUMENTS_FILEPATH) + "`, ";
    columns += "`" + QString(HHM_DOCUMENTS_SENDER_ID) + "`, ";
    columns += "`" + QString(HHM_DOCUMENTS_RECEIVER_IDS) + "`, ";
    columns += "`" + QString(HHM_DOCUMENTS_DATE) + "`, ";
    columns += "`" + QString(HHM_DOCUMENTS_SENDER_NAME) + "`, ";
    columns += "`" + QString(HHM_DOCUMENTS_DOCID) + "`, ";
    columns += "`" + QString(HHM_DOCUMENTS_SUBJECT) + "`";

    QLocale locale(QLocale::English);
    QString date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");

    QString values = "'" + filepath + "', ";
    values += "'" + QString::number(senderId) + "', ";
    values += "'" + QString::number(receiverId) + "', ";
    values += "'" + date + "', ";
    values += "'" + senderName + "', ";
    ///FIXME:check case number arabic qstring
    values += "'" + caseNumber + "', ";
    values += "'" + subject + "'";
    db->insert(HHM_TABLE_DOCUMENT, columns, values);

    //Get id document
    QString query = "SELECT LAST_INSERT_ID();";
    QSqlQuery res = db->sendQuery(query);
    int doc_id = 0;
    if( res.next() )
    {
        doc_id = res.value(0).toInt();
    }
    return doc_id;
}

//Insert new mail into HHM_TABLE_EMAIL
//and return received mail id
int HhmMail::addNewEmail(int docId)
{
    QString columns  = "`" + QString(HHM_EMAILS_DOCID) + "`, ";
    columns += "`" + QString(HHM_EMAILS_SEND_REFERENCE) + "`, ";
    columns += "`" + QString(HHM_EMAILS_RECEIVE_REFERENCE) + "`";

    QString values  = "'" + QString::number(docId) + "', ";
    values += "'" + QString::number(1) + "', ";
    values += "'" + QString::number(0) + "'";
    db->insert(HHM_TABLE_EMAIL, columns, values);

    values  = "'" + QString::number(docId) + "', ";
    values += "'" + QString::number(0) + "', ";
    values += "'" + QString::number(1) + "'";
    db->insert(HHM_TABLE_EMAIL, columns, values);

    //Get id emails
    QString query = "SELECT MAX(" + QString(HHM_EMAILS_ID) + ") FROM `";
    query += QString(DATABASE_NAME) + "`.`" + QString(HHM_TABLE_EMAIL) + "`";
    QSqlQuery res = db->sendQuery(query);
    //first sent email id is 1, so first received email id is 2
    int received_email_id = 2;
    if( res.next() )
    {
        received_email_id = res.value(0).toInt();
    }

    return  received_email_id;
}

//Update sent-received emails in HHM_TABLE_USER_EMAIL
//return true if successfully update emails
bool HhmMail::updateEmail(QString field, int userId, int emailId)
{
    //update sent emails for sender
    QString fields = field;
    QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(userId);
    QSqlQuery res = db->select(fields, HHM_TABLE_USER_EMAIL, condition);
    if( res.next() )
    {
        QString sent_emails = res.value(0).toString();
        if( sent_emails.isEmpty() )
        {
            sent_emails = QString::number(emailId);
        }
        else
        {
            sent_emails += "," + QString::number(emailId);
        }
        condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(userId);
        QString value = "`" + QString(HHM_UE_SENT_EMAILS) + "`=\"" + sent_emails + "\"";
        db->update(condition, value, HHM_TABLE_USER_EMAIL);
        return true;
    }
    else
    {
        return false;
    }

}
