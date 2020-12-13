#include "backend.h"

QObject *ui;

void setBackendUI(QObject *item)
{
    ui = item;
}

void setStatus(QString status)
{
    ///FIXME
    qDebug() << status;
}
