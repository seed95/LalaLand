#ifndef HHMSIDEBAR_H
#define HHMSIDEBAR_H

#include <QObject>

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

private slots:
    //Main Slots
    void syncInbox();
    void syncOutbox();

    //List Slots
    void documentClicked(int casenumber);
    void documentOpened(int emailId, int casenumber);

signals:
    void openDocument(int casenumber);

private:
    void loadInboxEmails();
    void loadOutboxEmails();
    void showEmailInSidebar(QStringList emailIds);//emailsIds: csv format
    QStringList getIdEmails(QString type);

    HhmEmailTable getEmail(int idEmail);
    bool updateEmail(QString field, int userId, int emailId);

private:
    QObject *main_ui;
    QObject *list_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
};

#endif // HHMSIDEBAR_H
