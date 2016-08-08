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
import QtGraphicalEffects 1.0

Item {

    property alias popup: _popup
    property string last
    property bool more
    anchors.centerIn: parent
    width: 56 * 5
    height: title.height + res.height + 72 + 68

    Popup {
        id: _popup
        width: parent.width
        height: parent.height
        leftPadding: 16
        topPadding: 24
        rightPadding: 16
        bottomPadding: 8
        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose

        Label {
            id: title
            anchors.left: parent.Left
            anchors.top: parent.top
            text: "Text completed"
            font.pixelSize: 20
            font.family: "Roboto Medium"

            Label {
                id: res
                anchors.top: parent.bottom
                anchors.topMargin: 20
                text: "Your results: " + last
                font.pixelSize: 16
                color: Material.hintTextColor
            }
        }

        RowLayout {
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            Button {
                text: "show more"
                flat: true
                highlighted: true
                enabled: more
                onClicked: {
                    _popup.close();
                    navBar.currentIndex = 1;
                }
            }

            Button {
                text: "OK"
                highlighted: true
                flat: true
                onClicked: {
                    _popup.close();
                }
            }
        }

        onOpened: {
            last = statistics.last()
        }
    }
}
