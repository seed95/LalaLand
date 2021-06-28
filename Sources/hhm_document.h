#ifndef HHMDOCUMENT_H
#define HHMDOCUMENT_H

#include <QObject>
#include <QQmlProperty>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"

#define ID_INDEX        0
#define USERNAME_INDEX  1

typedef struct DocumentData
{
    int             casenumber;
    int             senderId;
    QVariantList    toUser;
    QString         senderName;
    QString         subject;
    QString         tableContent;
    QString         date;
    QStringList     filenames;//attach filenames
    QStringList     fileIds;
}DocumentData;


typedef struct HhmUserTable
{
    int userId;
    QString firstname;
    QString lastname;//0,1
    QString username;//0,1
} HhmUserTable;

class HhmDocument : public QObject
{
    Q_OBJECT
public:
    explicit HhmDocument(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                         QObject *parent=nullptr);
    ~HhmDocument();

private slots:
    //Ftp Slots
    void uploadSuccess(QString filename);
    void uploadFailed(QString filename);
    void downloadSuccess(QString filename);
    void downloadFailed(QString filename);

    //Action Slots
    void newDocumentClicked();

    //Main Slots

    //New Slots
    void checkUsername(QString username);
    void uploadFileClicked();
    void sendNewDocument(int caseNumber, QVariant toData,
                         QString subject, QVariant attachFiles,
                         QString tableContent);

    //View Slots
    void openDocument(int casenumber);

private:
    void setDocumentBaseId();
    void updateDocument();
    void updateUserEmail(QString field, int emailId);
    void insertNewEmail();


    HhmUserTable getUser(int idUser);

    void fillDestinationFilenames();
    void uploadNextFile();
    void uploadAttachFilesFinished();
    void insertNewFile();

    //Utility Functions
    int getMaxId(QString fieldId, QString table);
    QString getFtpFilename();
    QVariant getConfig(QString key);

private:
    QObject *main_ui;
    QObject *action_ui;

    QObject *new_ui;
    QObject *new_attachbar;

    QObject *view_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
    HhmFtp      *ftp;

    int doc_base_id;//Document Base id in 'HHM_TABLE_CONFIG'
    DocumentData new_data;

    int attach_file_ind;
    int dst_filename_ind;
    //List of destination name for upload one attachment file in Send-Received and DocumentManager folders
    QStringList dst_filenames;
};

#endif // HHMDOCUMENT_H
