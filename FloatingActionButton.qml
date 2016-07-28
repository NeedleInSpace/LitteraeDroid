import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Item {

    id: root
    height: 56
    width: 56

    property alias innerrect: innerR

    Button {

        id: control
        highlighted: true
        text: ""
        anchors.fill: parent
        background: Rectangle {

            radius: 29
            color: Material.accent
            layer.enabled: true
            layer.effect: DropShadow {
                color: Material.dropShadowColor
                samples: control.pressed ? 20 : 10
                spread: 0.5
                Behavior on samples {
                    NumberAnimation { duration: 90 }
                }
            }

            Rectangle {

                id: innerR
                color: "white"
                height: 20
                width: 20
                radius: 11
                anchors.centerIn: parent

                Behavior on radius {
                    NumberAnimation { duration: 100 }
                }
            }
        }

        onPressed: {
            // TODO: pass property changes to states
            mainMenuRoot.state = mainMenuRoot.state === "" ? "LAUNCHED" : "";
            if (mainMenuRoot.state === "LAUNCHED") {
                processor.randomiseText(true);
                field.clear();
                field.focus = true;
                field.forceActiveFocus();
                Qt.inputMethod.show();
                processor.startClock();
            }
            else {
                processor.clockReset();
                field.typos = 0;
                field.clear();
                field.focus = false;
                textbgcolor = "white";
            }
        }


        onStateChanged: {

            console.log('state changed');
        }
    }




}
