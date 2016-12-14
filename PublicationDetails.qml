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
            console.debug(ajaxPub.dataMap)
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
        url: g_baseUrl+'answersp'
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
        url: g_baseUrl+'answers'
        onSuccess: {
            console.debug('obj');
            ajaxGetResp.send();


        }

        onError: {
            console.debug(code);
            console.debug(data);
            app.g_busyIndicator.running= false;

        }


    }

    Flickable{
        anchors.fill: parent
        contentHeight: 800
        flickableDirection: Flickable.VerticalFlick
        ScrollBar.vertical:  ScrollBar{

        }
        ColumnLayout{
            anchors.fill: parent

            Pup {
                id: pup1
                anchors.right: parent.right
                anchors.left: parent.left

                Layout.preferredHeight: 80
                nameDown: ajaxPub.dataMap.publication.user.first_name +" "+ajaxPub.dataMap.publication.user.last_name
                nameUp: ajaxPub.dataMap.publication.objective.first_name +" "+ajaxPub.dataMap.publication.objective.last_name
                points: Math.floor(Math.random() * (10 - 1)) + 1
                date:Math.floor(Math.random() * (28 - 1)) + 1+"/"+Math.floor(Math.random() * (12 - 10)) + 1+"/16"
            }
            ColumnLayout{
                id:columnPub


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
                            "publication_id":pubId,
                            "user_id":app.g_currentUser.id
                        }
                        ajaxPostResp.send();

                    }
                }

            }
            property var listRespModel: []
            ListView{
                Layout.preferredHeight: 300
                id:listResp
                spacing: 3
                model: ajaxGetResp.dataMap.answers
                delegate:Component{
                    Rectangle {
                        id: rectangle1
                        width: columnPub.width

                        height: 60
                        color: "#d0eac6"
                        radius: 12
                        ColumnLayout{
                            Text {


                               text: listResp.model[index].user.first_name+" "+listResp.model[index].user.last_name
                               font.bold: true
                               Component.onCompleted: console.debug(text)
                            }
                            Text {


                               text: listResp.model[index].location
                               font.bold: true
                               Component.onCompleted: console.debug(text)
                            }
                            Text {


                               text: listResp.model[index].answer
                               font.bold: true
                               Component.onCompleted: console.debug(text)
                            }
                        }

                    }

                }


            }

        }




    }






}
