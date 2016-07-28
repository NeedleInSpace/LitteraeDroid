import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

ToolBar {

    id: appBar
    height: 56
    property string title: "Typing speed test"

    RowLayout {

        anchors.fill: parent

        Text {

            text: appBar.title
            color: Material.primaryTextColor
            font.family: "Roboto"
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.leftMargin: 72 / dp
            verticalAlignment: Text.AlignVCenter
        }
    }
}
