#include "hhm_document.h"

HhmDocument::HhmDocument(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                         QObject *parent) : QObject(parent)
{
    db = database;
    m_user = userLoggedIn;

    main_ui     = root->findChild<QObject*>("Document");
    action_ui   = main_ui->findChild<QObject*>("DocumentAction");
    sidebar_ui  = main_ui->findChild<QObject*>("DocumentSidebar");
    new_ui      = main_ui->findChild<QObject*>("DocumentNew");
    view_ui     = main_ui->findChild<QObject*>("DocumentView");

    new_attachbar   = new_ui->findChild<QObject*>("DocumentNewAttachbar");
    view_attachbar  = view_ui->findChild<QObject*>("DocumentViewAttachbar");

    connect(main_ui, SIGNAL(documentClicked(int)), this, SLOT(showDocument(int)));

    connect(action_ui, SIGNAL(newDocumentClicked()), this, SLOT(newDocumentClicked()));

    connect(new_ui, SIGNAL(checkUsername(QString)), this, SLOT(checkUsername(QString)));
    connect(new_ui, SIGNAL(uploadFileClicked()), this, SLOT(uploadFileClicked()));
    connect(new_ui, SIGNAL(sendNewDocument(int, QVariant, QString, QVariant, QString)),
            this, SLOT(sendNewDocument(int, QVariant, QString, QVariant, QString)));

    connect(view_ui, SIGNAL(downloadFile(int, int)), this, SLOT(downloadFile(int, int)));
    connect(view_ui, SIGNAL(approveDocument(int, QString)), this, SLOT(approveDocument(int, QString)));
    connect(view_ui, SIGNAL(rejectDocument(int)), this, SLOT(rejectDocument(int)));

    //Instance Sidebar
    sidebar = new HhmSidebar(sidebar_ui, db, m_user);

    setDocumentBaseId();

    ftp = new HhmFtp();
    connect(ftp, SIGNAL(uploadSuccess(QString)), this, SLOT(uploadSuccess(QString)));
    connect(ftp, SIGNAL(uploadFailed(QString)), this, SLOT(uploadFailed(QString)));
    connect(ftp, SIGNAL(downloadSuccess(QString)), this, SLOT(downloadSuccess(QString)));
    connect(ftp, SIGNAL(downloadFailed(QString)), this, SLOT(downloadFailed(QString)));

#ifdef HHM_DEV_MODE
    sidebar->loadEmails();
#endif
}

HhmDocument::~HhmDocument()
{
    if( ftp!=nullptr )
    {
        delete ftp;
    }
}

void HhmDocument::loginSuccessfully()
{
    sidebar->loadEmails();
}

/***************** Ftp Slots *****************/
void HhmDocument::uploadSuccess(QString filename)
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

void HhmDocument::uploadFailed(QString filename)
{
    ///FIXME: complete this segment
    hhm_showMessage("Upload Failed", 2000);
    hhm_log("Upload Failed: " + filename);
}

void HhmDocument::downloadSuccess(QString filename)
{
    hhm_log("Download Successfully " + filename);
    hhm_showMessage("Download Successfully", 2000);
}

void HhmDocument::downloadFailed(QString filename)
{
    ///FIXME: complete this segment
    hhm_log("Download Failed " + filename);
    hhm_showMessage("Download Failed", 2000);
}

