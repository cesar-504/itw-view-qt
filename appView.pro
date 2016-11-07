QT += qml quick network quickcontrols2


CONFIG += c++11

SOURCES += main.cpp \
    jsonrequest.cpp \
    qajax.cpp

RESOURCES += qml.qrc

DEFINES  += QT_NO_SSL

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    jsonrequest.h \
    qajax.h


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/lib/qjson/release/ -lqjson-qt5
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/lib/qjson/debug/ -lqjson-qt5
else:unix: LIBS += -L$$PWD/lib/qjson/ -lqjson-qt5

INCLUDEPATH += $$PWD/lib/qjson
DEPENDPATH += $$PWD/lib/qjson
