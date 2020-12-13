#ifndef HHM_CHAPAR_H
#define HHM_CHAPAR_H

#include <QObject>
#include "hhm_mail.h"
#include "hhm_database.h"

class HhmChapar : public QObject
{
    Q_OBJECT
public:
    explicit HhmChapar(QObject *item, QObject *parent = nullptr);

signals:

private slots:
    void newBtnClicked();
    void replyBtnClicked();
    void forwardBtnClicked();
    void deleteBtnClicked();
    void archiveBtnClicked();
    void scanBtnClicked();
    void sendBtnClicked();
    void syncBtnClicked();
    void flagBtnClicked(int id);

private:
    QObject *ui;

    HhmMail *mail;
    HhmDatabase *db;

};

#endif // HHM_CHAPAR_H