/***************** Action Slots *****************/
void HhmDocument::newDocumentClicked()
{
    int new_casenumber = doc_base_id;
    //Get max case number
    QString query = "SELECT MAX(" + QString(HHM_DOCUMENT_CASENUMBER) + ") FROM ";
    query += "`" + QString(DATABASE_NAME) + "`.`" + QString(HHM_TABLE_DOCUMENT) + "`";
    QSqlQuery res = db->sendQuery(query);
    if( res.next() )
    {
        int max_case_number = res.value(0).toInt();
        if( max_case_number>=doc_base_id )
        {
            new_casenumber = max_case_number + 1;//auto increment case number
        }
    }
    QString columns = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`";
    QString values  = "'" + QString::number(new_casenumber) + "'";
    db->insert(HHM_TABLE_DOCUMENT, columns, values);
    QQmlProperty::write(new_ui, "new_casenumber", new_casenumber);
}

/***************** Main Slots *****************/
void HhmDocument::showDocument(int casenumber)
{
    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" + QString::number(casenumber);
    QSqlQuery res = db->select("*", HHM_TABLE_DOCUMENT, condition);
    if( res.next() )
    {
        QVariant data = res.value(HHM_DOCUMENT_CASENUMBER);
        if( data.isValid() )
        {
            QQmlProperty::write(view_ui, "case_number", data.toInt());
        }

        data = res.value(HHM_DOCUMENT_SUBJECT);
        if( data.isValid() )
        {
            QQmlProperty::write(view_ui, "text_subject", data.toString());
        }

        data = res.value(HHM_DOCUMENT_SENDER_ID);
        if( data.isValid() )
        {
            HhmUserTable sender_user = getUser(data.toInt());
            QQmlProperty::write(view_ui, "text_name", sender_user.firstname + " " + sender_user.lastname);
            QQmlProperty::write(view_ui, "text_username", sender_user.username );
        }

        data = res.value(HHM_DOCUMENT_SENDER_NAME);
        if( data.isValid() )
        {
            QQmlProperty::write(view_ui, "text_name", data.toString());
        }

        data = res.value(HHM_DOCUMENT_STATUS);
        if( data.isValid() )
        {
            QQmlProperty::write(view_ui, "doc_status", data.toInt());
        }

        data = res.value(HHM_DOCUMENT_DATE);
        if( data.isValid() )
        {
            QString date;
            QLocale ar_locale(QLocale::Arabic);
            date = ar_locale.toString(data.toDateTime(), "hh:mm");
            QQmlProperty::write(view_ui, "text_time", date);
        }

        data = res.value(HHM_DOCUMENT_RECEIVER_IDS);
        if( data.isValid() )
        {
            QStringList receiver_names;
            QStringList receiver_ids = data.toString().split(",", QString::SkipEmptyParts);
            for(int i=0; i<receiver_ids.length(); i++)
            {
                HhmUserTable receiver_user = getUser(receiver_ids[i].toInt());

                receiver_names.append(receiver_user.firstname + " " + receiver_user.lastname);
            }
            QString separator = "،";
            QQmlProperty::write(view_ui, "text_to", receiver_names.join(separator));
        }

        data = res.value(HHM_DOCUMENT_FILE_IDS);
        if( data.isValid() )
        {
            QMetaObject::invokeMethod(view_ui, "clearAttachbar");
            QStringList file_ids = data.toString().split(",", QString::SkipEmptyParts);
            for(int i=0; i<file_ids.length(); i++)
            {
                HhmFileTable file = getFile(file_ids[i].toInt());
                QString filename = hhm_removeCasenumber(file.filepath, casenumber);
                QQmlProperty::write(view_attachbar, "attach_filename", filename);
                QQmlProperty::write(view_attachbar, "attach_fileId", file.fileId);
                QMetaObject::invokeMethod(view_attachbar, "addAttachFile");
            }
        }

        QStringList table_content;
        data = res.value(HHM_DOCUMENT_DATA1);
        table_content.append(data.toString());

        data = res.value(HHM_DOCUMENT_DATA2);
        table_content.append(data.toString());

        data = res.value(HHM_DOCUMENT_DATA3);
        table_content.append(data.toString());

        data = res.value(HHM_DOCUMENT_DATA4);
        table_content.append(data.toString());

        data = res.value(HHM_DOCUMENT_DATA5);
        table_content.append(data.toString());

        data = res.value(HHM_DOCUMENT_DATA6);
        table_content.append(data.toString());
        QQmlProperty::write(view_ui, "table_content", table_content.join(","));
        QMetaObject::invokeMethod(view_ui, "setTableData");
    }

    QMetaObject::invokeMethod(main_ui, "showDocument");
}

/***************** New Slots *****************/
void HhmDocument::uploadFileClicked()
{
    QString file_path = QFileDialog::getOpenFileName(NULL,
                                                     "Choose Document File",
                                                     hhm_getLastDirectory(),
                                                     "*");

    if( !file_path.isEmpty() )
    {
        hhm_setLastDirectory(QFileInfo(file_path).absolutePath());
        QQmlProperty::write(new_attachbar, "attach_filename", file_path);
        QMetaObject::invokeMethod(new_attachbar, "addAttachFile");
    }
}

void HhmDocument::checkUsername(QString username)
{
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    if( res.next() )
    {
        QVariant data = res.value(HHM_USER_ID);
        if( data.isValid() )
        {
            QQmlProperty::write(new_ui, "receiver_id", data.toInt());
        }
        else
        {
            hhm_log("Receiver id is not valid for username " + username + " (" + data.toString() + ")");
        }
        data = res.value(HHM_USER_USERNAME);
        if( data.isValid() )
        {
            QQmlProperty::write(new_ui, "receiver_username", data.toString());
        }
    }
    else
    {
        QMetaObject::invokeMethod(new_ui, "usernameNotFound");
    }
}

void HhmDocument::sendNewDocument(int caseNumber, QVariant toData,
                                  QString subject, QVariant attachFiles,
                                  QString tableContent)
{
    new_data.filenames = attachFiles.toStringList();
    new_data.toUser    = toData.toList();

//    if( new_data.filenames.isEmpty() )
//    {
//        hhm_showMessage(tr("Please choose a document"), 2000);
//        return;
//    }

//    if( new_data.toUser.at(ID_INDEX).toInt()==-1 )
//    {
//        hhm_showMessage(tr("Entered username is not valid"), 5000);
//        return;
//    }

//    if( subject.isEmpty() )
//    {
//        hhm_showMessage(tr("Please write a subject"), 2000);
//        return;
//    }

    new_data.casenumber     = caseNumber;
    new_data.senderId       = m_user->getId();
    new_data.senderName     = m_user->getName();
    new_data.subject        = subject;
    new_data.tableContent   = tableContent;
    new_data.fileIds.clear();

    QLocale locale(QLocale::English);
    new_data.date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");

    attach_file_ind = -1;
    uploadNextFile();
}

/***************** View Slots *****************/
void HhmDocument::downloadFile(int fileId, int casenumber)
{
    HhmFileTable file = getFile(fileId);
    QString src = hhm_removeCasenumber(file.filepath, casenumber);
    src = QFileInfo(src).fileName();
    QString dir = QFileDialog::getExistingDirectory(NULL,
                                                    "Choose Directory to Save " + src,
                                                    hhm_getLastDirectory());
    if( dir.length() )
    {
        QString dst = dir + "/" + src;
        hhm_setLastDirectory(dir);
        ftp->downloadFile(file.filepath, dst);
    }
}

void HhmDocument::approveDocument(int casenumber, QString tableContent)
{
    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" +
                        QString::number(casenumber);
    QString values = "`" + QString(HHM_DOCUMENT_STATUS) + "`='" +
                     QString::number(HHM_DOC_STATUS_SUCCESS) + "'";

    QStringList table_content = tableContent.split(",");
    values += ", `" + QString(HHM_DOCUMENT_DATA5) + "`='" + table_content[0] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA6) + "`='" + table_content[1] + "'";
    db->update(condition, values, HHM_TABLE_DOCUMENT);
    QString msg = "تم العملية بنجاح";
    hhm_showMessage(msg, 3000);
    sidebar->updateSelectedEmail();
    showDocument(casenumber);//Update Showed document
}

