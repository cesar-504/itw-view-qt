import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id:root
    signal reloadPresed()
    function show(){
        root.anchors.fill=parent
        root.visible=true
    }
    function hide(){

        root.visible=false
    }
    visible: false
    Rectangle {
        id: rectangle1
        color: "#d8f1dc"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Text {
            id: text1
            x: 192
            y: 99
            width: 246
            height: 17
            text: qsTr("Algo salio mal")
            font.bold: true
            font.pointSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Button {
            id: button1
            x: 270
            y: 220
            text: qsTr("Recargar")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            onPressed: {root.reloadPresed();hide()}
        }
    }

}
