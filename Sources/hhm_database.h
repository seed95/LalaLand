#ifndef HHM_DATABASE_H
#define HHM_DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlResult>
#include <QSqlError>
#include <QSqlRecord>
#include "hhm_config.h"
#include "backend.h"

class HhmDatabase : public QObject
{
    Q_OBJECT
public:
    explicit HhmDatabase(QObject *parent = nullptr);

    QSqlQuery sendQuery(QString query);
    void update(int id, QString value, QString table);
    void insert(QString table, QString columns, QString values);
    QSqlQuery select(QString fields, QString table);
    QSqlQuery select(QString fields, QString table, QString condition);

    int getId(QString username);

    void printQuery(QSqlQuery res);

private:
    QString printQVariant(QVariant v);

signals:

public slots:

private:
    QSqlDatabase db;
};

#endif // HHM_DATABASE_H
