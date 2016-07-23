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
        anchors.leftMargin: 72
        anchors.rightMargin: 16

        Text {

            text: appBar.title
            color: Material.primaryTextColor
            font.family: "Roboto"
            font.pixelSize: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 16
        }



    }


}
