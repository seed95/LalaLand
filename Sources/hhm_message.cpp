#include "hhm_message.h"

HhmMessage::HhmMessage(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                       QObject *parent) : QObject(parent)
{
    db = database;
    m_user = userLoggedIn;

    main_ui     = root->findChild<QObject*>("Message");
    action_ui   = main_ui->findChild<QObject*>("MessageAction");
    sidebar_ui  = main_ui->findChild<QObject*>("MessageSidebar");
    new_ui      = main_ui->findChild<QObject*>("MessageNew");
    view_ui     = main_ui->findChild<QObject*>("MessageView");

    new_input_to_ui   = main_ui->findChild<QObject*>("MessageNewTo");
    new_input_cc_ui   = main_ui->findChild<QObject*>("MessageNewCc");
    new_attachbar     = main_ui->findChild<QObject*>("MessageAttachbar");

    view_downloadbar_ui  = view_ui->findChild<QObject*>("MessageDownloadbar");

    connect(main_ui, SIGNAL(messageClicked(QString)), this, SLOT(messageClicked(QString)));

    connect(action_ui, SIGNAL(attachNewFile()), this, SLOT(attachNewFile()));
    connect(action_ui, SIGNAL(newMessageClicked()), this, SLOT(newMessageClicked()));

    connect(new_ui, SIGNAL(sendNewMessage(QVariant, QVariant, QString, QString, QVariant)),
            this, SLOT(sendNewMessage(QVariant, QVariant, QString, QString, QVariant)));

    connect(new_input_to_ui, SIGNAL(addNewUsername(QString)), this, SLOT(addNewUsernameTo(QString)));
    connect(new_input_cc_ui, SIGNAL(addNewUsername(QString)), this, SLOT(addNewUsernameCc(QString)));

    connect(view_ui, SIGNAL(downloadFile(int)), this, SLOT(downloadFile(int)));

    sidebar = new HhmMessageSidebar(sidebar_ui, database, userLoggedIn);

    ftp = new HhmFtp();
    connect(ftp, SIGNAL(uploadSuccess(QString)), this, SLOT(uploadSuccess(QString)));
    connect(ftp, SIGNAL(uploadFailed(QString)), this, SLOT(uploadFailed(QString)));
    connect(ftp, SIGNAL(downloadSuccess(QString)), this, SLOT(downloadSuccess(QString)));
    connect(ftp, SIGNAL(downloadFailed(QString)), this, SLOT(downloadFailed(QString)));

#ifdef HHM_DEV_MODE
    sidebar->loadMessages();
#endif
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
    sidebar->loadMessages();
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
void HhmMessage::messageClicked(QString idMessage)
{
    qint64 message_id = idMessage.toLong();
    QString condition = "`" + QString(HHM_MESSAGE_ID) + "`=" +
                        QString::number(message_id);
    QSqlQuery res = db->select("*", HHM_TABLE_MESSAGE, condition);
    if( res.next() )
    {
        QQmlProperty::write(view_ui, "messageId", QString::number(message_id));

        QVariant data = res.value(HHM_MESSAGE_SUBJECT);
        if( data.isValid() )
        {
            QQmlProperty::write(view_ui, "subject", data.toString());
        }

        data = res.value(HHM_MESSAGE_CONTENT);
        if( data.isValid() )
        {
            QQmlProperty::write(view_ui, "content", data.toString());
        }

        QQmlProperty::write(view_ui, "senderName", getSenderName(message_id));
        QQmlProperty::write(view_ui, "toName", getToNames(message_id));
        QQmlProperty::write(view_ui, "ccName", getCcNames(message_id));

        data = res.value(HHM_MESSAGE_SEND_DATE);
        if( data.isValid() )
        {
            QLocale locale(QLocale::Arabic);
            QDateTime message_date = data.toDateTime();
            QString date = locale.toString(message_date, "dd MMMM/");
            date += locale.toString(message_date, " أيار yyyy");
            date += locale.toString(message_date, " الساعة hh:mm");
            QQmlProperty::write(view_ui, "dateTime",date);
        }

        setAttachFiles(message_id);
    }

    QMetaObject::invokeMethod(main_ui, "showMessage");
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

/***************** View Slots *****************/
void HhmMessage::downloadFile(int fileId)
{
    QString src;
    qint64 message_id = 0;
    QString condition = "`" + QString(HHM_FILES_ID) + "`=" +
                        QString::number(fileId);
    QSqlQuery res = db->select("*", HHM_TABLE_FILES, condition);
    if( res.next() )
    {
        QVariant data = res.value(HHM_FILES_FILENAME);
        if( data.isValid() )
        {
            src = data.toString();
        }

        data = res.value(HHM_FILES_MESSAGE_ID);
        if( data.isValid() )
        {
            message_id = data.toLongLong();
        }
    }

    QString file_name = QFileInfo(hhm_removeMessageId(src, message_id)).fileName();
    QString dir = QFileDialog::getExistingDirectory(NULL,
                                                    "Choose Directory to Save " + file_name,
                                                    hhm_getLastDirectory());
    if( dir.length() )
    {
        hhm_setLastDirectory(dir);
        QString dst = dir + "/" + file_name;
        ftp->downloadFile(src, dst);
    }
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
    sidebar->loadOutbox();
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
        r_user = new_data.ccData.at(cc_ind).toList();
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

/***************** View Functions *****************/
QString HhmMessage::getSenderName(qint64 messageId)
{
    QString condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    condition += " AND `" + QString(HHM_JUM_SENDER_FLAG) + "`='1'";
    QSqlQuery res = db->select(HHM_JUM_USER_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    if( res.next() )
    {
        return m_user->getName(res.value(0).toInt());
    }
    return "";
}

QString HhmMessage::getToNames(qint64 messageId)
{
    QString condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    condition += " AND `" + QString(HHM_JUM_TO_FLAG) + "`='1'";
    QSqlQuery res = db->select(HHM_JUM_USER_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    QStringList result;
    while( res.next() )
    {
        result.append(m_user->getName(res.value(0).toInt()));
    }

    return result.join(",");
}

QString HhmMessage::getCcNames(qint64 messageId)
{
    QString condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    condition += " AND `" + QString(HHM_JUM_CC_FLAG) + "`='1'";
    QSqlQuery res = db->select(HHM_JUM_USER_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    QStringList result;
    while( res.next() )
    {
        result.append(m_user->getName(res.value(0).toInt()));
    }

    return result.join(",");
}

void HhmMessage::setAttachFiles(qint64 messageId)
{
    QMetaObject::invokeMethod(view_downloadbar_ui, "removeAllAttach");

    QString condition = "`" + QString(HHM_FILES_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    QSqlQuery res = db->select("*", HHM_TABLE_FILES, condition);
    QString filename;
    while( res.next() )
    {
        QVariant data = res.value(HHM_FILES_ID);
        if( data.isValid() )
        {
            QQmlProperty::write(view_downloadbar_ui, "attach_fileId", data.toInt());
        }

        data = res.value(HHM_FILES_FILENAME);
        if( data.isValid() )
        {
            filename = hhm_removeMessageId(data.toString(), messageId);
            QQmlProperty::write(view_downloadbar_ui, "attach_filename", filename);
        }

        QMetaObject::invokeMethod(view_downloadbar_ui, "addAttachFile");
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
