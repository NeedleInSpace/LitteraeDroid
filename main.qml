import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.2
import StatisticsModule 1.0
import AppLogic 1.0
import "./CustomElements"



ApplicationWindow {

    id: mW
    visible: true

    height: Qt.platform.os === "windows" ? 800 : Screen.desktopAvailableHeight
    width: Qt.platform.os === "windows" ? 480 : Screen.desktopAvailableWidth
    property double dp: 1
    Material.primary: Material.Teal

    TextProcessor {

        id: processor
    }

    WSettings {

        id: settings
    }

    Utilities {

        id: util
    }   

    StatisticsModel {

        id: statistics
    }

    StackLayout {

        id: layout
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
