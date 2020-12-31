#include "backend.h"

QObject *ui;

void setBackendUI(QObject *item)
{
    ui = item;
}

void setStatus(QString status)
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
