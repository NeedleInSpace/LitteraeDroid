import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Item {

    property alias popup: _popup
    anchors.centerIn: parent

    Popup {
            id: _popup
            width: 200
            height: 300
            modal: true
            focus: true
            closePolicy: Popup.NoAutoClose

            Button {
                text: "OK"
                flat: true
                onPressed: {
                    _popup.close();
                }
            }

        }
}
