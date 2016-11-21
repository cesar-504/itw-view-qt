import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

Page {
    id: page

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Publications{}

    }

    header: TabBar {
        Material.accent: "#429c57"

        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: "Mis busquedas"
        }
        TabButton {
            text: "Publicaciones"
        }
        TabButton {
            text: "Top"
        }
    }
}
