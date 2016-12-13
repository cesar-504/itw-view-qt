import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import my.qajax 0.6
Page{
    padding: 25
    id:root
    title: "Registro"

    property string url:"."
    property int  pubId:0
    QAjax{
        id:ajaxPub
        type: 'get'
        url: root.url
        onSuccess: {
            console.debug('obj');
            console.debug(ajaxPub.dataMap.publication.id)
            pubId=ajaxPub.dataMap.publication.id;
            ajaxGetResp.send();

        }
        onError: {
            console.debug(code);
            console.debug(data);
           app.g_busyIndicator.running= false;

        }
        Component.onCompleted: ajaxPub.send();

    }
    QAjax{
        id:ajaxGetResp
        type: 'get'
        url: g_baseUrl+'/answersp/?id='+pupId
        onSuccess: {
            console.debug('obj');
            console.debug(ajaxGetResp.dataMap.publication.id)


        }

        onError: {
            console.debug(code);
            console.debug(data);
           app.g_busyIndicator.running= false;

        }


    }
    QAjax{

        id:ajaxPostResp
        type: 'post'
        url: g_baseUrl+'/answers'
        onSuccess: {
            console.debug('obj');
            console.debug(ajaxGetResp.dataMap.publication.id)


        }

        onError: {
            console.debug(code);
            console.debug(data);
           app.g_busyIndicator.running= false;

        }


    }
    Pup {
        id: pup1
        width: parent.width
        height: 80
        nameDown: ajaxPub.dataMap.publication.user.first_name +" "+ajaxPub.dataMap.publication.user.last_name
        nameUp: ajaxPub.dataMap.publication.objective.first_name +" "+ajaxPub.dataMap.publication.objective.last_name
        points: Math.floor(Math.random() * (10 - 1)) + 1
        date:Math.floor(Math.random() * (28 - 1)) + 1+"/"+Math.floor(Math.random() * (12 - 10)) + 1+"/16"
    }
    ColumnLayout{
        id:columnPub
        anchors.top: pup1.bottom
        anchors.right: parent.right
        anchors.left: parent.left

        Label {
            id: label1
            text: ajaxPub.dataMap.publication.title

            font.bold: true
            font.pointSize: 13
            Layout.fillWidth: true
        }
        Label {
            id: label2
            text: ajaxPub.dataMap.publication.content
            Layout.fillWidth: true
        }
        Label {
            id: label3
            text: 'Publica tu respuesta:'
            Layout.fillWidth: true
        }
        Label{
            text: 'ubicacion'
        }

        TextField{
            id:txtUbi
             Layout.fillWidth: true

        }
        Label{
            text: 'respuesta'
        }

        TextField{
            id:txtResp
             Layout.fillWidth: true

        }
        Button{
            Layout.fillWidth: true
            text: 'Enviar'
            onClicked: {
                ajaxPostResp.dataSent={
                    "location":txtUbi.text,
                    "answer":txtResp.text,
                    "publication_id":pubId
                }
                ajaxPostResp.send();

            }
        }

    }
    Flickable{

        anchors.bottom: parent.bottom
        anchors.top: columnPub.bottom
        contentHeight: 900
        flickableDirection: Flickable.VerticalFlick
        ListView{
            id:listView1

            model: [1,2,3,4,5]

            anchors.top: columnPub.bottom
            delegate: Component{
                ColumnLayout{
                    Label{
                        text: 'listView1.model[index].location'
                    }
                    Label{
                        text:'listView1.model[index].answer'
                    }
                }
            }
    }


    }



}
