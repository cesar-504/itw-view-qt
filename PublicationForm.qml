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
                    enabled: txtCont.text&&txtDesc.text&&txtLastName.text&&txtName.text&&txtPup
                    onClicked: obj();
                }
            }


        }
    }
    QAjax{
        id:ajaxObj
        type: 'post'
        url: g_baseUrl+'objectives'
        onSuccess: {
            console.debug('obj');
                console.debug(ajaxObj.dataMap.objective.id)

            pup(ajaxObj.dataMap.objective);
        }
        onError: {
            console.debug(code);
            console.debug(data);
           app.g_busyIndicator.running= false;

        }

    }
    QAjax{
        id:ajaxPup
        type: 'post'
        url: g_baseUrl+'publications'
        onSuccess: {

            app.g_busyIndicator.running= false
            app.g_stackView.pop;

        }
        onError: {
            console.debug(code);
            console.debug(data);
            app.g_busyIndicator.running= false;

        }

    }
    function obj(){
        ajaxObj.dataSent={
            "first_name":txtName.text,
            "last_name":txtLastName.text,
            "description":txtDesc.text,

        };
        app.g_busyIndicator.running=true;
        ajaxObj.send();

    }
    function pup(objData){
        ajaxPup.dataSent={
            "title":txtPup.text,
            "content":txtCont.text,
            "user_id":app.g_currentUser.id,
            "objective_id":objData.id,

        };
        ajaxPup.send();

    }
}
