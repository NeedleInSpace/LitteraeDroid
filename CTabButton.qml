import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

TabButton {

    id: control
    font.capitalization: Font.MixedCase
    font.pixelSize: checked ? 14 : 12
    height: parent.height

    contentItem: Item {
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.topMargin: 8

        Text {
            id: t
            text: control.text
            font: control.font
            color: !control.enabled ? control.Material.hintTextColor
                                    : control.down || control.checked
                                      ? control.Material.primaryColor
                                      : control.Material.hintTextColor
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 6

        }
        Rectangle {
            height: 24
            width: 24
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: t.top
            radius: 12
            color: control.checked ? control.Material.primaryColor
                                   : control.Material.hintTextColor
        }
    }



    Behavior on font.pixelSize {
        NumberAnimation { duration: 40 }
    }

}
