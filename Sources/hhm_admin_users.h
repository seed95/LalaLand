#ifndef HHMADMINUSERS_H
#define HHMADMINUSERS_H

#include <QObject>
#include <QQmlProperty>

#include "backend.h"
#include "hhm_database.h"
#include "hhm_user.h"
#include "hhm_ftp.h"

class HhmAdminUsers : public QObject
{
    Q_OBJECT
public:
    explicit HhmAdminUsers(QObject *root, HhmDatabase *database,
                        QObject *parent = nullptr);
    ~HhmAdminUsers();

private slots:
    void qmlComplete();

public:
    void readTags();
    void readTagUser(int user_id, int role_id);
    void setUiTag(int user_index, QString tag_name);
    int  getUserIndex(int user_id);

private:
    QObject *departments_ui;
    QObject *roles_ui;
    QObject *users_ui;

    HhmDatabase *db;
    HhmUser     *m_user;
    QTimer      *timer;
};

#endif // HHMADMINUSERS_H
