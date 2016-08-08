QT += qml quick quickcontrols2 svg
unix: QT += androidextras

CONFIG += c++11

SOURCES += main.cpp \
    textprocessor.cpp \
    statisticsmodel.cpp \
    utility.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = Q:\Qt\5.7\msvc2015\qml\QtQuick\Controls.2

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    textprocessor.h \
    statisticsmodel.h \
    settingswrapper.h \
    utility.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

