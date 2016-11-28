QT += qml quick network quickcontrols2


CONFIG += c++11

SOURCES += main.cpp \
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
    qajax.h

DISTFILES += \
    qmldir

