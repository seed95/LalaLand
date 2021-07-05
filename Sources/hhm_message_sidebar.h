#ifndef HHM_MESSAGE_SIDEBAR_H
#define HHM_MESSAGE_SIDEBAR_H

#include <QObject>

#include "hhm_database.h"
#include "hhm_user.h"

class HhmMessageSidebar : public QObject
{
    Q_OBJECT
public:
    explicit HhmMessageSidebar(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                               QObject *parent = nullptr);

    void loadInbox();
    void loadOutbox();
    void loadMessages();

private slots:
    //Main Slots
    void syncInbox();
    void syncOutbox();
    void syncMessages();

    //Box Slots
    void readMessage(QString idMessage);

private:
    void     addMessageToSidebar(QObject *list_ui, qint64 messageId);
    bool     messageIsRead(qint64 messageId);
    bool     messageContainFile(qint64 messageId);
    QString  getSenderName(qint64 messageId);

private:
    QObject *sidebar_ui;
    QObject *inbox_ui;
    QObject *outbox_ui;
    QObject *search_ui;

    HhmUser     *m_user;
    HhmDatabase *db;
};

#endif // HHM_MESSAGE_SIDEBAR_H
