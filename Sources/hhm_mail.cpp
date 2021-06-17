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
        hhm_log("user with username `" + username + "` not found in database");
    }
}

void HhmMail::approveDoc(int caseNumber, QString tableContent, QString emailId)
{
    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" + QString::number(caseNumber);
    QString values = "`" + QString(HHM_DOCUMENT_STATUS) + "`='" + QString::number(HHM_DOC_STATUS_SUCCESS) + "'";

    QStringList table_content = tableContent.split(",");
    values += ", `" + QString(HHM_DOCUMENT_DATA5) + "`='" + table_content[0] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA6) + "`='" + table_content[1] + "'";

    db->update(condition, values, HHM_TABLE_DOCUMENT);
    QString msg = "تم العملية بنجاح";
    hhm_showMessage(msg, 3000);
    showEmailInSidebar(QStringList(emailId));
}

void HhmMail::rejectDoc(int caseNumber)
{
    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" + QString::number(caseNumber);
    QString value = "`" + QString(HHM_DOCUMENT_STATUS) + "`=\"" + QString::number(HHM_DOC_STATUS_REJECT) + "\"";
    db->update(condition, value, HHM_TABLE_DOCUMENT);
}

void HhmMail::sendNewEmail(QString caseNumber, QString subject,
                           int senderId, int receiverId,
                           QString filepath, QString senderName,
                           QString tableContent)
{

    updateDocument(caseNumber, filepath,
                   senderId, receiverId,
                   subject, senderName,
                   tableContent);

    int received_email_id = addNewEmail(caseNumber);
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

//input in csv format
void HhmMail::showEmailInSidebar(QStringList emailIds)
{
    QString query = "";
    for(int i=0; i<emailIds.size(); i++)
    {
        HhmEmailTable email = getEmail(emailIds.at(i).toInt());

        QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" + QString::number(email.docCasenumber);
        QSqlQuery res = db->select("*", HHM_TABLE_DOCUMENT, condition);
        if(res.next())
        {
            QVariant data = res.value(HHM_DOCUMENT_CASENUMBER);
            if( data.isValid() )
            {
                QQmlProperty::write(ui, "case_number", data.toInt());
            }

            data = res.value(HHM_DOCUMENT_SENDER_NAME);
            if( data.isValid() )
            {
                QQmlProperty::write(ui, "sender_name", data.toString());
            }

            data = res.value(HHM_DOCUMENT_SUBJECT);
            if( data.isValid() )
            {
                QQmlProperty::write(ui, "subject", data.toString());
            }

            data = res.value(HHM_DOCUMENT_FILEPATH);
            if( data.isValid() )
            {
                QQmlProperty::write(ui, "filepath", data.toString());
            }

            data = res.value(HHM_DOCUMENT_STATUS);
            if( data.isValid() )
            {
                QQmlProperty::write(ui, "doc_status", data.toInt());
            }

            data = res.value(HHM_DOCUMENT_DATE);
            if( data.isValid() )
            {
                QString date;
                if( hhm_rtlIsEnable() )
                {
                    QLocale ar_locale(QLocale::Arabic);
                    date = ar_locale.toString(data.toDateTime(), "hh:mm");
                }
                else
                {
                    date = data.toDateTime().toString("hh:mmAP");
                }
                QQmlProperty::write(ui, "r_email_date", date);
            }

            data = res.value(HHM_DOCUMENT_SENDER_ID);
            if( data.isValid() )
            {
                HhmUserTable sender_user = getUser(data.toInt());
                QQmlProperty::write(ui, "sender_username", sender_user.username);
            }

            data = res.value(HHM_DOCUMENT_RECEIVER_IDS);
            if( data.isValid() )
            {
                QStringList receiver_names;
                QStringList receiver_ids = data.toString().split(",", QString::SkipEmptyParts);
                for(int i=0; i<receiver_ids.length(); i++)
                {
                    HhmUserTable receiver_user = getUser(receiver_ids[i].toInt());

                    receiver_names.append(receiver_user.firstname + " " + receiver_user.lastname);
                }
                QString separator = ",";
                if( hhm_rtlIsEnable() )
                {
                    separator = "،";
                }
                QQmlProperty::write(ui, "receiver_names", receiver_names.join(separator));
            }

            QQmlProperty::write(ui, "id_email_in_emails_table", emailIds.at(i));
            QQmlProperty::write(ui, "email_opened", email.opened==1);

            QStringList table_content;
            data = res.value(HHM_DOCUMENT_DATA1);
            table_content.append(data.toString());

            data = res.value(HHM_DOCUMENT_DATA2);
            table_content.append(data.toString());

            data = res.value(HHM_DOCUMENT_DATA3);
            table_content.append(data.toString());

            data = res.value(HHM_DOCUMENT_DATA4);
            table_content.append(data.toString());

            data = res.value(HHM_DOCUMENT_DATA5);
            table_content.append(data.toString());

            data = res.value(HHM_DOCUMENT_DATA6);
            table_content.append(data.toString());
            QQmlProperty::write(ui, "table_content", table_content.join(","));

            QQmlProperty::write(ui, "email_opened", email.opened==1);

            QMetaObject::invokeMethod(ui, "addToBox");

        }
    }
}

HhmEmailTable HhmMail::getEmail(int idEmail)
{
    QString condition = "`" + QString(HHM_EMAIL_ID) + "`=" + QString::number(idEmail);
    QSqlQuery res = db->select("*", HHM_TABLE_EMAIL, condition);
    HhmEmailTable email;
    if( res.next() )
    {
        email.emailId = idEmail;
        QVariant data = res.value(HHM_EMAIL_DOC_CASENUMBER);
        if(data.isValid())
        {
            email.docCasenumber = data.toInt();
        }

        data = res.value(HHM_EMAIL_FLAG);
        if(data.isValid())
        {
            email.flag = data.toInt();
        }

        data = res.value(HHM_EMAIL_OPENED);
        if(data.isValid())
        {
            email.opened = data.toInt();
        }

        data = res.value(HHM_EMAIL_OPEN_TIME);
        if(data.isValid())
        {
            email.date = data.toDateTime();
        }

    }
    return email;
}

HhmUserTable HhmMail::getUser(int idUser)
{
    QString condition = "`" + QString(HHM_USER_ID) + "`=" + QString::number(idUser);
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    HhmUserTable user;
    if( res.next() )
    {
        user.userId = idUser;
        QVariant data = res.value(HHM_USER_FIRSTNAME);
        if( data.isValid() )
        {
            user.firstname = data.toString();
        }

        data = res.value(HHM_USER_LASTNAME);
        if( data.isValid() )
        {
            user.lastname = data.toString();
        }

        data = res.value(HHM_USER_USERNAME);
        if( data.isValid() )
        {
            user.username = data.toString();
        }

    }
    return user;
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

void HhmMail::updateDocument(QString caseNumber, QString filepath,
                            int senderId, int receiverId,
                            QString subject, QString senderName,
                            QString tableContent)
{
    QLocale locale(QLocale::English);
    QString date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");

    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`='" + caseNumber + "'";
    QString values = "`" + QString(HHM_DOCUMENT_FILEPATH) + "`='" + filepath + "'";
    values += ", `" + QString(HHM_DOCUMENT_SENDER_ID) + "`='" + QString::number(senderId) + "'";
    values += ", `" + QString(HHM_DOCUMENT_RECEIVER_IDS) + "`='" + QString::number(receiverId) + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATE) + "`='" + date + "'";
    values += ", `" + QString(HHM_DOCUMENT_SENDER_NAME) + "`='" + senderName + "'";
    values += ", `" + QString(HHM_DOCUMENT_SUBJECT) + "`='" + subject + "'";

    QStringList table_content = tableContent.split(",");
    values += ", `" + QString(HHM_DOCUMENT_DATA1) + "`='" + table_content[0] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA2) + "`='" + table_content[1] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA3) + "`='" + table_content[2] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA4) + "`='" + table_content[3] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA5) + "`='" + table_content[4] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA6) + "`='" + table_content[5] + "'";

    db->update(condition, values, HHM_TABLE_DOCUMENT);
}

//Insert new mail into HHM_TABLE_EMAIL
//and return received mail id
int HhmMail::addNewEmail(QString caseNumber)
{
    QString columns  = "`" + QString(HHM_EMAIL_DOC_CASENUMBER) + "`, ";
    columns += "`" + QString(HHM_EMAIL_SEND_REFERENCE) + "`, ";
    columns += "`" + QString(HHM_EMAIL_RECEIVE_REFERENCE) + "`";

    QString values  = "'" + caseNumber + "', ";
    values += "'" + QString::number(1) + "', ";
    values += "'" + QString::number(0) + "'";
    db->insert(HHM_TABLE_EMAIL, columns, values);

    values  = "'" + caseNumber + "', ";
    values += "'" + QString::number(0) + "', ";
    values += "'" + QString::number(1) + "'";
    db->insert(HHM_TABLE_EMAIL, columns, values);

    //Get id emails
    QString query = "SELECT MAX(" + QString(HHM_EMAIL_ID) + ") FROM `";
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
