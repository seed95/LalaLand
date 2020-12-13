#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include "hhm_chapar.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(url);

    HhmChapar *chapar = new HhmChapar(engine.rootObjects().first());

    return app.exec();
}
