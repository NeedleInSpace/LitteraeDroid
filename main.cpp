/****************************************************************************
** This file is part of LitteraeDroid program which determines typing speed
** Copyright (C) 2016 The Needle Company
** Contact: needleinspace@gmail.com
**
** This program is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program.  If not, see <http://www.gnu.org/licenses/>.
**
****************************************************************************/

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
