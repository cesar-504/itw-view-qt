import QtQuick 2.0
import QtQuick 2.6
import QtQuick.Controls 2.0

Page {
    id: page

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Login{}
        Publications{}
        Pane{
            Text {
                id: texto
                text: qsTr("texto")
            }
        }

    }

    header: TabBar {
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
