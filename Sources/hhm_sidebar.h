#ifndef HHMSIDEBAR_H
#define HHMSIDEBAR_H

#include <QObject>
#include <QQmlProperty>

#include "hhm_database.h"
#include "hhm_user.h"

typedef struct HhmEmailTable
{
    int emailId;
    int docCasenumber;
    int flag;//0,1
    int opened;//0,1
    QDateTime date;
    int sentEmail;//0,1
    int receiveEmail;//0,1
} HhmEmailTable;


class HhmSidebar : public QObject
{
    Q_OBJECT
public:
    explicit HhmSidebar(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                        QObject *parent = nullptr);

    void updateSelectedEmail();
    void loadEmails();

private slots:
    //Main Slots
    void syncInbox();
    void syncOutbox();
    void readEmail(int emailId);

private:
    void loadInboxEmails();
    void loadOutboxEmails();
    void showEmailInSidebar(QObject *list_ui, QStringList emailIds);//emailsIds: csv format
    QStringList getIdEmails(QString type);

    HhmEmailTable getEmail(int idEmail);
    bool updateEmail(QString field, int userId, int emailId);

private:
    QObject *main_ui;

    QObject *inbox_ui;
    QObject *outbox_ui;
    QObject *search_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
};

#endif // HHMSIDEBAR_H
