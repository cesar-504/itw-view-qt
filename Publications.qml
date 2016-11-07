import QtQuick 2.0
import "app.js" as Js
import my.qajax 0.5

Item {
    QAjax{
        id:ajax
        url:app.g_baseUrl+"publications"

    }

    ListView {
        id: listView1
        anchors.fill: parent
        model : ajax.dataMap.publications

        delegate:Component{


            Row {
                width: parent.width
                height: 40
                id: row1
                spacing: 10

                Text {
                    text: listView1.model[index].title
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
                Text {
                    text: listView1.model[index].created_at
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }

            }
        }

        Component.onCompleted:{ ajax.ajax();}

    }

}
