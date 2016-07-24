QT += qml quick quickcontrols2

CONFIG += c++11

SOURCES += main.cpp \
    textprocessor.cpp \
    statisticsmodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    textprocessor.h \
    statisticsmodel.h \
    settingswrapper.h

DISTFILES +=
