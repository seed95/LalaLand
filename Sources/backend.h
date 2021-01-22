#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QDebug>
#include <QQmlProperty>
#include <QFile>

#include "hhm_config.h"

void setBackendUI(QObject *item);
void hhm_setStatus(QString status);
void hhm_showMessage(QString msg, int interval=1000);
QString hhm_getServerIP();

#endif // BACKEND_H
