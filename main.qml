import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0
import my.qajax 0.6




ApplicationWindow {
    id:app
    Material.accent:  "#429c57"
    property string g_baseUrl: "https://itwapp-cesargb504.c9users.io/"

    property string g_title: "itw"
    property string g_auth_token:""
    visible: true
    width: 400
    height: 600
    title: qsTr("itw app!")
    Settings{
        id:settings

        property bool firstTime: true
    }

    header: ToolBar{
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        id:topbar
        Material.primary:  "#429c57"
         Material.elevation: 1
        RowLayout {
                    anchors.fill: parent
                    ToolButton {
                        text: qsTr("‹")
                        font.bold: true
                        font.pointSize: 16
                        onClicked: stackView.pop()
                        enabled: stackView.depth>1

                    }
                    Label {
                        text: qsTr(app.g_title)
                        font.bold: true
                        font.pointSize: 16
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        Layout.fillWidth: true
                    }
                    ToolButton {
                        text: qsTr("⋮")
                        font.bold: true
                        font.pointSize: 16
                        onClicked: menu.open()
                        Menu{
                            id:menu
                            title: "Menu"
                            contentWidth: 0.1
                            topMargin: topbar.height
                            MenuItem {
                                        text: "Configuración"
                                    }
                                    MenuItem {
                                        text: "Acerca de..."
                                    }
                                    MenuItem {
                                        text: "Cerrar sesión"
                                        enabled: g_auth_token!=""
                                    }
                                    MenuItem {
                                        text: "Salir"
                                        onClicked: Qt.quit();
                                    }
                        }


                    }

                }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: AppView{}


    }

    Drawer {
            id: drawer
            width: 0.8 * app.width
            height: app.height
            Material.elevation: 6
            background:Rectangle {
                Rectangle {
                    Material.elevation: 6
                    x: parent.width - 5
                    width: 5
                    height: parent.height
                    color: "#429c57"
                }
            }

            Column{
                anchors.fill: parent
                ItemDelegate{
                    width: parent.width
                    text: qsTr("Menu")
                    background: Rectangle {


                        height: parent.height
                        color: "#429c57"

                    }

                }
                ItemDelegate{
                    width: parent.width
                    text: qsTr("Cesar Guerra")

                }
                ItemDelegate {
                    width: parent.width
                    text: qsTr("Configuración")

                }
                ItemDelegate {
                    width: parent.width
                    text: qsTr("Acerca de...")

                }
                ItemDelegate {
                    width: parent.width
                    text: "Salir"
                    onClicked: Qt.quit()
                }
            }




    }
//    Component.onCompleted: {
//        if(settings.firstTime){
//            console.log("primera vez")
//            stackView.replace("qrc:/MsgScreen.qml" , {
//                                  text:"Bienvenido a la aplicación",
//                                  buttonText: "Empieza",
//                                  buttonOnClicked: function() {stackView.push("qrc:/Login.qml")}
//                              });
//        }
//    }


}
