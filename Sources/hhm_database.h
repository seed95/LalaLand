#ifndef HHM_DATABASE_H
#define HHM_DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlResult>
#include <QSqlError>
#include <QSqlRecord>
#include <QDebug>

#include "hhm_config.h"
#include "backend.h"

class HhmDatabase : public QObject
{
    Q_OBJECT
public:
    explicit HhmDatabase(QObject *parent = nullptr);

    QSqlQuery sendQuery(QString query);
    void update(QString condition, QString value, QString table);
    void insert(QString table, QString columns, QString values);
    QSqlQuery select(QString fields, QString table);
    QSqlQuery selectOrder(QString fields, QString table, QString order_column);
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
