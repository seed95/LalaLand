#include "hhm_chapar.h"

HhmChapar::HhmChapar(QObject *item, QObject *parent) : QObject(parent)
{
    ui = item;
    last_directory = QDir::currentPath();

    connect(ui, SIGNAL(loginUser(QString, QString)), this, SLOT(loginUser(QString, QString)));
    connect(ui, SIGNAL(newButtonClicked()), this, SLOT(newBtnClicked()));
    connect(ui, SIGNAL(replyButtonClicked()), this, SLOT(replyBtnClicked()));
    connect(ui, SIGNAL(approveButtonClicked(int)), this, SLOT(approveBtnClicked(int)));
    connect(ui, SIGNAL(rejectButtonClicked(int)), this, SLOT(rejectBtnClicked(int)));
    connect(ui, SIGNAL(archiveButtonClicked()), this, SLOT(archiveBtnClicked()));
    connect(ui, SIGNAL(scanButtonClicked()), this, SLOT(scanBtnClicked()));
    connect(ui, SIGNAL(sendButtonClicked(int, int, QString, QString)), this, SLOT(sendBtnClicked(int, int, QString, QString)));
    connect(ui, SIGNAL(flagButtonClicked(int)), this, SLOT(flagBtnClicked(int)));
    connect(ui, SIGNAL(uploadFileClicked()), this, SLOT(uploadFileClicked()));
    connect(ui, SIGNAL(downloadFileClicked(QString, int)), this, SLOT(downloadFileClicked(QString, int)));
    connect(ui, SIGNAL(syncInbox()), this, SLOT(syncInbox()));
    connect(ui, SIGNAL(syncOutbox()), this, SLOT(syncOutbox()));
    connect(ui, SIGNAL(openEmail(int)), this, SLOT(openEmail(int)));
    connect(ui, SIGNAL(checkUsername(QString)), this, SLOT(checkUsername(QString)));

    //Instance Database
    db = new HhmDatabase();

    //Instance User
    user = new HhmUser(ui, db);

    //Instance Mail
    mail = new HhmMail(ui, db);

    //Instance Attach
    QString ftp_server = "";
    QVariant data = getConfig(HHM_CONFIG_FTP_SERVER);
    if(data.isValid())
    {
        ftp_server = data.toString();
    }
    else
    {
        hhm_log("FTP server is wrong in config table(" + data.toString() + ")");
    }

    QString ftp_username = "";
    data = getConfig(HHM_CONFIG_FTP_USERNAME);
    if(data.isValid())
    {
        ftp_username = data.toString();
    }
    else
    {
        hhm_log("FTP username is wrong in config table(" + data.toString() + ")");
    }

    QString ftp_password = "";
    data = getConfig(HHM_CONFIG_FTP_PASSWORD);
    if( data.isValid() )
    {
        ftp_password = data.toString();
    }
    else
    {
        hhm_log("FTP password is wrong in config table(" + data.toString() + ")");
    }

    ftp = new HhmAttach(ftp_server, ftp_username, ftp_password);

    QString domain = "";
    data = getConfig(HHM_CONFIG_DOMAIN);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "domain", data.toString());
    }
    else
    {
        hhm_log("Not set domain in config table");
    }

}

void HhmChapar::loginUser(QString uname, QString pass)
{
    if( user->loadUser(uname, pass) )
    {
        QMetaObject::invokeMethod(ui, "loginSuccessfuly");
        mail->loadInboxEmails(user->getId());
    }
}

void HhmChapar::newBtnClicked()
{
    db->insert(HHM_TABLE_DOCUMENT, "", "");
    //Get new case number
    QString query = "SELECT MAX(" + QString(HHM_DOCUMENT_CASENUMBER) + ") FROM ";
    query += "`" + QString(DATABASE_NAME) + "`.`" + QString(HHM_TABLE_DOCUMENT) + "`";
    QSqlQuery res = db->sendQuery(query);
    //first sent email id is 1, so first received email id is 2
    if( res.next() )
    {
        QQmlProperty::write(ui, "new_case_number", res.value(0).toInt());
    }
    else
    {
        hhm_log("Error in geting new case number from database");
    }
}

void HhmChapar::replyBtnClicked()
{
    qDebug() << "replyBtnClicked";
}

