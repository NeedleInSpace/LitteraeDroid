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

Item {

    id: settingsRoot
    anchors.fill: parent
    anchors.rightMargin: 16
    anchors.leftMargin: 28
    property alias statenable: stats.checked

    ColumnLayout {

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        //***********************************STATSTRACKING
        Item {

            id: statTrack
            Layout.fillWidth: true
            height: 72

            Label {
                id: lbl
                anchors.left: parent.left
                anchors.top: parent.top
                text: "Statistics"
                font.pixelSize: 16
                topPadding: 20
            }

            Label {

                anchors.left: parent.left
                anchors.top: lbl.bottom
                text: "Track statistics"
                font.pixelSize: 14
                color: Material.hintTextColor
                anchors.baselineOffset: -20
            }

            Switch {
                id: stats
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                checked: settings.value("TrackStats", "true")
                onClicked: {
                    checked ? settings.setValue("TrackStats", "true") : settings.setValue("TrackStats", "false");
                }
            }

            Rectangle {

                height: 1
                width: parent.width
                anchors.bottom: parent.bottom
                color: "black"
                opacity: 0.1

            }
        }
        //***********************************LEGAL
        Item {

            id: legal
            Layout.fillWidth: true
            height: 72

            Label {
                id: legalt
                anchors.left: parent.left
                anchors.top: parent.top
                text: "Legal information"
                font.pixelSize: 16
                topPadding: 20
            }

            Label {

                anchors.left: parent.left
                anchors.top: legalt.bottom
                text: "GNU GPL v3.0"
                font.pixelSize: 14
                color: Material.hintTextColor
                anchors.baselineOffset: -20
            }

            MouseArea {

                anchors.fill: parent
                onClicked: {
                    pop.open();
                }
            }
            Popup {

                id: pop
                modal: true
                width: 56 * 5
                height: 72 * 5

                    Text {
                        horizontalAlignment: Text.AlignJustify
                        anchors.fill: parent
                        text:
                            "LitteraeDroid v0.9
Copyright (C) 2016 The Needle Company
Contact: needleinspace@gmail.com
Source: https://github.com/NeedleInSpace/LitteraeDroid\n
This program is free software: you can redistribute
it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any
later version.\n
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.\n
You should have received a copy of the
GNU General Public License along with this program.
If not, see <http://www.gnu.org/licenses/>."
                        font.family: "Roboto"
                        font.pointSize: 9
                    }

            }
        }

    }

}
