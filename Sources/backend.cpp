#include "backend.h"

QObject *ui;
QString server_ip;

void hhm_setBackendUI(QObject *item)
{
    ui = item;
}

void hhm_setServerStatus(QString status)
{
    if( ui==NULL )
    {
        hhm_log("UI is null, server status: " + status);
        return;
    }
    QQmlProperty::write(ui, "login_status", status);
    hhm_log("Server Status --> " + status);
}

void hhm_setStatus(QString status)
{
    if( ui==NULL )
    {
        hhm_log("UI is null, status: " + status);
        return;
    }
    QQmlProperty::write(ui, "app_status", status);
    hhm_log("status --> " + status);
}

/*
 * Show message in ui
 * @msg: message to show in qml
 * @interval: duration for show message(ms)
 *
 * */
void hhm_showMessage(QString msg, int interval)
{
    if( ui==NULL )
    {
        hhm_log("UI is null, message: " + msg);
        return;
    }

    QQmlProperty::write(ui, "error_msg", msg);
    QQmlProperty::write(ui, "d_error_msg", interval);
    QMetaObject::invokeMethod(ui, "showMessage");
    hhm_log("Message --> " + msg);
}

void hhm_updateFromServer()
{
    QLocale ar_locale(QLocale::Arabic);
    QString date = ar_locale.toString(QDateTime::currentDateTime(), "hh:mm");
    hhm_setStatus("Updated from server " + date);
}

/*
 * Load IP Server from `HHM_CONFIG_FILE`
 * */
QString hhm_getServerIP()
{
    if( server_ip.isEmpty() )
    {
        QFile conf(HHM_CONFIG_FILE);
        if(conf.open(QIODevice::ReadOnly))
        {
            QString data = conf.readAll();
            if(data.isEmpty())
            {
               hhm_setStatus(QString(HHM_CONFIG_FILE) + QObject::tr("is empty"));
            }
            else
            {
                if( data.split("\n").length()>0 )
                {
                    server_ip = data.split("\n")[0];
                }
                else
                {
                    hhm_setStatus(QObject::tr("Server ip not found in") + QString(HHM_CONFIG_FILE));
                }
            }
        }
        else
        {
            hhm_setStatus(QObject::tr("Cann't open ") + QString(HHM_CONFIG_FILE));
        }
    }
    return server_ip;
}

bool hhm_rtlIsEnable()
{
    QVariant data = QQmlProperty::read(ui, "rtl");
    if( data.isValid() )
    {
        return data.toInt();
    }
    return false;
}

//Print in qDebug and LOG_FILE
void hhm_log(QString msg)
{
    qDebug() << msg;

    QLocale en_localce(QLocale::English);
    QString date = en_localce.toString(QDateTime::currentDateTime(), "(dd/MM hh:mm:ss) : ");
    QFile log_file(HHM_LOG_FILE);
    if( log_file.open(QIODevice::Append) )
    {
        QTextStream out(&log_file);
        out << date << msg << "\n";
        log_file.close();
    }
    else
    {
        qDebug() << "Cannot open" << log_file.fileName();
    }
}
