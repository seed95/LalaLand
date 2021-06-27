#include "hhm_document.h"

HhmDocument::HhmDocument(QObject *root, HhmDatabase *database, HhmUser *userLoggedIn,
                         QObject *parent) : QObject(parent)
{
    db = database;
    m_user = userLoggedIn;
    mail = new HhmMail(root, db);

    main_ui     = root->findChild<QObject*>("Document");
    action_ui   = main_ui->findChild<QObject*>("DocumentAction");
    new_ui      = main_ui->findChild<QObject*>("DocumentNew");
    show_ui     = main_ui->findChild<QObject*>("DocumentShow");

    setDocumentBaseId();

    connect(action_ui, SIGNAL(newDocumentClicked()), this, SLOT(newDocumentClicked()));

    connect(new_ui, SIGNAL(checkUsername(QString)), this, SLOT(checkUsername(QString)));
    connect(new_ui, SIGNAL(uploadFileClicked()), this, SLOT(uploadFileClicked()));
    connect(new_ui, SIGNAL(sendNewDocument(int, int, QString, QString, QString)),
            this, SLOT(sendNewDocument(int, int, QString, QString, QString)));

    ftp = new HhmFtp();
    connect(ftp, SIGNAL(uploadSuccess(QString)), this, SLOT(uploadSuccess(QString)));
    connect(ftp, SIGNAL(uploadFailed(QString)), this, SLOT(uploadFailed(QString)));
    connect(ftp, SIGNAL(downloadSuccess(QString)), this, SLOT(downloadSuccess(QString)));
    connect(ftp, SIGNAL(downloadFailed(QString)), this, SLOT(downloadFailed(QString)));
}

HhmDocument::~HhmDocument()
{
    if( ftp!=nullptr )
    {
        delete ftp;
    }
}


/***************** Ftp Slots *****************/
void HhmDocument::uploadSuccess(QString filename)
{
    ///FIXME: complete this segment
    hhm_log("Upload Success " + filename);
}

void HhmDocument::uploadFailed(QString filename)
{
    ///FIXME: complete this segment
    hhm_log("Upload Failed " + filename);
}

void HhmDocument::downloadSuccess(QString filename)
{
    qDebug() << filename;
}

void HhmDocument::downloadFailed(QString filename)
{
    qDebug() << filename;
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
        QQmlProperty::write(new_ui, "selected_file_path", file_path);
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
    }
    else
    {
        QMetaObject::invokeMethod(new_ui, "usernameNotFound");
    }
}

void HhmDocument::sendNewDocument(int caseNumber, int receiverId,
                                  QString subject, QString filepath,
                                  QString tableContent)
{
    if( filepath.isEmpty() )
    {
        hhm_showMessage(tr("Please choose a document"), 2000);
        return;
    }

    if( receiverId==-1 )
    {
        hhm_showMessage(tr("Entered username is not valid"), 5000);
        return;
    }

    if( subject.isEmpty() )
    {
        hhm_showMessage(tr("Please write a subject"), 2000);
        return;
    }

    int id_user = m_user->getId();

    new_data.casenumber     = caseNumber;
    new_data.senderId       = m_user->getId();
    new_data.receiverId     = receiverId;
    new_data.senderName     = m_user->getName();
    new_data.subject        = subject;
    new_data.filepath       = filepath;
    new_data.tableContent   = tableContent;

    QLocale locale(QLocale::English);
    new_data.date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");

    updateDocument();

    QString s_casenumber = QString::number(caseNumber);//string case number
    QString dst_filename = s_casenumber + "_" + QFileInfo(filepath).fileName();
//    mail->sendNewEmail(s_casenumber, subject,
//                       id_user, receiverId,
//                       dst_filename, m_user->getName(),
//                       tableContent);

    //Upload file in fpt server
    hhm_log("Start upload file: " + filepath + " --> " + dst_filename);
    ftp->uploadFile(filepath, dst_filename);

    QMetaObject::invokeMethod(main_ui, "successfullySend");
}

/***************** Main Slots *****************/

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

void HhmDocument::updateDocument()
{
    QString condition = "`" + QString(HHM_DOCUMENT_CASENUMBER) + "`='" +
                        QString::number(new_data.casenumber) + "'";

    QString values = "`" + QString(HHM_DOCUMENT_FILEPATH) + "`='" +
                     new_data.filepath + "'";
    values += ", `" + QString(HHM_DOCUMENT_SENDER_ID) + "`='" +
              QString::number(new_data.senderId) + "'";
    values += ", `" + QString(HHM_DOCUMENT_RECEIVER_IDS) + "`='" +
              QString::number(new_data.receiverId) + "'";
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
