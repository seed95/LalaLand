#include "hhm_message_sidebar.h"

HhmMessageSidebar::HhmMessageSidebar(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                                     QObject *parent) : QObject(parent)
{
    db = database;
    sidebar_ui = root;
    m_user = userLoggedIn;

    inbox_ui  = sidebar_ui->findChild<QObject*>("InboxList");
    outbox_ui = sidebar_ui->findChild<QObject*>("OutboxList");
    search_ui = sidebar_ui->findChild<QObject*>("SearchList");

    connect(sidebar_ui, SIGNAL(syncInbox()), this, SLOT(syncInbox()));
    connect(sidebar_ui, SIGNAL(syncOutbox()), this, SLOT(syncOutbox()));
    connect(sidebar_ui, SIGNAL(syncMessages()), this, SLOT(syncMessages()));

    connect(inbox_ui, SIGNAL(readMessage(QString)), this, SLOT(readInboxMessage(QString)));
    connect(outbox_ui, SIGNAL(readMessage(QString)), this, SLOT(readOutboxMessage(QString)));
}

void HhmMessageSidebar::loadMessages()
{
    loadInbox();
    loadOutbox();
}

void HhmMessageSidebar::loadInbox()
{
    QMetaObject::invokeMethod(inbox_ui, "clearList");
    int permission = m_user->getPermission();
    if( permission==PERMISSION_MY_MESSAGE )
    {
        loadBox(INBOX_TYPE);
    }
    else if( permission==PERMISSION_DEPARTMENT_MESSAGE )
    {
        loadBox(INBOX_TYPE);
        loadDepartmentMessage(m_user->getDepartmentId());
    }
    else if( permission==PERMISSION_ALL_MESSAGE )
    {
        loadAllMessage();
    }
}

void HhmMessageSidebar::loadOutbox()
{
    QMetaObject::invokeMethod(outbox_ui, "clearList");
    loadBox(OUTBOX_TYPE);
}

/***************** Sidebar Slots *****************/
void HhmMessageSidebar::syncInbox()
{
    loadInbox();
    hhm_updateFromServer();
    QMetaObject::invokeMethod(sidebar_ui, "finishSync");
}

void HhmMessageSidebar::syncOutbox()
{
    loadOutbox();
    hhm_updateFromServer();
    QMetaObject::invokeMethod(sidebar_ui, "finishSync");
}

void HhmMessageSidebar::syncMessages()
{
    syncInbox();
    syncOutbox();
}

/***************** Box Slots *****************/
void HhmMessageSidebar::readInboxMessage(QString idMessage)
{
    //Update in HHM_TABLE_JOIN_USER_MESSAGE
    QString message_condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" + idMessage ;
    QString user_condition = "`" + QString(HHM_JUM_USER_ID) + "`=" +
                             QString::number(m_user->getId());
    QString inbox_condition = "( `" + QString(HHM_JUM_TO_FLAG) + "`='1'" +
                              " OR `" + QString(HHM_JUM_CC_FLAG) + "`='1' )";
    QString condition = message_condition + " AND " + user_condition + " AND " + inbox_condition;
    QString values = "`" + QString(HHM_JUM_READ_FLAG) + "`='1'";
    db->update(condition, values, HHM_TABLE_JOIN_USER_MESSAGE);

    //Update in HHM_TABLE_JOIN_DEPARTMENT_USER_MESSAGE
    message_condition = "`" + QString(HHM_JDUM_MESSAGE_ID) + "`=" + idMessage ;
    user_condition = "`" + QString(HHM_JDUM_USER_ID) + "`=" +
                     QString::number(m_user->getId());
    condition = message_condition + " AND " + user_condition;
    values = "`" + QString(HHM_JDUM_READ_FLAG) + "`='1'";
    db->update(condition, values, HHM_TABLE_JOIN_DEPARTMENT_USER_MESSAGE);
}

void HhmMessageSidebar::readOutboxMessage(QString idMessage)
{
    //Update in HHM_TABLE_JOIN_USER_MESSAGE
    QString message_condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" + idMessage ;
    QString user_condition = "`" + QString(HHM_JUM_USER_ID) + "`=" +
                             QString::number(m_user->getId());
    QString outbox_condition = "`" + QString(HHM_JUM_SENDER_FLAG) + "`='1'";
    QString condition = message_condition + " AND " + user_condition + " AND " + outbox_condition;
    QString values = "`" + QString(HHM_JUM_READ_FLAG) + "`='1'";
    db->update(condition, values, HHM_TABLE_JOIN_USER_MESSAGE);
}

