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
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Material.impl 2.0

Item {

    id: card
    property string gentxt: processor.text
    property var mtext: mainText
    height: mainText.contentHeight + 16 + 24

    Rectangle {

        id: bckgrnd
        color: "white"
        radius: 2
        anchors.fill: parent
        layer.enabled: true
        layer.effect: ElevationEffect {
            elevation: 2
        }

        Label {

            id: mainText
            text: gentxt
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            topPadding: 16
            font.pixelSize: 16
            verticalAlignment: Text.AlignJustify
            wrapMode: Text.Wrap
        }
    }

    Behavior on height {
        NumberAnimation {
            duration: 150
            easing.type: Easing.OutBounce
        }
    }
}


