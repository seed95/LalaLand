#include "hhm_chapar.h"

HhmChapar::HhmChapar(QObject *item, QObject *parent) : QObject(parent)
{
    ui = item;
    last_directory = QDir::currentPath();

    connect(ui, SIGNAL(loginUser(QString, QString)), this, SLOT(loginUser(QString, QString)));
    connect(ui, SIGNAL(replyButtonClicked()), this, SLOT(replyBtnClicked()));
    connect(ui, SIGNAL(approveButtonClicked(int, QString, int)),
            this, SLOT(approveBtnClicked(int, QString, int)));
    connect(ui, SIGNAL(rejectButtonClicked(int)), this, SLOT(rejectBtnClicked(int)));
    connect(ui, SIGNAL(archiveButtonClicked()), this, SLOT(archiveBtnClicked()));
    connect(ui, SIGNAL(scanButtonClicked()), this, SLOT(scanBtnClicked()));
    connect(ui, SIGNAL(flagButtonClicked(int)), this, SLOT(flagBtnClicked(int)));
    connect(ui, SIGNAL(downloadFileClicked(QString, int)), this, SLOT(downloadFileClicked(QString, int)));
    connect(ui, SIGNAL(syncInbox()), this, SLOT(syncInbox()));
    connect(ui, SIGNAL(syncOutbox()), this, SLOT(syncOutbox()));
    connect(ui, SIGNAL(openEmail(int)), this, SLOT(openEmail(int)));

    //Instance Database
    db = new HhmDatabase();
    setFtpConfigs();

    //Instance User
    user = new HhmUser(ui, db);

    //Instance Mail
    mail = new HhmMail(ui, db);

    //Instance Message
    message = new HhmMessage(ui, db, user);
    admin = new HhmAdmin(ui, db, user);

    //Instance Document
    document = new HhmDocument(ui, db, user);

    //Instance Ftp
    ftp = new HhmFtp();

    //Instance News
    QVariant data = getConfig(HHM_CONFIG_NEWS_TIMER);
    int interval = HHM_DEFAULT_NEWS_TIMER;
    if( data.isValid() )
    {
        interval = data.toInt();
    }
    news = new HhmNews(ui, db, interval);

    //Set domain
    data = getConfig(HHM_CONFIG_DOMAIN);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "domain", data.toString());
    }
    else
    {
        hhm_log("Not set domain in config table");
    }

    //Set document base id
    data = getConfig(HHM_CONFIG_DOCUMENT_BASE_ID);
    if( data.isValid() )
    {
        doc_base_id = data.toInt();
    }
    else
    {
        hhm_log("Not set " + QString(HHM_CONFIG_DOCUMENT_BASE_ID) + " in " + QString(HHM_TABLE_CONFIG));
    }

}

void HhmChapar::loginUser(QString uname, QString pass)
{
    if( user->loadUser(uname, pass) )
    {
        QMetaObject::invokeMethod(ui, "loginSuccessfuly");
    }
}

void HhmChapar::replyBtnClicked()
{
    qDebug() << "replyBtnClicked";
}

void HhmChapar::approveBtnClicked(int caseNumber, QString tableContent, int emailId)
{
    mail->approveDoc(caseNumber, tableContent, QString::number(emailId));
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

void HhmChapar::flagBtnClicked(int id)
{
    qDebug() << "flagBtnClicked";
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
        hhm_log("Start download file: " + src_filename + " --> " + dst);
        ftp->downloadFile(src, dst);
    }
}

void HhmChapar::syncInbox()
{
    mail->loadInboxEmails(user->getId());
    hhm_updateFromServer();
    QMetaObject::invokeMethod(ui, "finishSync");
}

void HhmChapar::syncOutbox()
{
    mail->loadOutboxEmails(user->getId());
    hhm_updateFromServer();
    QMetaObject::invokeMethod(ui, "finishSync");
}

void HhmChapar::openEmail(int idEmail)
{
    //Change State `opened` Email
    QString condition = "`" + QString(HHM_EMAIL_ID) + "`=" + QString::number(idEmail);
    QString value = "`" + QString(HHM_EMAIL_OPENED) + "`=" + QString::number(1);
    db->update(condition, value, HHM_TABLE_EMAIL);
}

//Return Invalid Qvariant if not found key
QVariant HhmChapar::getConfig(QString key)
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

void HhmChapar::setFtpConfigs()
{
    QVariant data = getConfig(HHM_CONFIG_FTP_SERVER);
    if(data.isValid())
    {
        hhm_setFtpAddress(data.toString());
    }
    else
    {
        hhm_log("FTP server is wrong in config table(" + data.toString() + ")");
    }

    data = getConfig(HHM_CONFIG_FTP_USERNAME);
    if(data.isValid())
    {
        hhm_setFtpUsername(data.toString());
    }
    else
    {
        hhm_log("FTP username is wrong in config table(" + data.toString() + ")");
    }

    data = getConfig(HHM_CONFIG_FTP_PASSWORD);
    if( data.isValid() )
    {
        hhm_setFtpPassword(data.toString());
    }
    else
    {
        hhm_log("FTP password is wrong in config table(" + data.toString() + ")");
    }

}
