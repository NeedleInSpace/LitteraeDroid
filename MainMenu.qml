import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import Statistics 1.0
import "./CustomElements"

Item {

    id: mainMenuRoot
    anchors.fill: parent

    StatisticsModel { id: statModel }


    Label {

        text: "I'm main menu" + statView.currentIndex
        font.pixelSize: 24
        anchors.centerIn: parent
    }


    ListView {

        id: statView
        anchors.centerIn: parent
        height: 100
        width: 100
        model: statModel
        delegate: Text {

            text: "LALALAL"
        }
    }
    Button {

        text: "ADD"
        onPressed: {
            statModel.insertRow(12.5,"Today",3)
        }
    }

}
