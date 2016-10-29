import QtQuick 2.0
import "app.js" as Js
Item {
    ListView {
        id: listView1
        anchors.fill: parent


        delegate: Item {
            x: 5
            width: parent.width
            height: 40
            Row {
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
        Component.onCompleted: Js.ajax({
                                        url: app.g_baseUrl+"/publications",
                                        success: function(data){

                                            listView1.model=JSON.parse(data).publications

                                        }});

    }

}
