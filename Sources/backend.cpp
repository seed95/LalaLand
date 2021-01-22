#include "backend.h"

QObject *ui;
QString server_ip;

void setBackendUI(QObject *item)
{
    ui = item;
}

void hhm_setStatus(QString status)
{
    QQmlProperty::write(ui, "app_status", status);
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
        return;
    }

    QQmlProperty::write(ui, "error_msg", msg);
    QQmlProperty::write(ui, "d_error_msg", interval);
    QMetaObject::invokeMethod(ui, "showMessage");
}

/*
 * Load IP Server from `HHM_CONFIG_FILE`
 * */
QString hhm_getServerIP()
{
    if(server_ip.isEmpty())
    {
        QFile conf(HHM_CONFIG_FILE);
        if(conf.open(QIODevice::ReadOnly))
        {
            QString data = conf.readAll();
            if(data.isEmpty())
            {
               qDebug() << HHM_CONFIG_FILE << "is empty";
               hhm_setStatus(QString(HHM_CONFIG_FILE) + "is empty");
            }
            else
            {
                if( data.split("\n").length()>0 )
                {
                    server_ip = data.split("\n")[0];
                }
                else
                {
                    qDebug() << "Server ip not found in" << HHM_CONFIG_FILE;
                    hhm_setStatus("Server ip not found in" + QString(HHM_CONFIG_FILE));
                }
            }
        }
        else
        {
            qDebug() << "Cann't open" << HHM_CONFIG_FILE;
            hhm_setStatus("Cann't open " + QString(HHM_CONFIG_FILE));
        }
    }
    return server_ip;
}
