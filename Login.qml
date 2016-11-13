import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import my.qajax 0.5

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
            id: txtUser
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
            id: txtPass
            width: 242
            height: 40
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 11
            echoMode: TextInput.Password

        }



        Button {
            id: btnLogin
            height: 44
            text: qsTr("Iniciar")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: authenticate(txtUser.text,txtPass.text)

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


    }

    QAjax{
        id:ajaxLogin
        type: 'post'
        url: g_baseUrl+'authenticate'
        onSuccess: {
            console.debug(data);
            g_auth_token=ajaxLogin.dataMap.auth_token
        }
        onError: {
            console.debug(code);
            console.debug(data);


        }
    }

    function authenticate(user,pass){
        ajaxLogin.dataSent={"email":user,"password":pass};
        ajaxLogin.send();
    }





}