void HhmChapar::approveBtnClicked(int caseNumber)
{
    mail->approveDoc(caseNumber);
}

void HhmChapar::rejectBtnClicked(int caseNumber)
{
    mail->rejectDoc(caseNumber);
}

void HhmChapar::archiveBtnClicked()
{
    qDebug() << "archiveBtnClicked";
}

void HhmChapar::scanBtnClicked()
{
    qDebug() << "scanBtnClicked";
}

void HhmChapar::sendBtnClicked(int receiverId, int caseNumber, QString subject, QString filepath)
{
    if( filepath.isEmpty() )
    {
        hhm_showMessage("Please choose a document", 2000);
        return;
    }

    if( receiverId==0 )
    {
        hhm_showMessage(tr("Entered username is not valid"), 5000);
        return;
    }

    if( subject=="" )
    {
        hhm_showMessage("Please write a subject", 2000);
        return;
    }

    int id_user = user->getId();

    QString s_case_number = QString::number(caseNumber);//string case number
    QString dst_filename = s_case_number + "_" + QFileInfo(filepath).fileName();
    mail->sendNewEmail(s_case_number, subject,
                       id_user, receiverId,
                       dst_filename, user->getName());

    //Upload file in fpt server
    ftp->uploadFile(filepath, dst_filename);

    QMetaObject::invokeMethod(ui, "sendEmailComplete");

}

void HhmChapar::flagBtnClicked(int id)
{
    qDebug() << "flagBtnClicked";
}

void HhmChapar::uploadFileClicked()
{
    QString file_path = QFileDialog::getOpenFileName( NULL,
                                                     "Choose Document File",
                                                     last_directory,
                                                     "*");
    if(!file_path.isEmpty())
    {
        last_directory = QFileInfo(file_path).absolutePath();
        QQmlProperty::write(ui, "selected_file_path", file_path);
        QMetaObject::invokeMethod(ui, "showSelectedFilePath");
    }
}

void HhmChapar::downloadFileClicked(QString src, int caseNumber)
{
    QFileDialog dialog(NULL,
                       "Choose folder for save file",
                       last_directory);
    dialog.setAcceptMode(QFileDialog::AcceptSave);
    dialog.setFileMode(QFileDialog::AnyFile);
    QString src_filename = QFileInfo(src).fileName().replace(QString::number(caseNumber) + "_", "");
    dialog.selectFile(src_filename);

    int ret = dialog.exec();
    if( ret==QDialog::Accepted )
    {
        last_directory = QFileInfo(dialog.selectedFiles().first()).absolutePath();
        QString dst = dialog.selectedFiles().first();
        hhm_log("Start download: " + src_filename + " --> " + dst);
        ftp->downloadFile(src, dst);
    }
}

void HhmChapar::syncInbox()
{
    mail->loadInboxEmails(user->getId());
    QMetaObject::invokeMethod(ui, "finishSync");
}

void HhmChapar::syncOutbox()
{
    mail->loadOutboxEmails(user->getId());
    QMetaObject::invokeMethod(ui, "finishSync");
}

void HhmChapar::openEmail(int idEmail)
{
    //Change State `opened` Email
    QString condition = "`" + QString(HHM_EMAIL_ID) + "`=" + QString::number(idEmail);
    QString value = "`" + QString(HHM_EMAIL_OPENED) + "`=" + QString::number(1);
    db->update(condition, value, HHM_TABLE_EMAIL);
}

void HhmChapar::checkUsername(QString username)
{
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    if( res.next() )
    {
        QVariant data = res.value(HHM_USER_ID);
        if( data.isValid() )
        {
            QQmlProperty::write(ui, "receiver_id", data.toInt());
        }
        else
        {
            hhm_log("Receiver id is not valid for username " + username + " (" + data.toString() + ")");
        }
    }
    else
    {
        hhm_showMessage(tr("Entered username is not valid"), 5000);
    }
}

//Return Invalid Qvariant if not found key
QVariant HhmChapar::getConfig(QString key)
{
    QString condition = "`" + QString(HHM_CONFIG_KEY) + "`=\"" + key + "\"";
    QSqlQuery res = db->select("*", HHM_TABLE_CONFIG, condition);
    if(res.next())
    {
        QVariant data = res.value(HHM_CONFIG_VALUE);
        return data;
    }
    return QVariant();
}