void HhmDocument::rejectDocument(int casenumber)
{
    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`=" +
                        QString::number(casenumber);
    QString value = "`" + QString(HHM_DOCUMENT_STATUS) + "`='" +
                    QString::number(HHM_DOC_STATUS_REJECT) + "'";
    db->update(condition, value, HHM_TABLE_DOCUMENT);
    QString msg = "تم العملية بنجاح";
    hhm_showMessage(msg, 3000);
    sidebar->updateSelectedEmail();
    showDocument(casenumber);//Update Showed document
}

/***************** Private Functions *****************/
void HhmDocument::setDocumentBaseId()
{
    doc_base_id = 0;
    QVariant data = getConfig(HHM_CONFIG_DOCUMENT_BASE_ID);
    if( data.isValid() )
    {
        doc_base_id = data.toInt();
    }
    else
    {
        hhm_log("Not set " + QString(HHM_CONFIG_DOCUMENT_BASE_ID) + " in " + QString(HHM_TABLE_CONFIG));
    }
}

HhmUserTable HhmDocument::getUser(int idUser)
{
    QString condition = "`" + QString(HHM_USER_ID) + "`=" + QString::number(idUser);
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    HhmUserTable user;
    if( res.next() )
    {
        user.userId = idUser;
        QVariant data = res.value(HHM_USER_FIRSTNAME);
        if( data.isValid() )
        {
            user.firstname = data.toString();
        }

        data = res.value(HHM_USER_LASTNAME);
        if( data.isValid() )
        {
            user.lastname = data.toString();
        }

        data = res.value(HHM_USER_USERNAME);
        if( data.isValid() )
        {
            user.username = data.toString();
        }

    }
    return user;
}

HhmFileTable HhmDocument::getFile(int idFile)
{
    QString condition = "`" + QString(HHM_DOCUMENT_FILES_ID) + "`=" + QString::number(idFile);
    QSqlQuery res = db->select("*", HHM_TABLE_DOCUMENT_FILES, condition);
    HhmFileTable file;
    if( res.next() )
    {
        file.fileId = idFile;
        QVariant data = res.value(HHM_DOCUMENT_FILES_FILENAME);
        if( data.isValid() )
        {
            file.filepath = data.toString();
        }
    }
    return file;
}

/*
 * Fill 'dst_filenames' with filename at
 * position 'attach_file_ind' in
 * new_data.filenames
 * */
void HhmDocument::fillDestinationFilenames()
{
    dst_filenames.clear();
    QString src, dst_filepath, dst_filename;
    QVariantList r_user;//Receiver(to) user

    src = new_data.filenames.at(attach_file_ind);
    dst_filename = hhm_appendCasenumber(src, new_data.casenumber);
    dst_filename = QFileInfo(dst_filename).fileName();

    dst_filepath  = dst_filename;
    dst_filenames.append(dst_filepath);

    ///FIXME: Ask Bijan
    dst_filepath = m_user->getUsername().toLower() + "/Send/" + dst_filename;
    dst_filenames.append(dst_filepath);

    ///FIXME: Ask Bijan
    dst_filepath = new_data.toUser.at(USERNAME_INDEX).toString().toLower() + "/Received/" + dst_filename;
    dst_filenames.append(dst_filepath);
}

void HhmDocument::uploadNextFile()
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

void HhmDocument::uploadAttachFilesFinished()
{
    updateDocument();
    insertNewEmail();
    int received_email_id = getMaxId(HHM_EMAIL_ID, HHM_TABLE_EMAIL);
    if( received_email_id==-1 )
    {
        received_email_id = 2;
    }
    int sent_email_id = received_email_id - 1;

    updateReceiverUserEmail(received_email_id);
    updateSenderUserEmail(sent_email_id);

    //Successfully Send Message
    QMetaObject::invokeMethod(main_ui, "successfullySend");
}

void HhmDocument::updateDocument()
{
    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`='" +
                        QString::number(new_data.casenumber) + "'";

    QString values = "`" + QString(HHM_DOCUMENT_FILE_IDS) + "`='" +
                     new_data.fileIds.join(",") + "'";
    values += ", `" + QString(HHM_DOCUMENT_SENDER_ID) + "`='" +
              QString::number(new_data.senderId) + "'";
    values += ", `" + QString(HHM_DOCUMENT_RECEIVER_IDS) + "`='" +
              new_data.toUser.at(ID_INDEX).toString() + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATE) + "`='" + new_data.date + "'";
    values += ", `" + QString(HHM_DOCUMENT_SENDER_NAME) + "`='" + new_data.senderName + "'";
    values += ", `" + QString(HHM_DOCUMENT_SUBJECT) + "`='" + new_data.subject + "'";

    QStringList table_content = new_data.tableContent.split(",");
    values += ", `" + QString(HHM_DOCUMENT_DATA1) + "`='" + table_content[0] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA2) + "`='" + table_content[1] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA3) + "`='" + table_content[2] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA4) + "`='" + table_content[3] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA5) + "`='" + table_content[4] + "'";
    values += ", `" + QString(HHM_DOCUMENT_DATA6) + "`='" + table_content[5] + "'";

    db->update(condition, values, HHM_TABLE_DOCUMENT);
}

