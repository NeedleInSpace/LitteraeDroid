import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

TabBar {

    id: navBar
    layer.enabled: true
    layer.effect: ElevationEffect { elevation: 8 }
    height: 56
    property var currBar: currentIndex == 0 ? "Typing Speed Test"
                                            : currentIndex == 1
                                              ? "Statistics"
                                              : "Settings"

    contentItem: ListView {
        implicitWidth: contentWidth
        implicitHeight: 56

        model: navBar.contentModel
        currentIndex: navBar.currentIndex

        spacing: navBar.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem

        }


    CTabButton {

        id: homeBtn
        text: "Home"

    }

    CTabButton {

        id: statsBtn
        text: "Statistics"
    }

    CTabButton {

        id: setttingsBtn
        text: "Settings"
    }

}

