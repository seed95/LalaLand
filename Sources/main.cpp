#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include "hhm_chapar.h"
#include "backend.h"

/*
Compile mysql driver, https://doc.qt.io/qt-5/sql-driver.html#building-the-drivers
Path=C:\Qt\Qt5.14.2\Tools\QtCreator\bin;C:\Qt\Qt5.14.2\5.14.2\mingw73_32\bin;C:\Qt\Qt5.14.2\Tools\mingw730_32\bin
cd C:\Qt\Qt5.14.2\5.14.2\Src\qtbase\src\plugins\sqldrivers
qmake -- MYSQL_INCDIR="C:/Program Files (x86)/MySQL/MySQL Connector C 6.1/include" MYSQL_LIBDIR="C:/Program Files (x86)/MySQL/MySQL Connector C 6.1/lib"
*/

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(url);
    QObject *mainItem = engine.rootObjects().first();

    hhm_log("-------------------------Start Document Manager-------------------------");
    hhm_setBackendUI(mainItem);

    HhmChapar *chapar = new HhmChapar(mainItem);

    return app.exec();
}
