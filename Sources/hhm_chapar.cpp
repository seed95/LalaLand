#include "hhm_chapar.h"

HhmChapar::HhmChapar(QObject *item, QObject *parent) : QObject(parent)
{
    ui = item;

    connect(ui, SIGNAL(newButtonClicked()), this, SLOT(newBtnClicked()));
    connect(ui, SIGNAL(replyButtonClicked()), this, SLOT(replyBtnClicked()));
    connect(ui, SIGNAL(forwardButtonClicked()), this, SLOT(forwardBtnClicked()));
    connect(ui, SIGNAL(deleteButtonClicked()), this, SLOT(deleteBtnClicked()));
    connect(ui, SIGNAL(archiveButtonClicked()), this, SLOT(archiveBtnClicked()));
    connect(ui, SIGNAL(scanButtonClicked()), this, SLOT(scanBtnClicked()));
    connect(ui, SIGNAL(sendButtonClicked(int, QString)), this, SLOT(sendBtnClicked(int, QString)));
    connect(ui, SIGNAL(syncButtonClicked()), this, SLOT(syncBtnClicked()));
    connect(ui, SIGNAL(flagButtonClicked(int)), this, SLOT(flagBtnClicked(int)));
    connect(ui, SIGNAL(uploadFileClicked()), this, SLOT(uploadFileClicked()));

    //Instance Database
    db = new HhmDatabase();

    //Instance User
    user = new HhmUser(this, db);
    user->loadUser(USER_NAME);

    //Instance Mail
    mail = new HhmMail(ui, db);
    mail->loadEmails(user->getUsername());
}

void HhmChapar::newBtnClicked()
{
#ifdef HHM_USER_ADMIN
    QString r_new_email_username = "User";
#else
    QString r_new_email_username = "Admin";
#endif
    QQmlProperty::write(ui, "s_new_email_username", user->getUsername());
    QQmlProperty::write(ui, "r_new_email_username", r_new_email_username);
}

void HhmChapar::replyBtnClicked()
{
    qDebug() << "replyBtnClicked";
//    db->update(2, "`lolo`='12daf'", "users");
}

void HhmChapar::forwardBtnClicked()
{
    qDebug() << "forwardBtnClicked";
}

void HhmChapar::deleteBtnClicked()
{
    qDebug() << "deleteBtnClicked";
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
    if(!upload_file.isEmpty())
    {
        int id_admin = db->getId("Admin");
        int id_user = user->getId();

        //Insert into HHM_TABLE_DOCUMENTS
        QString columns = "`" + QString(HHM_DOCUMENTS_FILEPATH) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_SENDER_ID) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_RECEIVER_IDS) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_DATE) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_SENDER_NAME) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_DOCID) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_SUBJECT) + "`";

        QLocale locale(QLocale::English);
        QString date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");

        QString values = "'" + upload_file + "', ";
        values += "'" + QString::number(id_user) + "', ";
        values += "'" + QString::number(id_admin) + "', ";
        values += "'" + date + "', ";
        values += "'" + user->getName() + "', ";
        values += "'" + QString::number(caseNumber) + "', ";
        values += "'" + subject + "'";
        db->insert(HHM_TABLE_DOCUMENTS, columns, values);

        //Get id document
        QString query = "SELECT LAST_INSERT_ID();";
        QSqlQuery res = db->sendQuery(query);
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
        db->insert(HHM_TABLE_EMAILS, columns, values);

        values  = "'" + QString::number(doc_id) + "', ";
        values += "'" + QString::number(0) + "', ";
        values += "'" + QString::number(1) + "'";
        db->insert(HHM_TABLE_EMAILS, columns, values);


        //Get id emails
        query = "SELECT MAX(" + QString(HHM_EMAILS_ID) + ") FROM `";
        query += QString(DATABASE_NAME) + "`.`" + QString(HHM_TABLE_EMAILS) + "`";
        res = db->sendQuery(query);
        int email_id_sent = 0;
        int email_id_received = email_id_sent + 1;
        if(res.next())
        {
            email_id_sent = res.value(0).toInt();
            email_id_received = email_id_sent + 1;
        }

        //update sent emails for sender
        QString fields = QString(HHM_UE_SENT_EMAILS);
        QString condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(id_user);
        res = db->select(fields, HHM_TABLE_USER_EMAILS, condition);
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
            db->update(condition, value, HHM_TABLE_USER_EMAILS);
        }

        //update received emails for receiver
        fields = QString(HHM_UE_RECEIVED_EMAILS);
        condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(id_admin);
        res = db->select(fields, HHM_TABLE_USER_EMAILS, condition);
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
            condition = "`" + QString(HHM_UE_USER_ID) + "`=" + QString::number(id_admin);
            QString value = "`" + QString(HHM_UE_RECEIVED_EMAILS) + "`=\"" + received_emails + "\"";
            db->update(condition, value, HHM_TABLE_USER_EMAILS);
        }
        else
        {
            qDebug() << "no user return";
        }
        mail->loadEmails(user->getUsername());
    }
    else
    {
        qDebug() << "document is empty";
    }
}

void HhmChapar::syncBtnClicked()
{
    mail->loadEmails(user->getUsername());
    QMetaObject::invokeMethod(ui, "finishSync");
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
        upload_file = file_path;
        QQmlProperty::write(ui, "selected_file_path", QFileInfo(upload_file).fileName());
        QMetaObject::invokeMethod(ui, "showSelectedFilePath");
    }
}
