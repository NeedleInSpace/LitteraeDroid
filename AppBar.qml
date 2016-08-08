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

ToolBar {

    id: appBar
    height: 56
    Material.elevation: 4
    property string title: "Litterae Droid"

    Text {

        id: text
        text: appBar.title
        anchors.left: parent.left
        anchors.baseline: parent.bottom
        anchors.baselineOffset: -20
        anchors.leftMargin: 72
        color: "white"
        font.family: "Roboto Medium"
        font.pixelSize: 20
        font.weight: Font.Medium
    }
}
