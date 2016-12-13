//Ventana con lista de publicaciones ,con una url

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
            Pup{
                width: listView1.width
                height: 80
                nameDown: listView1.model[index].user.first_name +" "+listView1.model[index].user.last_name
                nameUp: listView1.model[index].objective.first_name +" "+listView1.model[index].objective.last_name
                points: Math.floor(Math.random() * (10 - 1)) + 1
                date:Math.floor(Math.random() * (28 - 1)) + 1+"/"+Math.floor(Math.random() * (12 - 10)) + 1+"/16"
                url:ajax.url+'/'+listView1.model[index].id
            }







        }

        Component.onCompleted:{ ajax.send();}

    }
    FloatBtn {
        id: floatBtn1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30
        onClicked: app.g_stackView.push('qrc:/PublicationForm.qml');
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
