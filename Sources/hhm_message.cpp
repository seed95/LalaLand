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
    attach_ui   = main_ui->findChild<QObject*>("MessageAttachbar");

    new_input_to_ui   = new_ui->findChild<QObject*>("MessageNewTo");
    new_input_cc_ui   = new_ui->findChild<QObject*>("MessageNewCc");

    connect(main_ui, SIGNAL(sendNewMessage(QVariant, QVariant, QString, QString, QVariant)),
            this, SLOT(sendNewMessage(QVariant, QVariant, QString, QString, QVariant)));
    connect(main_ui, SIGNAL(messageClicked(QString)), this, SLOT(messageClicked(QString)));
    connect(main_ui, SIGNAL(replyMessage(QString)), this, SLOT(replyMessage(QString)));
    connect(main_ui, SIGNAL(sendReplyMessage(QVariant, QVariant, QString, QString, QVariant, QString)),
            this, SLOT(sendReplyMessage(QVariant, QVariant, QString, QString, QVariant, QString)));

    connect(action_ui, SIGNAL(attachNewFile()), this, SLOT(attachNewFile()));
    connect(action_ui, SIGNAL(newMessageClicked()), this, SLOT(newMessageClicked()));

    connect(view_ui, SIGNAL(downloadAttachFile(int)), this, SLOT(downloadAttachFile(int)));

    connect(new_input_to_ui, SIGNAL(addNewTag(QString)), this, SLOT(addNewTagTo(QString)));
    connect(new_input_cc_ui, SIGNAL(addNewTag(QString)), this, SLOT(addNewTagCc(QString)));

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
    hhm_log("Download Successfully: " + filename);
    hhm_showMessage("Download Successfully", 2000);
}

void HhmMessage::downloadFailed(QString filename)
{
    ///FIXME: complete this segment
    hhm_log("Download Failed: " + filename);
    hhm_showMessage("Download Failed", 2000);
}

/***************** Main Slots *****************/
void HhmMessage::sendNewMessage(QVariant toData, QVariant ccData,
                                QString subject, QString content,
                                QVariant attachFiles)
{
    if( toData.toList().size()==0 )
    {
        hhm_showMessage("Please select that you want to send which user", 5000);
        return;
    }

    new_data.senderId   = m_user->getId();
    new_data.toData     = toData.toList();
    new_data.ccData     = ccData.toList();
    new_data.subject    = subject;
    new_data.content    = content;
    new_data.filenames  = attachFiles.toStringList();
    new_data.replyMode  = false;
    new_data.replyId    = -1;

    attach_file_ind = -1;
    uploadNextFile();
}

void HhmMessage::messageClicked(QString idMessage)
{
    QMetaObject::invokeMethod(view_ui, "clearMessages");
    qint64 message_id = idMessage.toLongLong();
    showMessage(message_id);
    QMetaObject::invokeMethod(main_ui, "showMessage");
}

void HhmMessage::replyMessage(QString replyMessageId)
{
    qint64 reply_message_id = replyMessageId.toLong();
    QMetaObject::invokeMethod(view_ui, "clearMessages");
    showMessage(reply_message_id);
    setToTagForReply(reply_message_id);
    setCcTagsForReply(reply_message_id);

    new_data.id = QDateTime::currentMSecsSinceEpoch();
    //Insert new row message
    QString columns = "`" + QString(HHM_MESSAGE_ID) + "`";
    QString values  = "'" + QString::number(new_data.id) + "'";
    db->insert(HHM_TABLE_MESSAGE, columns, values);
}

