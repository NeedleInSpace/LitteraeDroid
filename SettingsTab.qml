import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

Item {

    id: settingsRoot
    anchors.fill: parent
    anchors.rightMargin: util.dp(16)
    anchors.leftMargin: util.dp(16)

    ColumnLayout {

        anchors.fill: parent

        Item {

            id: statTrack
            Layout.fillWidth: true
            anchors.top: parent.top
            height: 72

            Label {

                anchors.fill: parent
                text: "Track statistics"
                font.pixelSize: 16
                verticalAlignment: Text.AlignVCenter
            }

            Switch {

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

    }

}
