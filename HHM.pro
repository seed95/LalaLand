QT += quick

RCC_DIR = Build/
OBJECTS_DIR = Build/
MOC_DIR = Build/
QMLCACHE_DIR = Build/

CONFIG += c++11

SOURCES += Sources/main.cpp

HEADERS +=

RESOURCES += gallery.qrc

OTHER_FILES += Qml/*

DISTFILES += Qml/HhmSideBar.qml \
             Qml/HhmBottomBar.qml \
             Qml/HhmSideBarElement.qml
