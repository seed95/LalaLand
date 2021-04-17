#include "hhm_database.h"

HhmDatabase::HhmDatabase(QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName(hhm_getServerIP());
    db.setPort(SERVER_PORT);
    db.setDatabaseName(DATABASE_NAME);
    db.setUserName(SERVER_USER);
    db.setPassword(SERVER_PASS);

    if( db.open() )
    {
        hhm_setServerStatus("Connected to " + hhm_getServerIP() + ":" + QString::number(SERVER_PORT));
    }
    else
    {
        hhm_setServerStatus("Not connected to " + hhm_getServerIP() + ":" + QString::number(SERVER_PORT));
    }
}

QSqlQuery HhmDatabase::sendQuery(QString query)
{
    QSqlQuery res = db.exec(query);
//    printQuery(res);

    QSqlError err = res.lastError();
    QString s_err; //string error
    if( err.type()==QSqlError::ConnectionError )
    {
        s_err = "Connection is not establish between server ";
        s_err += QString(hhm_getServerIP()) + " " + QString::number(SERVER_PORT);
        hhm_setStatus(s_err);
    }
    else if( err.type()==QSqlError::StatementError )
    {
        s_err = "Query " + query + " contains syntax error";
        hhm_setStatus(s_err);
    }
    else if( err.type()==QSqlError::TransactionError )
    {
        s_err = "Query " + query + " executation time limit has been reached";
        hhm_setStatus(s_err);
    }
    else if( err.type()==QSqlError::UnknownError )
    {
        s_err = "Query " + query + " results in unkown error";
        s_err += " server: " + QString(hhm_getServerIP()) + ":" + QString::number(SERVER_PORT);
        hhm_setStatus(s_err);
    }
    else if( res.size()==0 )
    {
        s_err = "Query retunr null result";
        hhm_setStatus(s_err);
    }

    return res;
}

void HhmDatabase::update(QString condition, QString value, QString table)
{
    QString query = "UPDATE `" + QString(DATABASE_NAME) + "`.`" +  table + "` SET " + value;
    query += " WHERE " + condition + ";";
    QSqlQuery res = db.exec(query);

    QSqlError err = res.lastError();
    QString s_err; //string error
    if( err.type()==QSqlError::ConnectionError )
    {
        s_err = "Connection is not establish between server ";
        s_err += QString(hhm_getServerIP()) + " " + QString::number(SERVER_PORT);
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::StatementError )
    {
        s_err = "Query " + query + " contains syntax error";
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::TransactionError )
    {
        s_err = "Query " + query + " executation time limit has been reached";
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::UnknownError )
    {
        s_err = "Query " + query + " results in unkown error";
        s_err += " server: " + QString(hhm_getServerIP()) + ":" + QString::number(SERVER_PORT);
        hhm_setStatus(s_err);
        return;
    }

}

void HhmDatabase::insert(QString table, QString columns, QString values)
{
    QString query = "INSERT INTO `" + QString(DATABASE_NAME) + "`.`" + table;
    query += "` (" + columns + ") VALUES (" + values + ");";
    QSqlQuery res = db.exec(query);

    QSqlError err = res.lastError();
    QString s_err; //string error
    if( err.type()==QSqlError::ConnectionError )
    {
        s_err = "Connection is not establish between server ";
        s_err += QString(hhm_getServerIP()) + " " + QString::number(SERVER_PORT);
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::StatementError )
    {
        s_err = "Query " + query + " contains syntax error";
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::TransactionError )
    {
        s_err = "Query " + query + " executation time limit has been reached";
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::UnknownError )
    {
        s_err = "Query " + query + " results in unkown error";
        s_err += " server: " + QString(hhm_getServerIP()) + ":" + QString::number(SERVER_PORT);
        hhm_setStatus(s_err);
        return;
    }

}

QSqlQuery HhmDatabase::select(QString fields, QString table)
{
    QString query = "SELECT " + fields + " FROM `" + QString(DATABASE_NAME) + "`.`" + table + "`;";
    return sendQuery(query);
}

QSqlQuery HhmDatabase::select(QString fields, QString table, QString condition)
{
    QString query = "SELECT " + fields + " FROM `" + QString(DATABASE_NAME) + "`.`" + table;
    query += "` WHERE " + condition + ";";
    return sendQuery(query);
}

//return -1 if not found user with this `username`
int HhmDatabase::getId(QString username)
{
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = select(HHM_USER_ID, HHM_TABLE_USER, condition);
    int result = -1;
    if(res.next())
    {
        result = res.value(0).toInt();
    }
    return result;
}

void HhmDatabase::printQuery(QSqlQuery res)
{
    QSqlError err = res.lastError();
    QString s_err; //string error
    if( err.type()==QSqlError::ConnectionError )
    {
        s_err = "Connection is not establish between server ";
        s_err += QString(hhm_getServerIP()) + " " + QString::number(SERVER_PORT);
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::StatementError )
    {
        s_err = "Query " + res.lastQuery() + " contains syntax error";
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::TransactionError )
    {
        s_err = "Query " + res.lastQuery() + " executation time limit has been reached";
        hhm_setStatus(s_err);
        return;
    }
    else if( err.type()==QSqlError::UnknownError )
    {
        s_err = "Query " + res.lastQuery() + " results in unkown error";
        s_err += " server: " + QString(hhm_getServerIP()) + ":" + QString::number(SERVER_PORT);
        hhm_setStatus(s_err);
        return;
    }

    QSqlRecord rec = res.record();
    int count = rec.count();
    QString column_s;

    for( int i=0 ; i<count ; i++ )
    {
        column_s += QString("%1").arg(rec.fieldName(i), 10, QLatin1Char(' '));
    }
    qDebug() << column_s;

    while(res.next())
    {
        column_s = "";
        for( int i=0 ; i<count ; i++ )
        {
            column_s += printQVariant(res.value(i));
        }
        qDebug() << column_s;
    }
}

QString HhmDatabase::printQVariant(QVariant v)
{
    QString buff;
    if( v.type()==QMetaType::Int || v.type()==QMetaType::UInt ||
        v.type()==QMetaType::Long || v.type()==QMetaType::ULong ||
        v.type()==QMetaType::Short || v.type()==QMetaType::UShort ||
        v.type()==QMetaType::LongLong || v.type()==QMetaType::ULongLong )
    {
        buff = QStringLiteral("%1").arg(v.toLongLong(), 10, 10, QLatin1Char(' '));
    }
    else if( v.type()==QMetaType::Double || v.type()==QMetaType::Float )
    {
        buff = QString("%1").arg(QString::number(v.toFloat()), 10, QLatin1Char(' '));
    }
    else if( v.type()==QMetaType::QChar || v.type()==QMetaType::QString ||
             v.type()==QMetaType::Char || v.type()==QMetaType::UChar ||
             v.type()==QMetaType::SChar)
    {
        if(v.toString().size()>0)
        {
            if(v.toString().at(0)==0)
            {
                return "          ";
            }
        }
        buff = QString("%1").arg(v.toString(), 10, QLatin1Char(' '));
    }
    else
    {
        buff = "          ";
    }

    return buff;
}
