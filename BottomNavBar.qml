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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0

TabBar {

    id: navBar
    layer.enabled: true
    layer.effect: DropShadow {
        color: Material.dropShadowColor
        samples: 12
        spread: 0.2
    }
    height: 56
    property var currBar: currentIndex == 0 ? "Typing Speed Test"
                                            : currentIndex == 1
                                              ? "Statistics"
                                              : "Settings"

    contentItem: ListView {
        implicitWidth: contentWidth
        implicitHeight: 56

        model: navBar.contentModel
        currentIndex: navBar.currentIndex

        spacing: navBar.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem

        }


    CTabButton {

        id: homeBtn
        text: "Home"
        imgsrc: "qrc:/icons/ic_textsms_24px.svg"

    }

    CTabButton {

        id: statsBtn
        text: "Statistics"
        imgsrc: "qrc:/icons/ic_timeline_24px.svg"
    }

    CTabButton {

        id: setttingsBtn
        text: "Settings"
        imgsrc: "qrc:/icons/ic_settings_24px.svg"
    }

}

