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
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0

TabButton {

    id: control
    font.capitalization: Font.MixedCase
    font.pixelSize: checked ? 14 : 12
    height: parent.height
    property alias imgsrc: butsrc.source

    contentItem: Item {
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: 8

        Text {
            id: t
            text: control.text
            font: control.font
            color: !control.enabled ? control.Material.hintTextColor
                                    : control.down || control.checked
                                      ? control.Material.primaryColor
                                      : control.Material.hintTextColor
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 8

        }
        // Random icon for a concept view
        Image {

            id: butsrc
            width: 24
            height: 24
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: t.top
            opacity: control.checked ? 1 : 0.38
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: control.checked ? Material.primaryColor : Material.hintTextColor
            }
        }

    }
    Behavior on font.pixelSize {
        NumberAnimation { duration: 40 }
    }

}
