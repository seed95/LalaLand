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

    connect(inbox_ui, SIGNAL(readMessage(QString)), this, SLOT(readMessage(QString)));
    connect(outbox_ui, SIGNAL(readMessage(QString)), this, SLOT(readMessage(QString)));
    connect(search_ui, SIGNAL(readMessage(QString)), this, SLOT(readMessage(QString)));
}

void HhmMessageSidebar::loadMessages()
{
    loadInbox();
    loadOutbox();
}

void HhmMessageSidebar::loadInbox()
{
    QString condition = "`" + QString(HHM_JUM_USER_ID) + "`=" +
                        QString::number(m_user->getId());
    condition += " AND ( `" + QString(HHM_JUM_TO_FLAG) + "`='1'";
    condition += " OR `" + QString(HHM_JUM_CC_FLAG) + "`='1')";
    QSqlQuery res = db->select(HHM_JUM_MESSAGE_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    while( res.next() )
    {
        addMessageToSidebar(inbox_ui, res.value(0).toLongLong());
    }
}

void HhmMessageSidebar::loadOutbox()
{
    QString condition = "`" + QString(HHM_JUM_USER_ID) + "`=" +
                        QString::number(m_user->getId());
    condition += " AND `" + QString(HHM_JUM_SENDER_FLAG) + "`='1'";
    QSqlQuery res = db->select(HHM_JUM_MESSAGE_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    while( res.next() )
    {
        addMessageToSidebar(outbox_ui, res.value(0).toLongLong());
    }
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
void HhmMessageSidebar::readMessage(QString idMessage)
{
    QString condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" + idMessage ;
    condition += " AND `" + QString(HHM_JUM_USER_ID) + "`=" +
                 QString::number(m_user->getId());
    QString values = "`" + QString(HHM_JUM_IS_READ) + "`='1'";
    db->update(condition, values, HHM_TABLE_JOIN_USER_MESSAGE);
}

/***************** Private Functions *****************/
void HhmMessageSidebar::addMessageToSidebar(QObject *list_ui, qint64 messageId)
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

        QQmlProperty::write(list_ui, "isRead", messageIsRead(messageId));
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

bool HhmMessageSidebar::messageIsRead(qint64 messageId)
{
    QString condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    condition += " AND `" + QString(HHM_JUM_USER_ID) + "`=" +
                 QString::number(m_user->getId());
    QSqlQuery res = db->select(HHM_JUM_IS_READ, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    if( res.next() )
    {
        return res.value(0).toBool();
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


