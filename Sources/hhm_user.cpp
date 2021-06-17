#include "hhm_user.h"

HhmUser::HhmUser(QObject *item, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    ui = item;
    db = database;
}

bool HhmUser::loadUser(QString username, QString password)
{
    QString condition = "`" + QString(HHM_USER_PASSWORD) + "`=BINARY\"" + password + "\"";//Add BINARY for case sensitive comparisons
    condition += " AND `" + QString(HHM_USER_USERNAME) + "`=\"" + username + "\"";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    if( !res.next() )
    {
        hhm_showMessage(tr("Username or Password is wrong"), 3000);
        return false;
    }

    QVariant data = res.value(HHM_USER_ID);
    if(data.isValid())
    {
        QQmlProperty::write(ui, "idUser", data);
    }
    else
    {
        hhm_log("id is not valid");
    }

    data = res.value(HHM_USER_FIRSTNAME);
    if(data.isValid())
    {
        QQmlProperty::write(ui, "firstname", data);
    }
    else
    {
        hhm_log("First name is not valid");
    }

    data = res.value(HHM_USER_LASTNAME);
    if(data.isValid())
    {
        QQmlProperty::write(ui, "lastname", data);
    }
    else
    {
        hhm_log("Last name is not valid");
    }

    data = res.value(HHM_USER_USERNAME);
    if(data.isValid())
    {
        QQmlProperty::write(ui, "username", data);
    }
    else
    {
        hhm_log("Username is not valid");
    }

    data = res.value(HHM_USER_LASTLOGIN);
    if(data.isValid())
    {
        QLocale ar_locale(QLocale::Arabic);
        QQmlProperty::write(ui, "lastlogin", ar_locale.toString(data.toDateTime(), "hh:mm (dd MMMM/ yyyyy"));
    }
    else
    {
        hhm_log("Last login time is not valid");
    }

    data = res.value(HHM_USER_STATUS);
    if(data.isValid())
    {
        QQmlProperty::write(ui, "status", data);
    }
    else
    {
        hhm_log("Status is not valid");
    }

    data = res.value(HHM_USER_BIO);
    if(data.isValid())
    {
        QQmlProperty::write(ui, "bio", data);
    }
    else
    {
        hhm_log("bio is not valid");
    }

    data = res.value(HHM_USER_IMAGE);
    if(data.isValid())
    {
        QQmlProperty::write(ui, "image", data);
    }
    else
    {
        hhm_log("image is not valid");
    }

    //Check HHM_TABLE_USER_EMAIL for this id
    condition = "`" + QString(HHM_UE_USER_ID) + "`='" + QString::number(getId()) + "'";
    res = db->select("*", HHM_TABLE_USER_EMAIL, condition);
    if( !res.next() )//User not exist in table HHM_TABLE_USER_EMAIL
    {
        hhm_log("Add user with id " + QString::number(getId()) + " in table " + HHM_TABLE_USER_EMAIL);
        QString columns  = "`" + QString(HHM_UE_USER_ID) + "`";
        QString values  = "'" + QString::number(getId()) + "'";
        db->insert(HHM_TABLE_USER_EMAIL, columns, values);
    }

    printUser();
    return true;
}

int HhmUser::getId()
{
    QVariant data = QQmlProperty::read(ui, "idUser");
    return data.toInt();
}

QString HhmUser::getFirstname()
{
    QVariant data = QQmlProperty::read(ui, "firstname");
    return data.toString();
}

QString HhmUser::getLastname()
{
    QVariant data = QQmlProperty::read(ui, "lastname");
    return data.toString();
}

QString HhmUser::getUsername()
{
    QVariant data = QQmlProperty::read(ui, "username");
    return data.toString();
}

QDateTime HhmUser::getLastLogin()
{
    QVariant data = QQmlProperty::read(ui, "lastlogin");
    return data.toDateTime();
}

int HhmUser::getStatus()
{
    QVariant data = QQmlProperty::read(ui, "status");
    return data.toInt();
}

QString HhmUser::getBio()
{
    QVariant data = QQmlProperty::read(ui, "bio");
    return data.toString();
}

QString HhmUser::getImage()
{
    QVariant data = QQmlProperty::read(ui, "image");
    return data.toString();
}

void HhmUser::printUser()
{
    int space = 12;
    QString result = QString("%1").arg("Id", space , QLatin1Char(' '));
    result += QString("%1").arg("Username", space , QLatin1Char(' '));
    result += QString("%1").arg("FirstName", space , QLatin1Char(' '));
    result += QString("%1").arg("LastName", space , QLatin1Char(' '));
    result += QString("%1").arg("LastLogin", space , QLatin1Char(' '));
    result += QString("%1").arg("Status", space , QLatin1Char(' '));
    result += QString("%1").arg("Bio", space , QLatin1Char(' '));
    result += QString("%1").arg("Image", space , QLatin1Char(' '));
    qDebug() << result;

    QVariant data = QQmlProperty::read(ui, "idUser");
    result = QString("%1").arg(QString::number(data.toInt()), space, QLatin1Char(' '));

    data = QQmlProperty::read(ui, "username");
    result += QString("%1").arg(data.toString(), space, QLatin1Char(' '));

    data = QQmlProperty::read(ui, "firstname");
    result += QString("%1").arg(data.toString(), space, QLatin1Char(' '));

    data = QQmlProperty::read(ui, "lastname");
    result += QString("%1").arg(data.toString(), space, QLatin1Char(' '));

    data = QQmlProperty::read(ui, "lastlogin");
    result += QString("%1").arg(data.toString(), space, QLatin1Char(' '));

    data = QQmlProperty::read(ui, "status");
    result += QString("%1").arg(QString::number(data.toInt()), space, QLatin1Char(' '));

    data = QQmlProperty::read(ui, "bio");
    result += QString("%1").arg(data.toString(), space, QLatin1Char(' '));

    data = QQmlProperty::read(ui, "image");
    result += QString("%1").arg(data.toString(), space, QLatin1Char(' '));

    qDebug() << result;
}
