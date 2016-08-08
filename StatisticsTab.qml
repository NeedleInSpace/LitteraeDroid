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
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material.impl 2.0
import "qrc:/CustomElements"

Item {

    anchors.fill: parent

    Item {

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.topMargin: 16
        height: childrenRect.height

        id: xtra



        Rectangle {

            id: textTile
            color: "white"
            radius: 2
            anchors.fill: parent
            layer.enabled: true
            layer.effect: ElevationEffect {
                elevation: 2
            }
        }

        Image {

            source: "qrc:/icons/ic_stars_48px.svg"
            scale: 1
            anchors.top: textTile.top
            anchors.right: parent.right
            anchors.rightMargin: 16
            anchors.topMargin: 24
            opacity: statChart.currentIndex === statistics.best ? 1: 0.2
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: statChart.currentIndex === statistics.best ?
                           Material.primaryColor :
                           Material.hintTextColor
            }
        }

        Label {
            id: title
            text: "Current statistics"
            font.pixelSize: 24
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.top: parent.top
            anchors.topMargin: 24
        }
        Label {
            id: speedStat
            text: statChart.currentIndex !== -1 ?
                      "Speed: " + statChart.currentItem.s + " cpm\n" +
                      "Typos: " + statChart.currentItem.t +
                      "\nPoints: " + statChart.currentItem.p +
                      (statChart.currentItem.p > statistics.average ? "\nBetter than the average result": "\n") :
                      "No statistics available"
            color: Material.hintTextColor
            anchors.top: title.bottom
            anchors.left: parent.left
            anchors.leftMargin: 16
            font.pixelSize: 14
        }

        Button {

            highlighted: true
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.top: speedStat.bottom
            anchors.topMargin: 8
            flat: true
            text: "Clear"
            onClicked: {
                statistics.flush_stats()
            }
        }
    }

    Rectangle {

        id: bckgrnd
        color: "white"
        radius: 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 16
        anchors.rightMargin: anchors.leftMargin
        anchors.top: xtra.bottom
        anchors.topMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        height: parent.height * 0.6
        layer.enabled: true
        layer.effect: ElevationEffect {
            elevation: 2
        }


        ListView {

            id: statChart
            model: statistics
            anchors.fill: parent
            anchors.margins: 16
            anchors.bottomMargin: 24
            orientation: ListView.Horizontal
            flickableDirection: Flickable.AutoFlickIfNeeded
            boundsBehavior: Flickable.DragOverBounds
            spacing: 18
            clip: true

            Rectangle {

                id: mediumLine
                anchors.bottom: parent.bottom
                anchors.bottomMargin:
                    parent.currentIndex !== -1 ?
                        (statistics.average / 5000) * parent.height + 24 :
                        24

                height: 1
                width: parent.width
                color: Material.hintTextColor

                Label {
                    text: "Average: " + statistics.average.toFixed(0)
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 8
                }
            }

            section.property: "date"
            section.delegate: Item {

                anchors.bottom: parent.bottom
                width: 18
                height: parent.height - 10

                Rectangle {
                    width: 1
                    color: "#BDBDBD"
                    height: parent.height - 30
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }
                Label {
                    text: section
                    anchors.top: parent.top
                    anchors.left: parent.left
                }
            }


            delegate: Rectangle {

                id: bar
                property double s: speed.toFixed(2)
                property int t: typos
                property double p: points.toFixed(0)
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 24
                height: (points / 5000) * statChart.height
                width: 40
                color: statistics.best !== index ? Material.color(Material.LightBlue) : "#D50000"
                clip: false

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        statChart.currentIndex = index;
                    }
                }

                Label {
                    text: points.toFixed(0)
                    font.pixelSize: 14
                    anchors.top: parent.bottom
                    anchors.bottomMargin: 8
                }

            }

            highlight: Rectangle {

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 24
                color: "white"
                opacity: 0.3
                z: 2

            }

            Rectangle {

                id: axisLine
                color: "black"
                height: 1
                width: parent.width
                opacity: 0.86
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 24
            }

        }
    }


}
