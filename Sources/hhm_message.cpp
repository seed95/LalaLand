#include "hhm_message.h"

HhmMessage::HhmMessage(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                       QObject *parent) : QObject(parent)
{
    db = database;
    m_user = userLoggedIn;

    main_ui     = root->findChild<QObject*>("Message");
    new_ui      = main_ui->findChild<QObject*>("MessageNew");
    action_ui   = main_ui->findChild<QObject*>("MessageAction");

    new_input_to_ui   = main_ui->findChild<QObject*>("MessageNewTo");
    new_input_cc_ui   = main_ui->findChild<QObject*>("MessageNewCc");
    new_attachbar     = main_ui->findChild<QObject*>("MessageAttachbar");

    connect(action_ui, SIGNAL(attachNewFile()), this, SLOT(attachNewFile()));
    connect(action_ui, SIGNAL(newMessageClicked()), this, SLOT(newMessageClicked()));

    connect(new_ui, SIGNAL(sendNewMessage(QVariant, QVariant, QString, QString, QVariant)),
            this, SLOT(sendNewMessage(QVariant, QVariant, QString, QString, QVariant)));

    connect(new_input_to_ui, SIGNAL(addNewUsername(QString)), this, SLOT(addNewUsernameTo(QString)));
    connect(new_input_cc_ui, SIGNAL(addNewUsername(QString)), this, SLOT(addNewUsernameCc(QString)));

    ftp = new HhmFtp();
    connect(ftp, SIGNAL(uploadSuccess(QString)), this, SLOT(uploadSuccess(QString)));
    connect(ftp, SIGNAL(uploadFailed(QString)), this, SLOT(uploadFailed(QString)));
    connect(ftp, SIGNAL(downloadSuccess(QString)), this, SLOT(downloadSuccess(QString)));
    connect(ftp, SIGNAL(downloadFailed(QString)), this, SLOT(downloadFailed(QString)));

}

HhmMessage::~HhmMessage()
{
    if( ftp!=nullptr )
    {
        delete ftp;
    }
}

/***************** Ftp Slots *****************/
void HhmMessage::uploadSuccess(QString filename)
{
    dst_filename_ind++;
    if( dst_filename_ind<dst_filenames.length() )
    {
        QString src = new_data.filenames.at(attach_file_ind);
        QString dst  = dst_filenames.at(dst_filename_ind);
        ftp->uploadFile(src, dst);
    }
    else
    {
        insertNewFile();
        uploadNextFile();
    }
}

void HhmMessage::uploadFailed(QString filename)
{
    ///FIXME: complete this segment
    hhm_showMessage("Upload Failed", 2000);
    hhm_log("Upload Failed: " + filename);

}

void HhmMessage::downloadSuccess(QString filename)
{
    qDebug() << filename;
}

void HhmMessage::downloadFailed(QString filename)
{
    qDebug() << filename;
}

/***************** Action Slots *****************/
void HhmMessage::attachNewFile()
{
    QString file_path = QFileDialog::getOpenFileName(NULL,
                                                     "Choose File",
                                                     hhm_getLastDirectory(),
                                                     "*");
    if( !file_path.isEmpty() )
    {
        hhm_setLastDirectory(QFileInfo(file_path).absolutePath());
        QQmlProperty::write(new_attachbar, "attach_filename", file_path);
        QMetaObject::invokeMethod(new_attachbar, "addAttachFile");
    }
}

void HhmMessage::newMessageClicked()
{
    //Insert new row message
    QString columns = "`" + QString(HHM_MESSAGE_SENDER_ID) + "`";
    QString values  = "'" + QString::number(m_user->getId()) + "'";
    db->insert(HHM_TABLE_MESSAGE, columns, values);

    //Get max message id
    new_data.id = getMaxId(HHM_MESSAGE_ID, HHM_TABLE_MESSAGE);
    if( new_data.id==-1 )
    {
        hhm_log("Table " + QString(HHM_TABLE_MESSAGE) + " is empty");
        new_data.id = 0;
    }
}

