#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QTranslator>
#include "hhm_chapar.h"
#include "backend.h"
#include "hhm_melica.h"

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
    app.setOrganizationName("WBT");
    app.setOrganizationDomain("WBT.com");
    app.setApplicationName("DocumentManager");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(url);
    QObject *mainItem = engine.rootObjects().first();

    hhm_log("-------------------------Start Document Manager-------------------------");
    hhm_setBackendUI(mainItem);

    HhmChapar *chapar = new HhmChapar(mainItem);


    ///FIXME: MELICA
    // Create Car objects and call the constructor with different values
    HhmMelica carObj1("BMW", "X5", 1999);
    HhmMelica carObj2("Ford", "Mustang", 1969);

    // Print values
    qDebug() << carObj1.brand << " " << carObj1.model << " " << carObj1.year << "\n";
    qDebug() << carObj2.brand << " " << carObj2.model << " " << carObj2.year << "\n";
    HhmMelica myObj("BMW", "X5", 1999); ;     // Create an object of MyClass
    myObj.myMethod();  // Call the method
    return app.exec();
}
