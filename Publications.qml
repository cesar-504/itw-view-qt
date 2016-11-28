import QtQuick 2.0
import QtQuick.Controls 2.0
import "app.js" as Js
import my.qajax 0.6
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
Item {
    id:root
    property string url: app.g_baseUrl+"publications"
    QAjax{
        id:ajax
        url:root.url
        onSuccess: (!ajax.dataMap.publications)?msgScreen.visible=true:msgScreen.visible=false
        authorization: app.g_auth_token

    }



    ListView {
        id: listView1
        anchors.topMargin: 10
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.fill: parent
        model : ajax.dataMap.publications

        spacing:10
        delegate:Component{
            Pane{
                width: parent.width
                height: 80

                Material.elevation: 4
                ColumnLayout {
                    anchors.fill: parent
                    id: row1
                    spacing: 1

                    Text {
                        text: listView1.model[index].user.first_name +" "+listView1.model[index].user.last_name

                        font.bold: true
                    }
                    Text {
                        text:"Busca a: "+ listView1.model[index].objective.first_name +" "+listView1.model[index].objective.last_name

                        font.bold: true
                    }

                }
            }





        }

        Component.onCompleted:{ ajax.send();}

    }



    MsgScreen{
        id:msgScreen
        anchors.fill: parent
        visible: false
        text:"Nada por aqui..."
        buttonText: "Recargar"
        buttonOnClicked: function() {ajax.send()}
    }
    MsgScreen{
        id:errorScreen
        visible: ajax.errorCode!==0
        anchors.fill: parent
        text:"Algo salio mal\nError: "+ajax.errorCode
        buttonText: "Recargar"
        buttonOnClicked: function() {ajax.send()}
    }


}
