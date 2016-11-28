import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import my.qajax 0.6

Item {
    id: item1


    Flickable{
        id: flickable1
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 25
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        contentHeight: columnLayout1.height
        ScrollBar.vertical:  ScrollBar{

        }

        ColumnLayout {
            id: columnLayout1
            height: 390
            anchors.horizontalCenter: parent.horizontalCenter



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
                selectByMouse: true
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
                selectByMouse: true

            }



            Button {
                id: btnLogin
                width: 89
                height: 44
                text: qsTr("Iniciar")
                Layout.preferredWidth: 150
                Layout.fillWidth: false
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                onClicked: authenticate(txtUser.text,txtPass.text)

            }

            Switch {
                id: switch1
                width: 200
                height: 40
                text: qsTr("Recuerdame")
                transformOrigin: Item.Center
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


            }

            BusyIndicator {
                id: busyIndicator1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: false
                running: false
            }

            Text {
                id: text1
                text: qsTr("¿Aun no tienes cuenta?")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                font.pointSize: 11
            }

            Button {
                id: btnReg
                width: 97
                height: 50
                text: qsTr("Registrate")
                Layout.preferredWidth: 300
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                onClicked: app.g_stackView.push("qrc:/RegistrationForm.qml")
            }

        }
    }

    QAjax{
        id:ajaxLogin
        type: 'post'
        url: g_baseUrl+'authenticate'
        onSuccess: {
            console.debug(data);
            g_auth_token=ajaxLogin.dataMap.auth_token
            busyIndicator1.running= false
            app.g_stackView.replace("qrc:/AppView.qml")

        }
        onError: {
            console.debug(code);
            console.debug(data);
            busyIndicator1.running= false;
            errorPop.text="error #"+code+ "\nVerifique y vuelva a intentar";
            errorPop.open();

        }

    }
    Popup{
        id:errorPop
        property alias text: popText.text
        x: 100
        y: 100
        width: 200
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        Text {
            id: popText
            text: ""
        }
    }



    function authenticate(user,pass){
        ajaxLogin.dataSent={"email":user,"password":pass};
        ajaxLogin.send();
        busyIndicator1.running=true;
    }





}