/***************** Private Functions *****************/
void HhmMessageSidebar::loadBox(int typeBox)
{
    QString user_condition = "`" + QString(HHM_JUM_USER_ID) + "`=" +
                             QString::number(m_user->getId());
    QString box_condition;
    QObject *box_ui;
    if( typeBox==INBOX_TYPE )
    {
        box_condition = "( `" + QString(HHM_JUM_TO_FLAG) + "`='1'" +
                        " OR `" + QString(HHM_JUM_CC_FLAG) + "`='1' )";
        box_ui = inbox_ui;
    }
    else//OUTBOX_TYPE
    {
        box_condition = "`" + QString(HHM_JUM_SENDER_FLAG) + "`='1'";
        box_ui = outbox_ui;
    }
    QString condition = user_condition + " AND " + box_condition;
    QString fields = QString(HHM_JUM_MESSAGE_ID) + ", " + QString(HHM_JUM_READ_FLAG);
    QSqlQuery res = db->select(fields, HHM_TABLE_JOIN_USER_MESSAGE, condition);

    qint64 message_id;
    bool   message_read;
    while( res.next() )
    {
        message_id = res.value(HHM_JUM_MESSAGE_ID).toLongLong();
        message_read = res.value(HHM_JUM_READ_FLAG).toBool();
        addMessageToSidebar(box_ui, message_id, message_read);
    }

}

void HhmMessageSidebar::loadDepartmentMessage(int idDepartment)
{
    QString department_condition = "`" + QString(HHM_JDUM_DEPARTMENT_ID) + "`=" +
                                   QString::number(idDepartment);
    QString user_condition = "`" + QString(HHM_JDUM_USER_ID) + "`=" +
                             QString::number(m_user->getId());

    QString condition = department_condition + " AND " + user_condition;
    QString fields = QString(HHM_JDUM_MESSAGE_ID) + ", " + QString(HHM_JDUM_READ_FLAG);
    QSqlQuery res = db->select(fields, HHM_TABLE_JOIN_DEPARTMENT_USER_MESSAGE, condition);

    qint64 message_id;
    bool   message_read;
    while( res.next() )
    {
        message_id = res.value(HHM_JDUM_MESSAGE_ID).toLongLong();
        message_read = res.value(HHM_JDUM_READ_FLAG).toBool();
        addMessageToSidebar(inbox_ui, message_id, message_read);
    }

    condition = "`" + QString(HHM_JDG_DEPARTMENT_ID) + "`=" +
                QString::number(idDepartment);
    res = db->select(HHM_JDG_GROUP_ID, HHM_TABLE_DEPARTMENT_GROUP, condition);
    while( res.next() )
    {
        loadDepartmentMessage(res.value(0).toInt());
    }

}

void HhmMessageSidebar::loadAllMessage()
{
    QSqlQuery res = db->select("*", HHM_TABLE_MESSAGE);

    qint64 message_id;
    while( res.next() )
    {
        message_id = res.value(HHM_MESSAGE_ID).toLongLong();
        addMessageToSidebar(inbox_ui, message_id, true);
    }
}

void HhmMessageSidebar::addMessageToSidebar(QObject *list_ui, qint64 messageId, bool isRead)
{
    QString condition = "`" + QString(HHM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    QSqlQuery res = db->select("*", HHM_TABLE_MESSAGE, condition);
    if( res.next() )
    {
        QQmlProperty::write(list_ui, "messageId", QString::number(messageId));

        QVariant data = res.value(HHM_MESSAGE_SUBJECT);
        if( data.isValid() )
        {
            QQmlProperty::write(list_ui, "subject", data.toString());
        }

        data = res.value(HHM_MESSAGE_NUMBER_SOURCES);
        if( data.isValid() )
        {
            QQmlProperty::write(list_ui, "numberSources", data.toInt() + 1);
        }

        data = res.value(HHM_MESSAGE_SOURCE_ID);
        if( data.isValid() )
        {
            QQmlProperty::write(list_ui, "sourceId", data.toLongLong());
        }

        QQmlProperty::write(list_ui, "senderName", getSenderName(messageId));

        data = res.value(HHM_MESSAGE_SEND_DATE);
        if( data.isValid() )
        {
            QLocale locale(QLocale::Arabic);
            QDateTime message_date = data.toDateTime();
            QDateTime current_date = QDateTime::currentDateTime();
            if( message_date.daysTo(current_date) )
            {
                QQmlProperty::write(list_ui, "date",
                                    locale.toString(message_date, "MMMM dd"));
            }
            else
            {
                QQmlProperty::write(list_ui, "date",
                                    locale.toString(message_date, "hh:mm"));
            }
        }

        QQmlProperty::write(list_ui, "isRead", isRead);
        QQmlProperty::write(list_ui, "containFile", messageContainFile(messageId));
        QMetaObject::invokeMethod(list_ui, "addToList");
    }
}

bool HhmMessageSidebar::messageContainFile(qint64 messageId)
{
    QString condition = "`" + QString(HHM_FILES_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    QSqlQuery res = db->select(HHM_FILES_ID, HHM_TABLE_FILES, condition);
    if( res.next() )
    {
        return true;
    }
    return false;
}

QString HhmMessageSidebar::getSenderName(qint64 messageId)
{
    QString condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    condition += " AND `" + QString(HHM_JUM_SENDER_FLAG) + "`=1";
    QSqlQuery res = db->select(HHM_JUM_USER_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    if( res.next() )
    {
        return m_user->getName(res.value(0).toInt());
    }
    return "";
}


