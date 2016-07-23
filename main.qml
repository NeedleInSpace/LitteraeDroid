import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import "./CustomElements"



ApplicationWindow {

    id: mW
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    StackLayout {

        anchors.fill: parent
        currentIndex: navBar.currentIndex

        MainMenu {

        }
        StatisticsTab {

        }
        SettingsTab {

        }

    }

    footer: BottomNavBar {

        id: navBar
    }
    header: AppBar {

        id: appBar
        title: navBar.currBar
    }

}
