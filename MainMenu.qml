import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
//import StatisticsModule 1.0
import "./CustomElements"

Item {

    id: mainMenuRoot
    anchors.fill: parent
    property string gentxt: processor.text

    states: [
        State {

            name: "LAUNCHED"
            PropertyChanges {
                target: floatButt.innerrect
                radius: 0
            }
        }
    ]

    Rectangle {

        id: topTitle
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80
        layer.enabled: true
        layer.effect: DropShadow {
            color: Material.dropShadowColor
            samples: 10
            spread: 0.5
        }

        Label {

            id: lbl
            anchors.fill: parent
            anchors.leftMargin: 72
            anchors.rightMargin: 16
            text: new Date() // TODO: working timer
            topPadding: 12
            font.pixelSize: 24
            elide: Text.ElideLeft
        }

        z: 3
    }



    Flickable {

        anchors.top: topTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: text.top
        anchors.bottomMargin: 16
        contentHeight: card.height
        flickableDirection: Flickable.AutoFlickIfNeeded

        TextCard {

            id: card
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            anchors.topMargin: 8
        }

        z: 2
    }

    Rectangle {

        color: "white"
        id: text
        height: 48
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        z: 4

        TextField {

            id: field
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            font.pixelSize: 16
            focus: false
            activeFocusOnPress: false
            placeholderText: "This field will be active when you'll start"
            onCursorPositionChanged: {
                switch(processor.checkState(getText(0, cursorPosition))) {
                case 0 :
                    mainMenuRoot.state = "";
                    focus = false;
                    clear();
                    break;
                case 1: break;
                case 2: break; // TODO: update code reaction
                default: break;
                }

            }
        }
        layer.enabled: true
        layer.effect: DropShadow {
            color: Material.dropShadowColor
            samples: 10
            spread: 0.5
        }
    }
    FloatingActionButton {

        id: floatButt
        anchors.right: parent.right
        anchors.bottom: text.top
        anchors.rightMargin: 16
        anchors.bottomMargin: 8
        z: 4
    }

}
