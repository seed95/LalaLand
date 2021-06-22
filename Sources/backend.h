#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QDebug>
#include <QQmlProperty>
#include <QFile>
#include <QDateTime>
#include <QTranslator>

#include "hhm_config.h"

void hhm_setBackendUI(QObject *item);

void hhm_setServerStatus(QString status);
void hhm_setStatus(QString status);
void hhm_showMessage(QString msg, int interval=1000);

void hhm_updateFromServer();

QString hhm_getServerIP();
bool hhm_rtlIsEnable();

QString hhm_getLastDirectory();
void    hhm_setLastDirectory(QString lastDir);

QString hhm_getFtpAddress();
void    hhm_setFtpAddress(QString address);
QString hhm_getFtpUsername();
void    hhm_setFtpUsername(QString username);
QString hhm_getFtpPassword();
void    hhm_setFtpPassword(QString password);

void hhm_log(QString msg);

#endif // BACKEND_H
