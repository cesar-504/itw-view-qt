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
                text: qsTr("Descripción")

            }

            TextField {
                id: txtDesc
                text: qsTr("")
                Layout.fillWidth: true



            }
            Label {
                id: label22
                text: qsTr("Titulo de publicación")
            }

            TextField {
                id: txtPup
                text: qsTr("")
                Layout.fillWidth: true
            }
            Label {
                id: label33
                text: qsTr("Contenido de publicación")

            }

            TextField {
                id: txtCont
                text: qsTr("")
                Layout.fillWidth: true
            }
            QAjax{
                id:ajaxReg
                type: 'post'
                url: g_baseUrl+'users'
                onSuccess: {

                    busyIndicator1.running= false
                    stackView.replace("qrc:/MsgScreen.qml" , {
                                          text:"Registro exitoso",
                                          buttonText: "Aceptar",
                                          buttonOnClicked: function() {app.g_stackView.replace("qrc:/Login.qml")}
                                      });

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
    }
}
