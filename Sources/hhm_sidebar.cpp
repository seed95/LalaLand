#include "hhm_sidebar.h"

HhmSidebar::HhmSidebar(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                       QObject *parent) : QObject(parent)
{
    db = database;
    m_user = userLoggedIn;

    main_ui = root->findChild<QObject*>("Sidebar");
    list_ui = root->findChild<QObject*>("SidebarList");

    connect(main_ui, SIGNAL(syncInbox()), this, SLOT(syncInbox()));
    connect(main_ui, SIGNAL(syncOutbox()), this, SLOT(syncOutbox()));

    connect(list_ui, SIGNAL(documentClicked(int)), this, SLOT(documentClicked(int)));
    connect(list_ui, SIGNAL(documentOpened(int, int)), this, SLOT(documentOpened(int, int)));
}

/***************** Main Slots *****************/
void HhmSidebar::syncInbox()
{
    loadInboxEmails();
    hhm_updateFromServer();
    QMetaObject::invokeMethod(main_ui, "finishSync");
}

void HhmSidebar::syncOutbox()
{
    loadOutboxEmails();
    hhm_updateFromServer();
    QMetaObject::invokeMethod(main_ui, "finishSync");
}

/***************** Document Slots *****************/
void HhmSidebar::documentClicked(int casenumber)
{
    emit openDocument(casenumber);
}

void HhmSidebar::documentOpened(int emailId, int casenumber)
{
    //Change State `opened` Email
    QString condition = "`" + QString(HHM_EMAIL_ID) + "`=" + QString::number(emailId);
    QString value = "`" + QString(HHM_EMAIL_OPENED) + "`=" + QString::number(1);
    db->update(condition, value, HHM_TABLE_EMAIL);
    documentClicked(casenumber);
}

void HhmSidebar::loadInboxEmails()
{
    showEmailInSidebar(getIdEmails(HHM_UE_RECEIVED_EMAILS));
}

void HhmSidebar::loadOutboxEmails()
{
    showEmailInSidebar(getIdEmails(HHM_UE_SENT_EMAILS));
}

//input in csv format
void HhmSidebar::showEmailInSidebar(QStringList emailIds)
{
    QString query = "";
    for(int i=0; i<emailIds.size(); i++)
    {
        HhmEmailTable email = getEmail(emailIds.at(i).toInt());

        QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" + QString::number(email.docCasenumber);
        QSqlQuery res = db->select("*", HHM_TABLE_DOCUMENT, condition);
        if( res.next() )
        {
            QVariant data = res.value(HHM_DOCUMENT_CASENUMBER);
            if( data.isValid() )
            {
                QQmlProperty::write(list_ui, "case_number", data.toInt());
            }

            data = res.value(HHM_DOCUMENT_SUBJECT);
            if( data.isValid() )
            {
                QQmlProperty::write(list_ui, "text_subject", data.toString());
            }

            data = res.value(HHM_DOCUMENT_STATUS);
            if( data.isValid() )
            {
                QQmlProperty::write(list_ui, "doc_status", data.toInt());
            }

            QQmlProperty::write(list_ui, "email_id", emailIds.at(i));
            QQmlProperty::write(list_ui, "email_opened", email.opened==1);
            QMetaObject::invokeMethod(list_ui, "addToList");

        }
    }
}

/*
 * @type: 'HHM_UE_SENT_EMAILS' or 'HHM_UE_RECEIVED_EMAILS'
 * @return: in csv format
 * */
QStringList HhmSidebar::getIdEmails(QString type)
{
//    int month = (QDate::currentDate().year() - HHM_START_YEAR)*12 + QDate::currentDate().month();
    QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(m_user->getId());
//    condition += " AND `" + QString(HHM_UE_DATE) + "`=" + QString::number(month);
    QSqlQuery res = db->select(type, HHM_TABLE_USER_EMAIL, condition);
    QStringList result;
    if( res.next() )
    {
        result = res.value(0).toString().split(",", QString::SkipEmptyParts);
    }
    return result;
}




HhmEmailTable HhmSidebar::getEmail(int idEmail)
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