/***************** Input Slots *****************/
void HhmMessage::addNewUsernameTo(QString username)
{
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    if( res.next() )
    {
        addUserTag(res, new_input_to_ui);
    }
    else
    {
        QMetaObject::invokeMethod(new_input_to_ui, "usernameNotFound");
    }
}

void HhmMessage::addNewUsernameCc(QString username)
{
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    if( res.next() )
    {
        addUserTag(res, new_input_cc_ui);
    }
    else
    {
        QMetaObject::invokeMethod(new_input_cc_ui, "usernameNotFound");
    }
}

/***************** New Slots *****************/
void HhmMessage::sendNewMessage(QVariant toData, QVariant ccData,
                                QString subject, QString content,
                                QVariant attachFiles)
{
    if( toData.toList().size()==0 )
    {
        hhm_showMessage("Please select that you want to send witch user", 5000);
        return;
    }

    new_data.senderId   = m_user->getId();
    new_data.toData     = toData.toList();
    new_data.ccData     = ccData.toList();
    new_data.subject    = subject;
    new_data.content    = content;
    new_data.filenames  = attachFiles.toStringList();
    new_data.fileIds.clear();

    QLocale locale(QLocale::English);
    new_data.date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");

    attach_file_ind = -1;
    uploadNextFile();
}

/***************** Private Functions *****************/
/*
 * Fill 'dst_filenames' with filename at
 * position 'attach_file_ind' in
 * new_data.filenames
 * */
void HhmMessage::fillDestinationFilenames()
{
    dst_filenames.clear();
    QString src, dst_filepath, dst_filename;
    QVariantList r_user;//Receiver(to,cc) user

    src = new_data.filenames.at(attach_file_ind);
    dst_filename = hhm_appendCasenumber(src, new_data.id);

    ///FIXME: Ask Bijan
    dst_filepath  = /*"DocumentManager/" +*/ dst_filename;
    dst_filenames.append(dst_filepath);

    ///FIXME: Ask Bijan
    dst_filepath = m_user->getUsername().toLower() + "/Send/" + dst_filename;
    dst_filenames.append(dst_filepath);

    for(int to_ind=0; to_ind<new_data.toData.length(); to_ind++)
    {
        r_user = new_data.toData.at(to_ind).toList();
        ///FIXME: Ask Bijan
        dst_filepath = r_user.at(USERNAME_INDEX).toString().toLower() + "/Received/" + dst_filename;
        dst_filenames.append(dst_filepath);
    }

    for(int cc_ind=0; cc_ind<new_data.ccData.length(); cc_ind++)
    {
        r_user = new_data.ccData.at(cc_ind).toList();
        ///FIXME: Ask Bijan
        dst_filepath = r_user.at(USERNAME_INDEX).toString().toLower() + "/Received/" + dst_filename;
        dst_filenames.append(dst_filepath);
    }

}

void HhmMessage::uploadNextFile()
{
    dst_filename_ind = 0;
    attach_file_ind++;
    if( attach_file_ind<new_data.filenames.length() )
    {
        fillDestinationFilenames();
        QString src = new_data.filenames.at(attach_file_ind);
        QString dst  = dst_filenames.at(dst_filename_ind);
        ftp->uploadFile(src, dst);
    }
    else
    {
        uploadAttachFilesFinished();
    }
}

void HhmMessage::uploadAttachFilesFinished()
{
    updateMessage();
    QMetaObject::invokeMethod(main_ui, "successfullySend");
}

