import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

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
        anchors.leftMargin: util.dp(16)
        anchors.rightMargin: anchors.leftMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: util.dp(56)
        height: mW.height * 0.6
        orientation: ListView.Horizontal
        spacing: 10

        Rectangle {

            id: mediumLine
            anchors.bottom: parent.bottom
            anchors.bottomMargin:
                parent.currentIndex !== -1 ?
                    (statistics.average / 300) * parent.height :
                    util.dp(16)

            height: 1
            width: parent.width
            color: Material.hintTextColor

            Label {
                text: "average: " + statistics.average.toFixed(2)
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
            z: 5
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

            property var s: speed.toFixed(2)
            property var t: typos
            property var p: points.toFixed(0)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: util.dp(16)
            height: (speed / 300) * statChart.height
            width: 40
            color: Material.color(Material.LightBlue)

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    statChart.currentIndex = index;
                }
            }

            Label {
                text: speed.toFixed(0)
                font.pixelSize: 14
                anchors.top: parent.bottom
                anchors.topMargin: 4
            }
        }

        Rectangle {

            id: axisLine
            color: "black"
            height: 1
            x: util.dp(-16)
            width: mW.width
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


