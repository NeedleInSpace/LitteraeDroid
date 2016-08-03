import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

Item {

    id: settingsRoot
    anchors.fill: parent
    anchors.rightMargin: util.dp(16)
    anchors.leftMargin: util.dp(28)
    property alias statenable: stats.checked

    ColumnLayout {

        anchors.fill: parent

        Item {

            id: statTrack
            Layout.fillWidth: true
            anchors.top: parent.top
            height: 72

            Label {

                anchors.left: parent.left
                anchors.top: parent.top
                text: "Statistics"
                font.pixelSize: 16
                anchors.topMargin: util.dp(20)
            }

            Label {

                anchors.left: parent.left
                anchors.bottom: parent.bottom
                text: "Track statistics"
                font.pixelSize: 14
                color: Material.hintTextColor
                anchors.bottomMargin: util.dp(20)
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

    }

}
