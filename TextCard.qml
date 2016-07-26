import QtQuick 2.7
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

Item {

    id: card
    property string gentxt: processor.text
    property var mtext: mainText
    height: mainText.contentHeight + 24

    Rectangle {

        id: bckgrnd
        color: "white"
        radius: 2
        anchors.fill: parent
        layer.enabled: true
        layer.effect: DropShadow {
            color: Material.dropShadowColor
            samples: 10
            spread: 0.5
        }

        Label {

            id: mainText
            text: gentxt
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            topPadding: 8
            font.pixelSize: 16
            verticalAlignment: Text.AlignJustify
            wrapMode: Text.Wrap
        }
    }

    Behavior on height {
        NumberAnimation {
            duration: 150
            easing: Easing.OutBounce
        }
    }
}


