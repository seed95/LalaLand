QT += quick
QT += sql
QT += widgets

DEFINES += HHM_USER_ADMIN

RCC_DIR = Build/
OBJECTS_DIR = Build/
MOC_DIR = Build/
QMLCACHE_DIR = Build/

CONFIG += c++11

SOURCES += Sources/main.cpp \
           Sources/backend.cpp \
           Sources/hhm_chapar.cpp \
           Sources/hhm_database.cpp \
           Sources/hhm_mail.cpp \
           Sources/hhm_user.cpp

HEADERS += Sources/backend.h \
           Sources/hhm_chapar.h \
           Sources/hhm_config.h \
           Sources/hhm_database.h \
           Sources/hhm_mail.h \
           Sources/hhm_user.h

RESOURCES += Qml/gallery.qrc \
             Resources/fonts.qrc

OTHER_FILES += Qml/*.qml

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += Qml/
