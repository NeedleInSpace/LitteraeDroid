import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

ToolBar {

    id: appBar
    height: 56
    property string title: "Litterae Droid"

    RowLayout {

        anchors.fill: parent

        Text {

            text: appBar.title
            color: Material.primaryTextColor
            font.family: "Roboto"
            font.weight: Font.Medium
            font.pixelSize: 20
            anchors.left: parent.left
            anchors.leftMargin: util.dp(72)
            verticalAlignment: Text.AlignVCenter
        }
    }
}
