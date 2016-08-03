import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Item {

    property alias popup: _popup
    property string last
    property bool more
    anchors.centerIn: parent
    width: 56 * 5
    height: title.height + res.height + 72 + util.dp(68)

    Popup {
        id: _popup
        width: parent.width
        height: parent.height
        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose

        Label {
            id: title
            x: util.dp(24)
            anchors.top: parent.top
            anchors.topMargin: util.dp(24)
            text: "Text completed"
            font.pixelSize: 20
            font.family: "Roboto Medium"

            Label {
                id: res
                anchors.top: parent.bottom
                anchors.topMargin: util.dp(20)
                text: "Your results: " + last
                font.pixelSize: 16
                color: Material.hintTextColor
            }
        }

        RowLayout {
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            Button {
                text: "show more"
                flat: true
                highlighted: true
                enabled: more
                onClicked: {
                    _popup.close();
                    navBar.currentIndex = 1;
                }
            }

            Button {
                text: "OK"
                highlighted: true
                flat: true
                onClicked: {
                    _popup.close();
                }
            }
        }

        onOpened: {
            last = statistics.last()
        }
    }
}
