#include "hhm_chapar.h"

HhmChapar::HhmChapar(QObject *item, QObject *parent) : QObject(parent)
{
    ui = item;

    connect(ui, SIGNAL(loginUser(QString, QString)), this, SLOT(loginUser(QString, QString)));
    connect(ui, SIGNAL(newButtonClicked()), this, SLOT(newBtnClicked()));
    connect(ui, SIGNAL(replyButtonClicked()), this, SLOT(replyBtnClicked()));
    connect(ui, SIGNAL(approveButtonClicked(int)), this, SLOT(approveBtnClicked(int)));
    connect(ui, SIGNAL(rejectButtonClicked(int)), this, SLOT(rejectBtnClicked(int)));
    connect(ui, SIGNAL(archiveButtonClicked()), this, SLOT(archiveBtnClicked()));
    connect(ui, SIGNAL(scanButtonClicked()), this, SLOT(scanBtnClicked()));
    connect(ui, SIGNAL(sendButtonClicked(int, QString)), this, SLOT(sendBtnClicked(int, QString)));
    connect(ui, SIGNAL(flagButtonClicked(int)), this, SLOT(flagBtnClicked(int)));
    connect(ui, SIGNAL(uploadFileClicked()), this, SLOT(uploadFileClicked()));
    connect(ui, SIGNAL(downloadFileClicked(QString)), this, SLOT(downloadFileClicked(QString)));
    connect(ui, SIGNAL(syncInbox()), this, SLOT(syncInbox()));
    connect(ui, SIGNAL(syncOutbox()), this, SLOT(syncOutbox()));
    connect(ui, SIGNAL(openEmail(int)), this, SLOT(openEmail(int)));

    //Instance Database
    db = new HhmDatabase();

    //Instance User
    user = new HhmUser(ui, db);

    //Instance Mail
    mail = new HhmMail(ui, db);

    ftp = new HhmAttach();

    qDebug() << hhm_getServerIP();
}

void HhmChapar::loginUser(QString uname, QString pass)
{
    if(user->loadUser(uname, pass))
    {
        QMetaObject::invokeMethod(ui, "loginSuccessfuly");
        mail->loadInboxEmails(user->getId());
    }
}

