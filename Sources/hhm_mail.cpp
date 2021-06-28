#include "hhm_mail.h"

HhmMail::HhmMail(QObject *item, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    ui = item;
    db = database;
}


void HhmMail::approveDoc(int caseNumber, QString tableContent, QString emailId)
{
//    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" + QString::number(caseNumber);
//    QString values = "`" + QString(HHM_DOCUMENT_STATUS) + "`='" + QString::number(HHM_DOC_STATUS_SUCCESS) + "'";

//    QStringList table_content = tableContent.split(",");
//    values += ", `" + QString(HHM_DOCUMENT_DATA5) + "`='" + table_content[0] + "'";
//    values += ", `" + QString(HHM_DOCUMENT_DATA6) + "`='" + table_content[1] + "'";

//    db->update(condition, values, HHM_TABLE_DOCUMENT);
//    QString msg = "تم العملية بنجاح";
//    hhm_showMessage(msg, 3000);
//    showEmailInSidebar(QStringList(emailId));
}

void HhmMail::rejectDoc(int caseNumber)
{
    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" + QString::number(caseNumber);
    QString value = "`" + QString(HHM_DOCUMENT_STATUS) + "`=\"" + QString::number(HHM_DOC_STATUS_REJECT) + "\"";
    db->update(condition, value, HHM_TABLE_DOCUMENT);
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
