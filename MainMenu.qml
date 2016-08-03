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
    property alias textbgcolor: text.color

    states: [
        State {

            name: "LAUNCHED"
            PropertyChanges {
                target: floatButt.innerrect
                radius: 0
            }
            PropertyChanges {
                target: field
                focus: true
            }
        }
    ]
    //********************************************HEADERWITHTIMER
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
            anchors.leftMargin: util.dp(72)
            text: mainMenuRoot.state === "LAUNCHED" ?
                      processor.timer.toFixed(2) + " sec : " + field.typos :
                      "Timer hasn't started"
            anchors.topMargin : util.dp(12)
            font.pixelSize: 24
            elide: Text.ElideLeft
        }
        Label {

            id: subHead
            anchors.fill: parent
            anchors.leftMargin: util.dp(72)
            text: "Time elapsed and total misprints"
            anchors.bottomMargin: util.dp(20)
            color: Material.hintTextColor
            font.pixelSize: 14
            verticalAlignment: Text.AlignBottom
            elide: Text.ElideLeft
        }

        z: 3
    }

    //********************************************TEXTCARD

    Flickable {

        anchors.top: topTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: text.top
        anchors.bottomMargin: util.dp(16)
        contentHeight: card.height
        flickableDirection: Flickable.AutoFlickIfNeeded

        TextCard {

            id: card
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: util.dp(16)
            anchors.rightMargin: util.dp(16)
            anchors.topMargin: util.dp(16)

        }

        z: 2
    }
    //********************************************TEXTFIELD
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
            property int typos: 0
            anchors.fill: parent
            anchors.leftMargin: util.dp(16)
            anchors.rightMargin: util.dp(16)
            font.pixelSize: 16
            focus: false
            activeFocusOnPress: false
            placeholderText: "This field will be active when you'll start"
            inputMethodHints: Qt.ImhNoPredictiveText

            onFocusChanged: {
                if (focus) {
                    mW.footer = null;
                } else
                    mW.footer = navBar;
            }
            onCursorPositionChanged: {
                if (mainMenuRoot.state === "LAUNCHED") {
                    switch(processor.checkState(getText(0, cursorPosition))) {
                    case 0 :
                        var spd = processor.text.length * 60 / processor.timer;
                        mainMenuRoot.state = "";
                        if (sets.statenable) {
                            pop.more = true;
                            statistics.add(spd,
                                           new Date().toLocaleDateString("yy.MMM.dd"),
                                           typos,
                                           spd * 10 - typos / processor.text.length * spd * 10 ,
                                           true);
                        }
                        else
                            pop.more = false;
                        typos = 0;
                        clear();
                        processor.clockReset();
                        text.color = "white";
                        text.Material.accent = mW.Material.accent
                        pop.popup.open();
                        break;
                    case 1:
                        text.Material.accent = "#00C853"
                        text.color = "#A7FFEB";
                        break;
                    case 2:
                        text.Material.accent = "#D50000"
                        text.color = "#FF8A80";
                        typos++;
                        break;
                    case 3:
                        break;
                    default: break;
                    }
                }

            }
        }

        layer.enabled: true
        layer.effect: DropShadow {
            color: Material.dropShadowColor
            samples: 10
            spread: 0.5
        }
        Behavior on color {
            ColorAnimation {
                duration: 90
            }
        }
    }
    //********************************************FINISHPOPUP
    FinishPopup {

        id: pop
    }

    //********************************************FAB
    FloatingActionButton {

        id: floatButt
        anchors.right: parent.right
        anchors.bottom: text.top
        anchors.rightMargin: util.dp(16)
        anchors.bottomMargin: util.dp(16)
        z: 4
    }

}
