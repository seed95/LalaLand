#include "hhm_message.h"

HhmMessage::HhmMessage(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                       QObject *parent) : QObject(parent)
{
    db = database;
    m_user = userLoggedIn;

    main_ui     = root->findChild<QObject*>("Message");
    new_ui      = main_ui->findChild<QObject*>("MessageNew");
    action_ui   = main_ui->findChild<QObject*>("MessageAction");
    sidebar_ui  = main_ui->findChild<QObject*>("MessageSidebar");

    new_input_to_ui   = main_ui->findChild<QObject*>("MessageNewTo");
    new_input_cc_ui   = main_ui->findChild<QObject*>("MessageNewCc");
    new_attachbar     = main_ui->findChild<QObject*>("MessageAttachbar");

    inbox_ui  = sidebar_ui->findChild<QObject*>("InboxList");
    outbox_ui = sidebar_ui->findChild<QObject*>("OutboxList");
    search_ui = sidebar_ui->findChild<QObject*>("SearchList");

    connect(main_ui, SIGNAL(showMessage(QString)), this, SLOT(showMessage(QString)));

    connect(action_ui, SIGNAL(attachNewFile()), this, SLOT(attachNewFile()));
    connect(action_ui, SIGNAL(newMessageClicked()), this, SLOT(newMessageClicked()));

    connect(sidebar_ui, SIGNAL(syncInbox()), this, SLOT(syncInbox()));
    connect(sidebar_ui, SIGNAL(syncOutbox()), this, SLOT(syncOutbox()));
    connect(sidebar_ui, SIGNAL(syncMessages()), this, SLOT(syncMessages()));

    connect(inbox_ui, SIGNAL(readMessage(QString)), this, SLOT(readMessage(QString)));
    connect(outbox_ui, SIGNAL(readMessage(QString)), this, SLOT(readMessage(QString)));
    connect(search_ui, SIGNAL(readMessage(QString)), this, SLOT(readMessage(QString)));

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

void HhmMessage::loginSuccessfully()
{
    loadInboxEmails();
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

/***************** Main Slots *****************/

void HhmMessage::showMessage(QString idMessage)
{
    qDebug() << "showMessage" << idMessage.toLong();
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
    new_data.id = QDateTime::currentMSecsSinceEpoch();
    //Insert new row message
    QString columns = "`" + QString(HHM_MESSAGE_ID) + "`";
    QString values  = "'" + QString::number(new_data.id) + "'";
    db->insert(HHM_TABLE_MESSAGE, columns, values);
}

/***************** Sidebar Slots *****************/
void HhmMessage::syncInbox()
{
    loadInboxEmails();
    hhm_updateFromServer();
    QMetaObject::invokeMethod(sidebar_ui, "finishSync");
}

void HhmMessage::syncOutbox()
{
    loadOutboxEmails();
    hhm_updateFromServer();
    QMetaObject::invokeMethod(sidebar_ui, "finishSync");
}

void HhmMessage::syncMessages()
{
    syncInbox();
    syncOutbox();
}

/***************** Box Slots *****************/
void HhmMessage::readMessage(QString idMessage)
{
//    //Change State `opened` Email
//    QString condition = "`" + QString(HHM_EMAIL_ID) + "`=" + QString::number(idEmail);
//    QString value = "`" + QString(HHM_EMAIL_OPENED) + "`=" + QString::number(1);
//    db->update(condition, value, HHM_TABLE_EMAIL);
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
    dst_filename = hhm_appendMessageId(src, new_data.id);
    dst_filename = QFileInfo(dst_filename).fileName();

    dst_filepath  = dst_filename;
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
    updateJUM();
    QMetaObject::invokeMethod(main_ui, "successfullySend");
}

/*
 * Insert filename at position
 * 'attach_file_ind' in new_data.filenames
 * into 'HHM_TABLE_FILES'
 * */
void HhmMessage::insertNewFile()
{
    QString columns  = "`" + QString(HHM_FILES_FILENAME) + "`";
    columns  += ", `" + QString(HHM_FILES_MESSAGE_ID) + "`";

    QString src = new_data.filenames.at(attach_file_ind);
    QString filename = hhm_appendMessageId(src, new_data.id);
    filename = QFileInfo(filename).fileName();

    QString values  = "'" + filename + "'";
    values += ", '" + QString::number(new_data.id) + "'";

    db->insert(HHM_TABLE_FILES, columns, values);
}

void HhmMessage::updateMessage()
{
    QString condition = "`" + QString(HHM_MESSAGE_ID) + "`=" +
                        QString::number(new_data.id);
    QString values = "`" + QString(HHM_MESSAGE_SUBJECT) + "`='" +
                     new_data.subject + "'";
    values += ", `" + QString(HHM_MESSAGE_CONTENT) + "`='" +
              new_data.content + "'";

    QLocale locale(QLocale::English);
    QString date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");
    values += ", `" + QString(HHM_MESSAGE_SEND_DATE) + "`='" +
              date + "'";
    db->update(condition, values, HHM_TABLE_MESSAGE);
}

void HhmMessage::updateJUM()
{
    QVariantList r_user;//Receiver(to,cc) user

    insertNewUserMessage(m_user->getId(), SENDER_FLAG);

    for(int to_ind=0; to_ind<new_data.toData.length(); to_ind++)
    {
        r_user = new_data.toData.at(to_ind).toList();
        insertNewUserMessage(r_user.at(ID_INDEX).toInt(), TO_FLAG);
    }

    for(int cc_ind=0; cc_ind<new_data.ccData.length(); cc_ind++)
    {
        r_user = new_data.toData.at(cc_ind).toList();
        insertNewUserMessage(r_user.at(ID_INDEX).toInt(), CC_FLAG);
    }
}

void HhmMessage::insertNewUserMessage(int idUser, int flag)
{
//    QVariantList user = new_data.toData.at(to_ind).toList();
    QString columns = "`" + QString(HHM_JUM_USER_ID) + "`";
    columns += ", `" + QString(HHM_JUM_MESSAGE_ID) + "`";
    if( flag==SENDER_FLAG )
    {
        columns += ", `" + QString(HHM_JUM_SENDER_FLAG) + "`";
    }
    else if( flag==TO_FLAG )
    {
        columns += ", `" + QString(HHM_JUM_TO_FLAG) + "`";
    }
    else if( flag==CC_FLAG )
    {
        columns += ", `" + QString(HHM_JUM_CC_FLAG) + "`";
    }

    QString values  = "'" + QString::number(idUser) + "'";
    values += ", '" + QString::number(new_data.id) + "'";
    values += ", '1'";
    db->insert(HHM_TABLE_JOIN_USER_MESSAGE, columns, values);
}

/***************** Sidebar Functions *****************/
void HhmMessage::loadInboxEmails()
{
    QString condition = "`" + QString(HHM_JUM_USER_ID) + "`=" +
                        QString::number(m_user->getId());
    condition += " AND ( `" + QString(HHM_JUM_TO_FLAG) + "`='1'";
    condition += " OR `" + QString(HHM_JUM_CC_FLAG) + "`='1')";
    QSqlQuery res = db->select(HHM_JUM_MESSAGE_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    while( res.next() )
    {
        qDebug() << res.value(0).toString();
        addMessageToSidebar(inbox_ui, res.value(0).toLongLong());
    }
}

void HhmMessage::loadOutboxEmails()
{
//    showEmailInSidebar(outbox_ui, getIdEmails(HHM_UE_SENT_EMAILS));
}

void HhmMessage::addMessageToSidebar(QObject *list_ui, qint64 messageId)
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
            QQmlProperty::write(list_ui, "subject", data.toInt());
        }

//        data = res.value(HHM_MESSAGE_CONTENT);
//        if( data.isValid() )
//        {
//            QQmlProperty::write(list_ui, "text_subject", data.toString());
//        }

        data = res.value(HHM_MESSAGE_SEND_DATE);
        if( data.isValid() )
        {
            QQmlProperty::write(list_ui, "date", data.toInt());
        }

        QQmlProperty::write(list_ui, "isRead", false);
        QMetaObject::invokeMethod(list_ui, "addToList");
    }
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
