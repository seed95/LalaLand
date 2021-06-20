QT += quick
QT += sql
QT += widgets
QT += core
QT += network

RCC_DIR = Build/
OBJECTS_DIR = Build/
MOC_DIR = Build/
QMLCACHE_DIR = Build/

CONFIG += c++11

SOURCES += Sources/main.cpp \
           Sources/backend.cpp \
           Sources/hhm_attach.cpp \
           Sources/hhm_chapar.cpp \
           Sources/hhm_database.cpp \
           Sources/hhm_mail.cpp \
           Sources/hhm_message.cpp \
           Sources/hhm_news.cpp \
           Sources/hhm_user.cpp

HEADERS += Sources/backend.h \
           Sources/hhm_attach.h \
           Sources/hhm_chapar.h \
           Sources/hhm_config.h \
           Sources/hhm_database.h \
           Sources/hhm_mail.h \
           Sources/hhm_message.h \
           Sources/hhm_news.h \
           Sources/hhm_user.h

RESOURCES += Qml/ui.qrc \
             Resources/fonts.qrc \
             Resources/images.qrc \
             Resources/translators.qrc

OTHER_FILES += Qml/*.qml \
               Qml/Pages/Message/*.qml \
               Qml/Pages/Document/*.qml \
               Qml/Pages/Admin/*.qml \
               Qml/Sidebar/*.qml \
               Qml/Elements/*.qml \
               Qml/Login/*.qml

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += Qml/

RC_ICONS += DM.ico