void HhmDocument::updateSenderUserEmail(int emailId)
{
    QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(new_data.senderId);
    QSqlQuery res = db->select(HHM_UE_SENT_EMAILS, HHM_TABLE_USER_EMAIL, condition);
    if( res.next() )
    {
        QString emails = res.value(0).toString();
        if( emails.isEmpty() )
        {
            emails = QString::number(emailId);
        }
        else
        {
            emails = QString::number(emailId) + "," + emails;
        }
        condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(new_data.senderId);
        QString value = "`" + QString(HHM_UE_SENT_EMAILS) + "`='" + emails + "'";
        db->update(condition, value, HHM_TABLE_USER_EMAIL);
    }
}

void HhmDocument::updateReceiverUserEmail(int emailId)
{
    QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + new_data.toUser.at(ID_INDEX).toString();
    qDebug() << condition;
    QSqlQuery res = db->select(HHM_UE_RECEIVED_EMAILS, HHM_TABLE_USER_EMAIL, condition);
    if( res.next() )
    {
        qDebug() << res.value(0);
        QString emails = res.value(0).toString();
        if( emails.isEmpty() )
        {
            emails = QString::number(emailId);
        }
        else
        {
            emails = QString::number(emailId) + "," + emails;
        }
        condition = "`" + QString(HHM_UE_USER_ID) + "`=" + new_data.toUser.at(ID_INDEX).toString();
        QString value = "`" + QString(HHM_UE_RECEIVED_EMAILS) + "`='" + emails + "'";
        db->update(condition, value, HHM_TABLE_USER_EMAIL);
    }
}

