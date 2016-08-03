import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0
import "./CustomElements"

Item {

    anchors.fill: parent

    Item {

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: statChart.top
        anchors.leftMargin: util.dp(72)
        anchors.rightMargin: util.dp(16)
        anchors.topMargin: util.dp(20)
        anchors.bottomMargin: util.dp(20)

        id: xtra

        Label {
            text: "Current statistics"
            font.pixelSize: 24
            anchors.left: parent.left
            anchors.top: parent.top

            Label {
                id: speedStat
                text: statChart.currentIndex !== -1 ?
                          "Speed: " + statChart.currentItem.s + " cpm\n" +
                          "Typos: " + statChart.currentItem.t +
                          "\nPoints: " + statChart.currentItem.p :
                          "NO_STATS"
                anchors.top: parent.bottom
                font.pixelSize: 16
            }
        }
    }


    ListView {

        id: statChart
        model: statistics
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: util.dp(32)
        anchors.rightMargin: anchors.leftMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: util.dp(56)
        height: parent.height * 0.6
        orientation: ListView.Horizontal
        flickableDirection: Flickable.AutoFlickIfNeeded
        boundsBehavior: Flickable.StopAtBounds
        spacing: 10

        Rectangle {

            id: bckgrnd
            color: "white"
            radius: 2
            anchors.fill: parent
            anchors.leftMargin: util.dp(-16)
            anchors.rightMargin: anchors.leftMargin
            anchors.bottomMargin: util.dp(-32)
            layer.enabled: true
            layer.effect: DropShadow {
                color: Material.dropShadowColor
                samples: 12
                spread: 0.2
                verticalOffset: 2
            }
            z: -1
        }

        Rectangle {

            id: mediumLine
            anchors.bottom: parent.bottom
            anchors.bottomMargin:
                parent.currentIndex !== -1 ?
                    (statistics.average / 5000) * parent.height :
                    util.dp(16)

            height: 1
            width: parent.width
            color: Material.hintTextColor

            Label {
                text: "average: " + statistics.average.toFixed(0)
                anchors.right: parent.right
                anchors.rightMargin: util.dp(16)
                anchors.bottom: parent.top
                anchors.bottomMargin: util.dp(16)
            }
        }

        section.property: "date"
        section.delegate: Rectangle {

            anchors.bottom: parent.bottom
            width: 1
            height: parent.height - 10
            color: "red"

            Label {
                text: section
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 8
            }

        }


        delegate: Rectangle {

            id: bar
            property double s: speed.toFixed(2)
            property int t: typos
            property double p: points.toFixed(0)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: util.dp(16)
            height: (points / 5000) * statChart.height
            width: 40
            color: statistics.best !== index ? Material.color(Material.LightBlue) : "red"

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
                anchors.topMargin: 4
            }

        }

        highlight: Rectangle {

            anchors.bottom: parent.bottom
            anchors.bottomMargin: util.dp(16)
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
            anchors.bottomMargin: util.dp(16)
        }

    }

    Button {

        highlighted: true
        anchors.right: parent.right
        anchors.rightMargin: util.dp(16)
        anchors.bottom: statChart.top
        anchors.bottomMargin: util.dp(16)
        text: "Clear"
        onPressed: {
            statistics.flush_stats()
        }
    }

}