void HhmChapar::newBtnClicked()
{
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

void HhmChapar::sendBtnClicked(int caseNumber, QString subject)
{
    if(!upload_filepath.isEmpty())
    {
        int id_user = user->getId();

        int id_receiver_user = db->getId(HHM_USERNAME_ADMIN);
        if(user->getUsername()==HHM_USERNAME_ADMIN)
        {
            id_receiver_user = db->getId(HHM_USERNAME_USER);
        }

        //Check duplicate case number
        QString condition = "`" + QString(HHM_DOCUMENTS_DOCID) + "`=" + QString::number(caseNumber);
        QSqlQuery res = db->select("*", HHM_TABLE_DOCUMENT, condition);
        if( res.size()!=0 )
        {
            hhm_showMessage("Case number already exist!", 2000);
            return;
        }

        //Insert into HHM_TABLE_DOCUMENT
        QString columns = "`" + QString(HHM_DOCUMENTS_FILEPATH) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_SENDER_ID) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_RECEIVER_IDS) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_DATE) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_SENDER_NAME) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_DOCID) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_SUBJECT) + "`";

        QLocale locale(QLocale::English);
        QString date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");

        QFileInfo file_info(upload_filepath);
        QString dst_filename = QString::number(caseNumber) + "_" + file_info.fileName();
        QString values = "'" + dst_filename + "', ";
        values += "'" + QString::number(id_user) + "', ";
        values += "'" + QString::number(id_receiver_user) + "', ";
        values += "'" + date + "', ";
        values += "'" + user->getName() + "', ";
        values += "'" + QString::number(caseNumber) + "', ";
        values += "'" + subject + "'";
        db->insert(HHM_TABLE_DOCUMENT, columns, values);

        //Get id document
        QString query = "SELECT LAST_INSERT_ID();";
        res = db->sendQuery(query);
        int doc_id = 0;
        if(res.next())
        {
            doc_id = res.value(0).toInt();
        }

        columns  = "`" + QString(HHM_EMAILS_DOCID) + "`, ";
        columns += "`" + QString(HHM_EMAILS_SEND_REFERENCE) + "`, ";
        columns += "`" + QString(HHM_EMAILS_RECEIVE_REFERENCE) + "`";

        values  = "'" + QString::number(doc_id) + "', ";
        values += "'" + QString::number(1) + "', ";
        values += "'" + QString::number(0) + "'";
        db->insert(HHM_TABLE_EMAIL, columns, values);

        values  = "'" + QString::number(doc_id) + "', ";
        values += "'" + QString::number(0) + "', ";
        values += "'" + QString::number(1) + "'";
        db->insert(HHM_TABLE_EMAIL, columns, values);

        //Upload file in fpt server
        ftp->uploadFile(upload_filepath, dst_filename);

        //Get id emails
        query = "SELECT MAX(" + QString(HHM_EMAILS_ID) + ") FROM `";
        query += QString(DATABASE_NAME) + "`.`" + QString(HHM_TABLE_EMAIL) + "`";
        res = db->sendQuery(query);
        int email_id_sent = 1;
        int email_id_received = email_id_sent + 1;
        if(res.next())
        {
            email_id_received = res.value(0).toInt();
            email_id_sent = email_id_received - 1;
        }

        //update sent emails for sender
        QString fields = QString(HHM_UE_SENT_EMAILS);
        condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(id_user);
        res = db->select(fields, HHM_TABLE_USER_EMAIL, condition);
        if(res.next())
        {
            QString sent_emails = res.value(0).toString();
            if(sent_emails.isEmpty())
            {
                sent_emails = QString::number(email_id_sent);
            }
            else
            {
                sent_emails += "," + QString::number(email_id_sent);
            }
            condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(id_user);
            QString value = "`" + QString(HHM_UE_SENT_EMAILS) + "`=\"" + sent_emails + "\"";
            db->update(condition, value, HHM_TABLE_USER_EMAIL);
        }

        //update received emails for receiver
        fields = QString(HHM_UE_RECEIVED_EMAILS);
        condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(id_receiver_user);
        res = db->select(fields, HHM_TABLE_USER_EMAIL, condition);
        if(res.next())
        {
            QString received_emails = res.value(0).toString();
            if(received_emails.isEmpty())
            {
                received_emails = QString::number(email_id_received);
            }
            else
            {
                received_emails += "," + QString::number(email_id_received);
            }
            condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(id_receiver_user);
            QString value = "`" + QString(HHM_UE_RECEIVED_EMAILS) + "`=\"" + received_emails + "\"";
            db->update(condition, value, HHM_TABLE_USER_EMAIL);
        }
        else
        {
            qDebug() << "no user return";
        }
        QMetaObject::invokeMethod(ui, "sendEmailComplete");
    }
    else
    {
        qDebug() << "document is empty";
    }
}

void HhmChapar::flagBtnClicked(int id)
{
    qDebug() << "flagBtnClicked";
}

void HhmChapar::uploadFileClicked()
{
    QString file_path = QFileDialog::getOpenFileName( NULL,
                                                     "Choose Document File",
                                                     QDir::currentPath(),
                                                     "*");
    if(!file_path.isEmpty())
    {
        upload_filepath = file_path;
        QQmlProperty::write(ui, "selected_file_path", QFileInfo(upload_filepath).fileName());
        QMetaObject::invokeMethod(ui, "showSelectedFilePath");
    }
}

void HhmChapar::downloadFileClicked(QString src)
{
    QString dst = QFileDialog::getExistingDirectory(NULL,
                                      "Choose folder for save file",
                                      QDir::currentPath());
    if(!dst.isEmpty())
    {
        QString src_filename = QFileInfo(src).fileName();
        if( src_filename.split("_").length()>0 )
        {
            dst += "/" + src_filename.split("_")[1];
            ftp->downloadFile(src, dst);
        }
        else
        {
            qDebug() << "source filename dont contain casenumber";
        }
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
    QString condition = "`" + QString(HHM_EMAILS_ID) + "`=" + QString::number(idEmail);
    QString value = "`" + QString(HHM_EMAILS_OPENED) + "`=" + QString::number(1);
    db->update(condition, value, HHM_TABLE_EMAIL);
}
