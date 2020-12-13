#include "hhm_chapar.h"
#include <QDebug>

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

    db = new HhmDatabase();
    mail = new HhmMail(item, db);
}


void HhmChapar::newBtnClicked()
{
    qDebug() << "newBtnClicked";
    db->sendQuery("s");
}

void HhmChapar::replyBtnClicked()
{
    qDebug() << "replyBtnClicked";
    db->update(2, "`lolo`='12daf'", "users");
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
    qDebug() << "sendBtnClicked";
    mail->loadReceivedEmails(1);
}

void HhmChapar::syncBtnClicked()
{
    qDebug() << "syncBtnClicked";
}

void HhmChapar::flagBtnClicked(int id)
{
    qDebug() << "flagBtnClicked";
}
