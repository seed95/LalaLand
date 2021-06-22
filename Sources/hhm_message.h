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

typedef struct MessageData
{
    int             id;//message id
    int             senderId;
    QVariantList    toData;
    QVariantList    ccData;
    QString         subject;
    QString         content;
    QStringList     filenames;//attach filenames
    QStringList     fileIds;
}MessageData;

class HhmMessage : public QObject
{
    Q_OBJECT
public:
    explicit HhmMessage(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                        QObject *parent = nullptr);
    ~HhmMessage();

private slots:
    //Ftp Slots
    void uploadSuccess(QString filename);
    void uploadFailed(QString filename);
    void downloadSuccess(QString filename);
    void downloadFailed(QString filename);

    //Action Slots
    void attachNewFile();
    void newMessageClicked();

    //Input Slots
    void addNewUsernameTo(QString username);
    void addNewUsernameCc(QString username);

    //Main Slots
    void sendNewMessage(QVariant toData, QVariant ccData,
                        QString subject, QString content,
                        QVariant attachFiles);

private:
    void fillDestinationFilenames();
    void insertNewFile();
    void uploadNextFile();
    void uploadAttachFilesFinished();

    //Utility Functions
    void addUserTag(QSqlQuery res, QObject *ui);
    QStringList getUsersId(QVariantList users);
    int getMaxId(QString fieldId, QString table);

private:
    QObject *main_ui;
    QObject *new_ui;
    QObject *content_ui;
    QObject *action_ui;
    QObject *new_input_to_ui;
    QObject *new_input_cc_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
    HhmFtp   *ftp;

    int attach_file_ind;
    int dst_filename_ind;
    //List of destination name for upload one attachment file in Send-Received and DocumentManager folders
    QStringList dst_filenames;

    MessageData new_data;   //new message data
    MessageData show_data;  //show message data
};

#endif // HHMMESSAGE_H
