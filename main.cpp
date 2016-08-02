#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "textprocessor.h"
#include "statisticsmodel.h"
#include "settingswrapper.h"
#include "utility.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    qmlRegisterType<TextProcessor>("AppLogic",1,0,"TextProcessor");
    qmlRegisterType<StatisticsModel>("StatisticsModule",1,0,"StatisticsModel");
    qmlRegisterType<StatisticsElement>("StatisticsModule",1,0,"StatisticsElement");
    qmlRegisterType<SettingsWrapper>("AppLogic",1,0,"WSettings");
    qmlRegisterType<Utility>("AppLogic",1,0,"Utilities");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