/*
 * Insert new email into 'HHM_TABLE_EMAIL'
 * */
void HhmDocument::insertNewEmail()
{
    QString columns  = "`" + QString(HHM_EMAIL_DOC_CASENUMBER) + "`";
    columns += ", `" + QString(HHM_EMAIL_SEND_REFERENCE) + "`";
    columns += ", `" + QString(HHM_EMAIL_RECEIVE_REFERENCE) + "`";

    QString values  = "'" + QString::number(new_data.casenumber) + "'";
    values += ", '" + QString::number(1) + "'";
    values += ", '" + QString::number(0) + "'";
    db->insert(HHM_TABLE_EMAIL, columns, values);

    values  = "'" + QString::number(new_data.casenumber) + "'";
    values += ", '" + QString::number(0) + "'";
    values += ", '" + QString::number(1) + "'";
    db->insert(HHM_TABLE_EMAIL, columns, values);
}

/*
 * Insert filename at position
 * 'attach_file_ind' in new_data.filenames
 * into 'HHM_TABLE_FILES'
 * */
void HhmDocument::insertNewFile()
{
    //Insert new row file
    QString columns  = "`" + QString(HHM_DOCUMENT_FILES_FILENAME) + "`, ";
    columns += "`" + QString(HHM_DOCUMENT_FILES_SENDER_ID) + "`, ";
    columns += "`" + QString(HHM_DOCUMENT_FILES_TO_IDS) + "`, ";
    columns += "`" + QString(HHM_DOCUMENT_FILES_CC_IDS) + "`";

    QString filepath = hhm_appendCasenumber(new_data.filenames.at(attach_file_ind), new_data.casenumber);
    QString values  = "'" + QFileInfo(filepath).fileName() + "'";
    values += ", '" + QString::number(new_data.senderId) + "'";
    values += ", '" + new_data.toUser.at(ID_INDEX).toString() + "'";
    QString cc = "";
    values += ", '" + cc + "'";

    db->insert(HHM_TABLE_DOCUMENT_FILES, columns, values);

    int file_id = getMaxId(HHM_DOCUMENT_FILES_ID, HHM_TABLE_DOCUMENT_FILES);
    if( file_id==-1 )
    {
        hhm_log("Table " + QString(HHM_TABLE_DOCUMENT_FILES) + " is empty");
        file_id = 0;
    }
    new_data.fileIds.append(QString::number(file_id));
}

/***************** Utility Functions *****************/
/*
 * Return last id for
 * 'fieldId' in 'table'
 * if not found return -1
 * */
int HhmDocument::getMaxId(QString fieldId, QString table)
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

//Return Invalid Qvariant if not found key
QVariant HhmDocument::getConfig(QString key)
{
    QString condition = "`" + QString(HHM_CONFIG_KEY) + "`='" + key + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_CONFIG, condition);
    if(res.next())
    {
        QVariant data = res.value(HHM_CONFIG_VALUE);
        return data;
    }
    return QVariant();
}
