/****************************************************************************
** This file is part of the UI for the LitteraeDroid program
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

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import StatisticsModule 1.0
import AppLogic 1.0
import "qrc:/CustomElements"


ApplicationWindow {

    id: mW
    visible: true

    height: Qt.platform.os === "windows" ? 800 : Screen.desktopAvailableHeight
    width: Qt.platform.os === "windows" ? 480 : Screen.desktopAvailableWidth
    Material.primary: "#4CAF50"
    Material.accent: "#FF5722"

    TextProcessor {

        id: processor
    }

    WSettings {

        id: settings
    }

    Utilities {

        id: util
    }   

    StatisticsModel {

        id: statistics
    }

    StackLayout {

        id: layout
        anchors.fill: parent
        currentIndex: navBar.currentIndex

        MainMenu {

        }
        StatisticsTab {

        }
        SettingsTab {
            id: sets
        }

    }

    footer: BottomNavBar {

        id: navBar
    }
    header: AppBar {

        id: appBar
        title: navBar.currBar

    }
}
