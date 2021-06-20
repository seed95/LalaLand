#ifndef HHMMESSAGE_H
#define HHMMESSAGE_H

#include <QObject>
#include <QQmlProperty>
#include <QFileDialog>

#include "backend.h"
#include "hhm_database.h"

class HhmMessage : public QObject
{
    Q_OBJECT
public:
    explicit HhmMessage(QObject *root, HhmDatabase *database, QObject *parent = nullptr);

private slots:
    void attachNewFile();
    void addNewUsernameTo(QString);
    void addNewUsernameCc(QString);

private:
    void addUserTag(QSqlQuery res, QObject *ui);

private:
    QObject *main_ui;
    QObject *new_ui;
    QObject *content_ui;
    QObject *action_ui;
    QObject *new_input_to_ui;
    QObject *new_input_cc_ui;

    HhmDatabase *db;


};

#endif // HHMMESSAGE_H
