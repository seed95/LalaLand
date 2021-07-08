#ifndef HHM_MESSAGE_H
#define HHM_MESSAGE_H

#include <QObject>
#include <QQmlProperty>
#include <QFileDialog>
#include <QJsonArray>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"
#include "hhm_message_sidebar.h"

#define TAG_MODE_INDEX      0
#define TAG_ID_INDEX        1
#define TAG_USERNAME_INDEX  2

#define SENDER_FLAG  1
#define TO_FLAG      2
#define CC_FLAG      3

typedef struct MessageData
{
    qint64          id;//Message Id
    int             senderId;
    QVariantList    toData;
    QVariantList    ccData;
    QString         subject;
    QString         content;
    QStringList     filenames;//Attach Filenames
    bool            replyMode;
    qint64          replyId;//Reply Message Id
}MessageData;

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

    //Main Slots
    void sendNewMessage(QVariant toData, QVariant ccData,
                        QString subject, QString content,
                        QVariant attachFiles);
    void messageClicked(QString idMessage);
    void replyMessage(QString replyMessageId);
    void sendReplyMessage(QVariant toData, QVariant ccData,
                          QString subject, QString content,
                          QVariant attachFiles, QString replyMessageId);

    //Action Slots
    void attachNewFile();
    void newMessageClicked();

    //Input Slots
    void addNewTagTo(QString name);
    void addNewTagCc(QString name);

    //View Slots
    void downloadAttachFile(int fileId);

private:

    //New Functions
    void fillDestinationFilenames();
    void insertNewFile();
    void insertNewUserMessage(int userId, int flag);
    void insertNewMessageForDepartment(int departmentId, int groupId);
    void insertNewDepartmentMessage(int departmentId, int flag);
    void insertNewDepartmentUserMessage(int departmentId, int userId);
    void updateMessage();
    void updateSourceMessage();
    void updateJoinMessage();
    void uploadNextFile();
    void uploadAttachFilesFinished();

    //View Functions
    void            showMessage(qint64 messageId);
    QString         getSenderName(qint64 messageId);
    QString         getToNames(qint64 messageId);
    QString         getCcNames(qint64 messageId);
    QVariantList    getAttachFiles(qint64 messageId);

    //Reply Functions
    void setToTagForReply(qint64 replyMessageId);
    void setCcTagsForReply(qint64 replyMessageId);

    //Utility Functions
    bool addUserTag(QString username, QObject *ui);
    bool addDepartmentTag(QString name, QObject *ui);
    QString getDepartmentName(int departmentId);

private:
    QObject *main_ui;
    QObject *action_ui;
    QObject *sidebar_ui;
    QObject *new_ui;
    QObject *view_ui;
    QObject *attach_ui;

    QObject *new_input_to_ui;
    QObject *new_input_cc_ui;

    HhmDatabase         *db;
    HhmUser             *m_user;
    HhmFtp              *ftp;
    HhmMessageSidebar   *sidebar;

    int attach_file_ind;
    int dst_filename_ind;
    //List of destination name for upload one attachment file in Send-Received and DocumentManager folders
    QStringList dst_filenames;

    MessageData new_data;   //new message data
    MessageData view_data;  //show message data
};

#endif // HHM_MESSAGE_H
