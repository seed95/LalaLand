#include "hhm_chapar.h"

HhmChapar::HhmChapar(QObject *item, QObject *parent) : QObject(parent)
{
    ui = item;
    last_directory = QDir::currentPath();

    connect(ui, SIGNAL(loginUser(QString, QString)), this, SLOT(loginUser(QString, QString)));
    connect(ui, SIGNAL(replyButtonClicked()), this, SLOT(replyBtnClicked()));
    connect(ui, SIGNAL(archiveButtonClicked()), this, SLOT(archiveBtnClicked()));
    connect(ui, SIGNAL(scanButtonClicked()), this, SLOT(scanBtnClicked()));
    connect(ui, SIGNAL(flagButtonClicked(int)), this, SLOT(flagBtnClicked(int)));

    //Instance Database
    db = new HhmDatabase();
    setFtpConfigs();

    //Instance User
    user = new HhmUser(ui, db);

    //Instance Message
    message = new HhmMessage(ui, db, user);
//    admin = new HhmAdmin(ui, db, user);

    //Instance Document
    document = new HhmDocument(ui, db, user);

    //Instance Ftp
    ftp = new HhmFtp();

    //Instance News
    QVariant data = getConfig(HHM_CONFIG_NEWS_TIMER);
    int interval = HHM_DEFAULT_NEWS_TIMER;
    if( data.isValid() )
    {
        interval = data.toInt();
    }
    news = new HhmNews(ui, db, interval);

    //Set domain
    data = getConfig(HHM_CONFIG_DOMAIN);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "domain", data.toString());
    }
    else
    {
        hhm_log("Not set domain in config table");
    }
}

void HhmChapar::loginUser(QString uname, QString pass)
{
    if( user->loadUser(uname, pass) )
    {
        QMetaObject::invokeMethod(ui, "loginSuccessfully");
        document->loginSuccessfully();
        message->loginSuccessfully();
    }
}

void HhmChapar::replyBtnClicked()
{
    qDebug() << "replyBtnClicked";
}

void HhmChapar::archiveBtnClicked()
{
    qDebug() << "archiveBtnClicked";
}

void HhmChapar::scanBtnClicked()
{
    qDebug() << "scanBtnClicked";
}

void HhmChapar::flagBtnClicked(int id)
{
    qDebug() << "flagBtnClicked";
}

//Return Invalid Qvariant if not found key
QVariant HhmChapar::getConfig(QString key)
{
    QString condition = "`" + QString(HHM_CONFIG_KEY) + "`='" + key + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_CONFIG, condition);
    if(res.next())
    {
        QVariant data = res.value(HHM_CONFIG_VALUE);
        return data;
    }
    return QVariant();
}

void HhmChapar::setFtpConfigs()
{
    QVariant data = getConfig(HHM_CONFIG_FTP_SERVER);
    if(data.isValid())
    {
        hhm_setFtpAddress(data.toString());
    }
    else
    {
        hhm_log("FTP server is wrong in config table(" + data.toString() + ")");
    }

    data = getConfig(HHM_CONFIG_FTP_USERNAME);
    if(data.isValid())
    {
        hhm_setFtpUsername(data.toString());
    }
    else
    {
        hhm_log("FTP username is wrong in config table(" + data.toString() + ")");
    }

    data = getConfig(HHM_CONFIG_FTP_PASSWORD);
    if( data.isValid() )
    {
        hhm_setFtpPassword(data.toString());
    }
    else
    {
        hhm_log("FTP password is wrong in config table(" + data.toString() + ")");
    }

}