void HhmMessage::sendReplyMessage(QVariant toData, QVariant ccData,
                                  QString subject, QString content,
                                  QVariant attachFiles, QString replyMessageId)
{
    if( toData.toList().size()==0 )
    {
        hhm_showMessage("Please select that you want to send which user", 5000);
        return;
    }

    new_data.senderId   = m_user->getId();
    new_data.toData     = toData.toList();
    new_data.ccData     = ccData.toList();
    new_data.subject    = subject;
    new_data.content    = content;
    new_data.filenames  = attachFiles.toStringList();
    new_data.replyMode  = true;
    new_data.replyId    = replyMessageId.toLong();

    attach_file_ind = -1;
    uploadNextFile();
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
        QQmlProperty::write(attach_ui, "attach_filename", file_path);
        QMetaObject::invokeMethod(attach_ui, "addAttachFile");
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
void HhmMessage::addNewTagTo(QString name)
{
    if( !addUserTag(name, new_input_to_ui) )
    {
        if( !addDepartmentTag(name, new_input_to_ui) )
        {
            QMetaObject::invokeMethod(new_input_to_ui, "nameNotFound");
        }
    }
}

void HhmMessage::addNewTagCc(QString name)
{ 
    if( !addUserTag(name, new_input_cc_ui) )
    {
        if( !addDepartmentTag(name, new_input_cc_ui) )
        {
            QMetaObject::invokeMethod(new_input_cc_ui, "nameNotFound");
        }
    }
}

/***************** View Slots *****************/
void HhmMessage::downloadAttachFile(int fileId)
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

/***************** New Functions *****************/
/*
 * Fill 'dst_filenames' with filename at
 * position 'attach_file_ind' in
 * new_data.filenames
 * */
void HhmMessage::fillDestinationFilenames()
{
    dst_filenames.clear();
    QString src, dst_filepath, dst_filename;
    QVariantList receiver;//Receiver(to,cc) user or department

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
        receiver = new_data.toData.at(to_ind).toList();
        if( receiver.at(TAG_MODE_INDEX).toInt()==HHM_TAG_USER )
        {
            ///FIXME: Ask Bijan
            dst_filepath = receiver.at(TAG_USERNAME_INDEX).toString().toLower() + "/Received/" + dst_filename;
            dst_filenames.append(dst_filepath);
        }
        else//HHM_TAG_DEPARTMENT
        {
            dst_filepath = "Department/" + receiver.at(TAG_ID_INDEX).toString().toLower() + "/" + dst_filename;
            dst_filenames.append(dst_filepath);
        }
    }

    for(int cc_ind=0; cc_ind<new_data.ccData.length(); cc_ind++)
    {
        receiver = new_data.ccData.at(cc_ind).toList();
        if( receiver.at(TAG_MODE_INDEX).toInt()==HHM_TAG_USER )
        {
            ///FIXME: Ask Bijan
            dst_filepath = receiver.at(TAG_USERNAME_INDEX).toString().toLower() + "/Received/" + dst_filename;
            dst_filenames.append(dst_filepath);
        }
        else//HHM_TAG_DEPARTMENT
        {
            dst_filepath = "Department/" + receiver.at(TAG_ID_INDEX).toString().toLower() + "/" + dst_filename;
            dst_filenames.append(dst_filepath);
        }
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
    if( new_data.replyMode )
    {
        updateSourceMessage();
    }
    updateMessage();
    updateJoinMessage();
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

    if( new_data.replyMode )
    {
        int number_sources = 0;
        QString condition = "`" + QString(HHM_MESSAGE_ID) + "`=" +
                            QString::number(new_data.replyId);
        QSqlQuery res = db->select(HHM_MESSAGE_NUMBER_SOURCES, HHM_TABLE_MESSAGE, condition);
        if( res.next() )
        {
            number_sources = res.value(0).toInt() + 1;
        }
        values += ", `" + QString(HHM_MESSAGE_NUMBER_SOURCES) + "`='" +
                  QString::number(number_sources) + "'";

        values += ", `" + QString(HHM_MESSAGE_SOURCE_ID) + "`='" +
                  QString::number(new_data.replyId) + "'";
    }

    db->update(condition, values, HHM_TABLE_MESSAGE);
}

void HhmMessage::updateSourceMessage()
{
    QString condition = "`" + QString(HHM_MESSAGE_ID) + "`=" +
                        QString::number(new_data.replyId);
    QString values = "`" + QString(HHM_MESSAGE_SOURCE_FLAG) + "`='1'";
    db->update(condition, values, HHM_TABLE_MESSAGE);
}

/*
 * Update tables that join with message
 * JoinUserMessage, JoinDepartmentMessage
 * */
void HhmMessage::updateJoinMessage()
{
    QVariantList receiver;//Receiver(to,cc) user or department

    insertNewUserMessage(m_user->getId(), SENDER_FLAG);

    int department_id;
    for(int to_ind=0; to_ind<new_data.toData.length(); to_ind++)
    {
        receiver = new_data.toData.at(to_ind).toList();
        if( receiver.at(TAG_MODE_INDEX).toInt()==HHM_TAG_USER )
        {
            insertNewUserMessage(receiver.at(TAG_ID_INDEX).toInt(), TO_FLAG);
        }
        else//HHM_TAG_DEPARTMENT
        {
            department_id = receiver.at(TAG_ID_INDEX).toInt();
            insertNewDepartmentMessage(department_id, TO_FLAG);
            insertNewMessageForDepartment(department_id, department_id);
        }
    }

    for(int cc_ind=0; cc_ind<new_data.ccData.length(); cc_ind++)
    {
        receiver = new_data.ccData.at(cc_ind).toList();
        if( receiver.at(TAG_MODE_INDEX).toInt()==HHM_TAG_USER )
        {
            insertNewUserMessage(receiver.at(TAG_ID_INDEX).toInt(), CC_FLAG);
        }
        else//HHM_TAG_DEPARTMENT
        {
            department_id = receiver.at(TAG_ID_INDEX).toInt();
            insertNewDepartmentMessage(department_id, TO_FLAG);
            insertNewMessageForDepartment(department_id, department_id);
        }
    }
}

void HhmMessage::insertNewUserMessage(int userId, int flag)
{
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

    QString values  = "'" + QString::number(userId) + "'";
    values += ", '" + QString::number(new_data.id) + "'";
    values += ", '1'";
    db->insert(HHM_TABLE_JOIN_USER_MESSAGE, columns, values);
}

/*
 * Insert new message for all users in department
 * and groups in department
 * */
void HhmMessage::insertNewMessageForDepartment(int departmentId, int groupId)
{
    QString condition = "`" + QString(HHM_USER_DEPARTMENT_ID) + "`=" +
                        QString::number(groupId);
    QSqlQuery res = db->select(HHM_USER_ID, HHM_TABLE_USER, condition);
    while( res.next() )
    {
        insertNewDepartmentUserMessage(departmentId, res.value(0).toInt());
    }

    condition = "`" + QString(HHM_JDG_DEPARTMENT_ID) + "`=" +
                QString::number(groupId);
    res = db->select(HHM_JDG_GROUP_ID, HHM_TABLE_DEPARTMENT_GROUP, condition);
    while( res.next() )
    {
        insertNewMessageForDepartment(departmentId, res.value(0).toInt());
    }
}

void HhmMessage::insertNewDepartmentMessage(int departmentId, int flag)
{
    QString columns = "`" + QString(HHM_JDM_DEPARTMENT_ID) + "`";
    columns += ", `" + QString(HHM_JDM_MESSAGE_ID) + "`";
    if( flag==TO_FLAG )
    {
        columns += ", `" + QString(HHM_JDM_TO_FLAG) + "`";
    }
    else if( flag==CC_FLAG )
    {
        columns += ", `" + QString(HHM_JDM_CC_FLAG) + "`";
    }
    QString values  = "'" + QString::number(departmentId) + "'";
    values += ", '" + QString::number(new_data.id) + "'";
    values += ", '1'";
    db->insert(HHM_TABLE_JOIN_DEPARTMENT_MESSAGE, columns, values);
}

void HhmMessage::insertNewDepartmentUserMessage(int departmentId, int userId)
{
    QString columns = "`" + QString(HHM_JDUM_DEPARTMENT_ID) + "`";
    columns += ", `" + QString(HHM_JDUM_USER_ID) + "`";
    columns += ", `" + QString(HHM_JDUM_MESSAGE_ID) + "`";

    QString values  = "'" + QString::number(departmentId) + "'";
    values += ", '" + QString::number(userId) + "'";
    values += ", '" + QString::number(new_data.id) + "'";
    db->insert(HHM_TABLE_JOIN_DEPARTMENT_USER_MESSAGE, columns, values);
}

/***************** View Functions *****************/
void HhmMessage::showMessage(qint64 messageId)
{
    qDebug() << "showMessage" << messageId;
    QString condition = "`" + QString(HHM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    QSqlQuery res = db->select("*", HHM_TABLE_MESSAGE, condition);
    if( res.next() )
    {
        QQmlProperty::write(view_ui, "messageId", QString::number(messageId));

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

        QQmlProperty::write(view_ui, "senderName", getSenderName(messageId));
        QQmlProperty::write(view_ui, "toName", getToNames(messageId));
        QQmlProperty::write(view_ui, "ccName", getCcNames(messageId));

        data = res.value(HHM_MESSAGE_SEND_DATE);
        if( data.isValid() )
        {
            QLocale locale(QLocale::Arabic);
            QDateTime message_date = data.toDateTime();
            QString date = locale.toString(message_date, "dd MMMM/");
            date += locale.toString(message_date, " أيار yyyy");
            date += locale.toString(message_date, " الساعة hh:mm");
            QQmlProperty::write(view_ui, "dateTime", date);
        }

        QVariantList files = getAttachFiles(messageId);
        QQmlProperty::write(view_ui, "files", files);
        QMetaObject::invokeMethod(view_ui, "addMessage");

        data = res.value(HHM_MESSAGE_SOURCE_ID);
        qDebug() << data.toLongLong();
        if( !data.isNull() )
        {
            showMessage(data.toLongLong());
        }

    }
}

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
    QStringList result;

    QString message_condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`='" +
                                QString::number(messageId) + "'";
    QString to_condition = "`" + QString(HHM_JUM_TO_FLAG) + "`='1'";
    QString condition = message_condition + " AND " + to_condition;
    QSqlQuery res = db->select(HHM_JUM_USER_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    while( res.next() )
    {
        result.append(m_user->getName(res.value(0).toInt()));
    }

    message_condition = "`" + QString(HHM_JDM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    to_condition = "`" + QString(HHM_JDM_TO_FLAG) + "`='1'";
    condition = message_condition + " AND " + to_condition;
    res = db->select(HHM_JDM_DEPARTMENT_ID, HHM_TABLE_JOIN_DEPARTMENT_MESSAGE, condition);
    while( res.next() )
    {
        result.append(getDepartmentName(res.value(HHM_JDM_DEPARTMENT_ID).toInt()));
    }

    return result.join(",");
}

QString HhmMessage::getCcNames(qint64 messageId)
{
    QStringList result;

    QString message_condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" +
                                QString::number(messageId);
    QString cc_condition = "`" + QString(HHM_JUM_CC_FLAG) + "`='1'";
    QString condition = message_condition + " AND " + cc_condition;
    QSqlQuery res = db->select(HHM_JUM_USER_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    while( res.next() )
    {
        result.append(m_user->getName(res.value(0).toInt()));
    }

    message_condition = "`" + QString(HHM_JDM_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    cc_condition = "`" + QString(HHM_JUM_CC_FLAG) + "`='1'";
    condition = message_condition + " AND " + cc_condition;
    res = db->select(HHM_JDM_DEPARTMENT_ID, HHM_TABLE_JOIN_DEPARTMENT_MESSAGE, condition);
    while( res.next() )
    {
        result.append(getDepartmentName(res.value(HHM_JDM_DEPARTMENT_ID).toInt()));
    }

    return result.join(",");
}

QVariantList HhmMessage::getAttachFiles(qint64 messageId)
{
    QString condition = "`" + QString(HHM_FILES_MESSAGE_ID) + "`=" +
                        QString::number(messageId);
    QSqlQuery res = db->select("*", HHM_TABLE_FILES, condition);
    QVariantList result;
    while( res.next() )
    {
        QVariantMap item;
        QVariant data = res.value(HHM_FILES_ID);
        if( data.isValid() )
        {
            ///Note: Dont Change 'fileId' Key(used in qml)
            item.insert("fileId", data.toInt());
        }

        data = res.value(HHM_FILES_FILENAME);
        if( data.isValid() )
        {
            ///Note: Dont Change 'fileName' Key(used in qml)
            item.insert("fileName", hhm_removeMessageId(data.toString(), messageId));
        }

        result.append(item);
    }
    return result;
}

/***************** Utility Functions *****************/
void HhmMessage::setToTagForReply(qint64 replyMessageId)
{
    QString message_condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" +
                                QString::number(replyMessageId);
    QString sender_condition = "`" + QString(HHM_JUM_SENDER_FLAG) + "`='1'";
    QString condition = message_condition + " AND " + sender_condition;
    QSqlQuery res = db->select(HHM_JUM_USER_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    if( res.next() )
    {
        addUserTag(m_user->getUsername(res.value(HHM_JUM_USER_ID).toInt()), new_input_to_ui);
    }
}

void HhmMessage::setCcTagsForReply(qint64 replyMessageId)
{
    QString message_condition = "`" + QString(HHM_JUM_MESSAGE_ID) + "`=" +
                                QString::number(replyMessageId);
    QString cc_condition = "`" + QString(HHM_JUM_CC_FLAG) + "`='1'";
    QString condition = message_condition + " AND " + cc_condition;
    QSqlQuery res = db->select(HHM_JUM_USER_ID, HHM_TABLE_JOIN_USER_MESSAGE, condition);
    while( res.next() )
    {
        addUserTag(m_user->getUsername(res.value(HHM_JUM_USER_ID).toInt()), new_input_cc_ui);
    }

    message_condition = "`" + QString(HHM_JDM_MESSAGE_ID) + "`=" +
                        QString::number(replyMessageId);
    cc_condition = "`" + QString(HHM_JDM_CC_FLAG) + "`='1'";
    condition = message_condition + " AND " + cc_condition;
    res = db->select(HHM_JDM_DEPARTMENT_ID, HHM_TABLE_JOIN_DEPARTMENT_MESSAGE, condition);
    while( res.next() )
    {
        addDepartmentTag(getDepartmentName(res.value(HHM_JDM_DEPARTMENT_ID).toInt()), new_input_cc_ui);
    }
}

/***************** Utility Functions *****************/
bool HhmMessage::addUserTag(QString username, QObject *ui)
{
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    if( !res.next() )
    {
        return false;
    }

    QQmlProperty::write(ui, "tagMode", 1);
    QVariant data = res.value(HHM_USER_ID);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "tagId", data.toInt());
    }

    QString name = "";
    data = res.value(HHM_USER_FIRSTNAME);
    if( data.isValid() )
    {
        name = data.toString();
    }

    data = res.value(HHM_USER_LASTNAME);
    if( data.isValid() )
    {
        name += " " + data.toString();
    }
    QQmlProperty::write(ui, "tagName", name);

    data = res.value(HHM_USER_USERNAME);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "tagUsername", data.toString());
    }

    QMetaObject::invokeMethod(ui, "addTag");
    return true;
}

bool HhmMessage::addDepartmentTag(QString name, QObject *ui)
{
    QString condition = "`" + QString(HHM_DEPARTMENT_ID) + "`='" + name + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_DEPARTMENT, condition);
    if( !res.next() )
    {
        return false;
    }

    QQmlProperty::write(ui, "tagMode", 2);
    QVariant data = res.value(HHM_DEPARTMENT_ID);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "tagId", data.toInt());
    }

    data = res.value(HHM_DEPARTMENT_NAME);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "tagName", data.toString());
    }

    QQmlProperty::write(ui, "tagUsername", "");

    QMetaObject::invokeMethod(ui, "addTag");
    return true;
}

QString HhmMessage::getDepartmentName(int departmentId)
{
    QString condition = "`" + QString(HHM_DEPARTMENT_ID) + "`=" +
                        QString::number(departmentId);
    QSqlQuery res = db->select(HHM_DEPARTMENT_NAME, HHM_TABLE_DEPARTMENT, condition);
    if( res.next() )
    {
        return res.value(HHM_DEPARTMENT_NAME).toString();
    }
    return "";
}
