#ifndef HHMMESSAGE_H
#define HHMMESSAGE_H

#include <QObject>
#include <QQmlProperty>
#include <QFileDialog>
#include <QJsonArray>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"


#define ID_INDEX        0
#define USERNAME_INDEX  1

#define SENDER_FLAG  1
#define TO_FLAG      2
#define CC_FLAG      3

typedef struct MessageData
{
    qint64          id;//message id
    int             senderId;
    QVariantList    toData;
    QVariantList    ccData;
    QString         subject;
    QString         content;
    QStringList     filenames;//attach filenames
}MessageData;



typedef enum UserMessageType
{
    Sender,
    To,
    Cc
} UserMessageType;

class HhmMessage : public QObject
{
    Q_OBJECT
public:
    explicit HhmMessage(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                        QObject *parent=nullptr);
    ~HhmMessage();

    void loginSuccessfully();

private slots:
    //Ftp Slots
    void uploadSuccess(QString filename);
    void uploadFailed(QString filename);
    void downloadSuccess(QString filename);
    void downloadFailed(QString filename);

    //Action Slots
    void attachNewFile();
    void newMessageClicked();

    //Sidebar Slots
    void syncInbox();
    void syncOutbox();
    void syncMessages();

    //Box Slots
    void readMessage(QString idMessage);

    //Input Slots
    void addNewUsernameTo(QString username);
    void addNewUsernameCc(QString username);

    //New Slots
    void sendNewMessage(QVariant toData, QVariant ccData,
                        QString subject, QString content,
                        QVariant attachFiles);

    //Main Slots
    void showMessage(QString idMessage);

private:
    void fillDestinationFilenames();
    void insertNewFile();
    void insertNewUserMessage(int idUser, int flag);
    void updateMessage();
    void updateJUM();//Join User Message
    void uploadNextFile();
    void uploadAttachFilesFinished();

    //Sidebar Functions
    void loadInboxEmails();
    void loadOutboxEmails();
    void addMessageToSidebar(QObject *list_ui, qint64 messageId);

    //Utility Functions
    void addUserTag(QSqlQuery res, QObject *ui);
    int getMaxId(QString fieldId, QString table);

private:
    QObject *main_ui;
    QObject *action_ui;
    QObject *sidebar_ui;
    QObject *new_ui;
    QObject *view_ui;

    QObject *new_input_to_ui;
    QObject *new_input_cc_ui;
    QObject *new_attachbar;

    QObject *inbox_ui;
    QObject *outbox_ui;
    QObject *search_ui;


    HhmDatabase *db;
    HhmUser     *m_user;
    HhmFtp      *ftp;

    int attach_file_ind;
    int dst_filename_ind;
    //List of destination name for upload one attachment file in Send-Received and DocumentManager folders
    QStringList dst_filenames;

    MessageData new_data;   //new message data
    MessageData view_data;  //show message data
};

#endif // HHMMESSAGE_H