void HhmMessage::updateMessage()
{
    QString condition = "`" + QString(HHM_MESSAGE_ID) + "`='" +
                        QString::number(new_data.id) + "'";
    QStringList to_ids = getUsersId(new_data.toData);
    QStringList cc_ids = getUsersId(new_data.ccData);
    QString values = "`" + QString(HHM_MESSAGE_TO_IDS) + "`='" +
                     to_ids.join(",") + "'";
    values += ", `" + QString(HHM_MESSAGE_CC_IDS) + "`='" +
              cc_ids.join(",") + "'";
    values += ", `" + QString(HHM_MESSAGE_SUBJECT) + "`='" + new_data.subject + "'";
    values += ", `" + QString(HHM_MESSAGE_CONTENT) + "`='" + new_data.content + "'";
    values += ", `" + QString(HHM_MESSAGE_FILE_IDS) + "`='" + new_data.fileIds.join(",") + "'";
    values += ", `" + QString(HHM_MESSAGE_DATETIME) +"`='" + new_data.date + "'";

    db->update(condition, values, HHM_TABLE_MESSAGE);
}

/*
 * Insert filename at position
 * 'attach_file_ind' in new_data.filenames
 * into 'HHM_TABLE_FILES'
 * */
void HhmMessage::insertNewFile()
{
    //Insert new row file
    QString columns  = "`" + QString(HHM_FILES_FILENAME) + "`, ";
    columns += "`" + QString(HHM_FILES_SENDER_ID) + "`, ";
    columns += "`" + QString(HHM_FILES_TO_IDS) + "`, ";
    columns += "`" + QString(HHM_FILES_CC_IDS) + "`";

    QString src = new_data.filenames.at(attach_file_ind);
    ///FIXME: Ask Bijan
    QString filename = /*"DocumentManager/" +*/ QString::number(new_data.id) + "_" + QFileInfo(src).fileName();

    QString values  = "'" + filename + "', ";
    values += "'" + QString::number(m_user->getId()) + "', ";
    QStringList to_ids = getUsersId(new_data.toData);
    values += "'" + to_ids.join(",") + "', ";
    QStringList cc_ids = getUsersId(new_data.ccData);
    values += "'" + cc_ids.join(",") + "'";

    db->insert(HHM_TABLE_FILES, columns, values);

    int file_id = getMaxId(HHM_FILES_ID, HHM_TABLE_FILES);
    if( file_id==-1 )
    {
        hhm_log("Table " + QString(HHM_TABLE_FILES) + " is empty");
        file_id = 0;
    }
    new_data.fileIds.append(QString::number(file_id));
}

/***************** Utility Functions *****************/
void HhmMessage::addUserTag(QSqlQuery res, QObject *ui)
{
    QVariant data = res.value(HHM_USER_ID);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "user_id", data.toInt());
    }
    else
    {
        hhm_log("add user tag, user id is not valid");
    }

    data = res.value(HHM_USER_FIRSTNAME);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "label_firstname", data.toString());
    }
    else
    {
        hhm_log("add user tag, user firstname is not valid");
    }

    data = res.value(HHM_USER_LASTNAME);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "label_lastname", data.toString());
    }
    else
    {
        hhm_log("add user tag, user lastname is not valid");
    }

    data = res.value(HHM_USER_USERNAME);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "label_username", data.toString());
    }
    else
    {
        hhm_log("add user tag, username is not valid");
    }

    QMetaObject::invokeMethod(ui, "addUsername");
}

/*
 * Return ids in 'users' variable
 * */
QStringList HhmMessage::getUsersId(QVariantList users)
{
    QStringList result;
    QVariantList user;//user
    for(int i=0; i<users.length(); i++)
    {
        user = users.at(i).toList();
        result.append(user.at(ID_INDEX).toString());
    }
    return result;
}

/*
 * Return last id for
 * 'fieldId' in 'table'
 * if not found return -1
 * */
int HhmMessage::getMaxId(QString fieldId, QString table)
{
    int max_id = -1;
    QString query = "SELECT MAX(" + fieldId + ") FROM ";
    query += "`" + QString(DATABASE_NAME) + "`.`" + table + "`";
    QSqlQuery res = db->sendQuery(query);
    if( res.next() )
    {
        max_id = res.value(0).toInt();
    }
    return max_id;
}
