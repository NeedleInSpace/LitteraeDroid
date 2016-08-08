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
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Material.impl 2.0
import QtGraphicalEffects 1.0

Item {

    id: root
    height: 56
    width: 56

    property alias innerrect: innerR

    Button {

        id: control
        highlighted: true
        text: ""
        anchors.fill: parent
        background: Rectangle {

            radius: 29
            color: Material.accent
            layer.enabled: true
            layer.effect: ElevationEffect {
                elevation: control.pressed ? 12 : 8
                Behavior on elevation {
                    NumberAnimation { duration: 90 }
                }
            }
            Rectangle {

                id: innerR
                color: "white"
                height: 20
                width: 20
                radius: 11
                anchors.centerIn: parent

                Behavior on radius {
                    NumberAnimation { duration: 100 }
                }
            }
        }

        onClicked: {
            mainMenuRoot.state = mainMenuRoot.state === "" ? "LAUNCHED" : "";
            if (mainMenuRoot.state === "LAUNCHED") {
                processor.randomiseText(true);
                field.clear();
                field.forceActiveFocus();
                Qt.inputMethod.show();
                processor.startClock();
            }
            else {
                processor.clockReset();
                field.typos = 0;
                field.clear();
                textbgcolor = "white";
            }
        }
        onStateChanged: {

            console.log('state changed');
        }
    }




}
