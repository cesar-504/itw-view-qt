//Registro de usuarios

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import my.qajax 0.6
Page{
    padding: 25

    title: "Registro"
    Flickable{
        anchors.fill: parent
        contentHeight: columnLayout1.height
        ScrollBar.vertical:  ScrollBar{

        }
        flickableDirection: Flickable.VerticalFlick
        ColumnLayout {
            id: columnLayout1
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top

            Label {
                id: label1
                text: qsTr("Nombre")
            }

            TextField {
                id: txtName
                text: qsTr("")
                Layout.fillWidth: true
            }

            Label {
                id: label2
                text: qsTr("Apellido")
            }

            TextField {
                id: txtLastName
                text: qsTr("")
                Layout.fillWidth: true
            }

            Label {
                id: label3
                text: qsTr("Correo")

            }

            TextField {
                id: txtEmail
                text: qsTr("")
                Layout.fillWidth: true
                validator: RegExpValidator{
                    regExp: /.+@.+\..+/

                }


            }

            Label {
                id: label4
                text: qsTr("Confirmacion correo ")
            }

            TextField {
                id: txtEmailConf
                text: qsTr("")
                Layout.fillWidth: true
                validator: RegExpValidator{
                    regExp: /.+@.+\..+/

                }
            }

            Label {
                visible: (txtEmail.text!=="" && !txtEmailConf.text!=="") &&  (!txtEmail.acceptableInput && !txtEmailConf.acceptableInput) && !txtEmail.focus && !txtEmailConf.focus
                id: label7
                text: qsTr("Debe ingresar un correo valido")
                color: "red"
            }
            Label {
                visible: (txtEmail.text!==txtEmailConf.text) && !txtEmail.focus && !txtEmailConf.focus
                id: label8
                text: qsTr("Los correos no son iguales")
                color: "red"
            }

            Label {
                id: label5
                text: qsTr("Contraseña")
            }

            TextField {
                id: txtPass
                text: qsTr("")
                echoMode: TextInput.Password
                Layout.fillWidth: true
            }

            Label {
                id: label6
                text: qsTr("Confirmación Contraseña")
            }


            TextField {
                id: txtPassConf
                text: qsTr("")
                echoMode: TextInput.Password
                Layout.fillWidth: true
            }
            Label {
                visible: (txtPass.length<6 && txtPassConf.length<6)&&(txtPass.length!==0 && txtPassConf!==0)&& !txtPass.focus && !txtPassConf.focus
                id: label9
                text: qsTr("La contraseña debe tener minimo 6 caracteres")
                color: "red"
            }
            Label {
                visible: (txtPass.text!==txtPassConf.text) && !txtPass.focus && !txtPassConf.focus
                id: label10
                text: qsTr("Las contraseñas no son iguales")
                color: "red"
            }
            Label {
                visible: ajaxReg.errorCode!==0
                id: labelError
                text: qsTr("Error al registrar intentelo mas tarde.\n Error: "+ajaxReg.errorCode)
                color: "red"
            }
            BusyIndicator{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                id:busyIndicator1
                running: false
            }



            RowLayout {
                id: rowLayout1
                width: 100
                height: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: false

                Button {
                    id: btnCancel
                    text: qsTr("Cancelar")
                    onClicked: app.g_stackView.pop
                }

                Button {
                    id: btnSend
                    text: qsTr("Enviar")
                    enabled: (txtEmail.acceptableInput && txtEmailConf.acceptableInput
                              && txtPass.length>=6 && txtPassConf.length>=6
                              && txtEmail.text===txtEmailConf.text && txtPass.text===txtPassConf.text)
                    onClicked: reg();
                }

            }



        }
    }
    QAjax{
        id:ajaxReg
        type: 'post'
        url: g_baseUrl+'users'
        onSuccess: {

            busyIndicator1.running= false
//            stackView.replace("qrc:/MsgScreen.qml" , {
//                                  text:"Registro exitoso",
//                                  buttonText: "Aceptar",
//                                  buttonOnClicked: function() {app.g_stackView.replace("qrc:/Login.qml")}

//                              });
            app.g_stackView.pop();

        }


        onError: {
            console.debug(code);
            console.debug(data);
            busyIndicator1.running= false;

        }

    }
    function reg(){
        ajaxReg.dataSent={
            "first_name":txtName.text,
            "last_name":txtLastName.text,
            "email":txtEmail.text,
            "email_confirmation":txtEmailConf.text,
            "password":txtPass.text,
            "password_confirmation":txtPassConf.text
        };
        busyIndicator1.running=true;
        ajaxReg.send();

    }
}
