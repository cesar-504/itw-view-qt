import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import "app.js" as Js
Item {
    id: item1
    width: 400
    height: 600

    ColumnLayout {
        id: columnLayout1
        height: 390
        anchors.top: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.topMargin: -512


        Label {
            id: label1
            width: 74
            height: 23
            text: qsTr("Correo")


        }


        TextField {
            id: textField1
            width: 242
            height: 40
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 11
            placeholderText: "mail@mail.com"

        }






        Label {
            id: label2
            width: 74
            height: 23
            text: qsTr("Contraseña")


        }

        TextField {
            id: textField2
            width: 242
            height: 40
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 11
            echoMode: TextInput.Password

        }



        Button {
            id: button1
            height: 44
            text: qsTr("Iniciar")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


        }

        Switch {
            id: switch1
            width: 174
            height: 40
            text: qsTr("Guardar datos")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: false

        }

        BusyIndicator {
            id: busyIndicator1
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: false
        }
    }

    Text {
        id: text1
        x: 95
        y: 501
        width: 198
        height: 53
        text: "asd"
        font.pixelSize: 19
        Component.onCompleted: Js.ajax({
                                        url: app.g_baseUrl+"/publications",
                                        success: function(data){console.log(JSON.parse(data).publications[0].title)}
                                       });

    }





}
