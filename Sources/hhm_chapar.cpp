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
    connect(ui, SIGNAL(sendButtonClicked()), this, SLOT(sendBtnClicked()));
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
    QQmlProperty::write(ui, "s_new_email_username", user->getUsername());
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

void HhmChapar::sendBtnClicked()
{
    if(!upload_file.isEmpty())
    {
        QString columns = "`" + QString(HHM_DOCUMENTS_FILEPATH) + "`, `" + QString(HHM_DOCUMENTS_SENDER_ID) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_RECEIVER_IDS) + "`, `" + QString(HHM_DOCUMENTS_DATE) + "`, ";
        columns += "`" + QString(HHM_DOCUMENTS_SENDER_NAME) + "`";
        QLocale locale(QLocale::English);
        QString date = locale.toString(QDateTime::currentDateTime(), "yyyy-MM-dd hh:mm:ss");
        QString values = "'" + upload_file + "', '" + QString::number(user->getId()) + "', '";
        values += QString::number(db->getId("Admin")) + "', '";
        values += date + "', '" + user->getName() + "'";
        db->insert(HHM_TABLE_DOCUMENTS, columns, values);
    }
    else
    {
        qDebug() << "document is empty";
    }
}

void HhmChapar::syncBtnClicked()
{
    qDebug() << "syncBtnClicked";
}

void HhmChapar::flagBtnClicked(int id)
{
    qDebug() << "flagBtnClicked";
}

void HhmChapar::uploadFileClicked()
{
    upload_file = QFileDialog::getOpenFileName( NULL,
                                                "Choose Document File",
                                                QDir::currentPath(),
                                                "*");
}
