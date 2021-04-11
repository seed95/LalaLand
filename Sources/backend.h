#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QDebug>
#include <QQmlProperty>
#include <QFile>
#include <QDateTime>

#include "hhm_config.h"

void hhm_setBackendUI(QObject *item);

void hhm_setStatus(QString status);
void hhm_showMessage(QString msg, int interval=1000);

QString hhm_getServerIP();

QString convertNumber(QString number);

void hhm_log(QString msg);

#endif // BACKEND_H
