#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QDebug>
#include <QQmlProperty>


void setBackendUI(QObject *item);
void setStatus(QString status);
void hhm_showMessage(QString msg, int interval=1000);

#endif // BACKEND_H
