import QtQuick 2.6
import QtQuick.Controls 2.0
import "app.js" as Js
//bloque de publicacion
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
Pane{
    width: 300
    height: 100
    id:root
    property string nameUp
    property string nameDown
    property string date
    property int points: 1
    property string url

    Material.elevation: 3

        ColumnLayout {
            id: columnLayout1
            anchors.fill: parent

            RowLayout {
                id: rowLayout1
                Layout.fillHeight: true
                Layout.preferredWidth:parent.width

                Rectangle {
                    id: rectangle1

                    color: "#8BC34A"
                    radius: height/2
                    Layout.preferredWidth: height
                    Layout.fillHeight: true
                    Material.elevation: 3
                    Text {
                        id: text6
                        text: qsTr(nameUp.charAt(0).toUpperCase() )
                        style: Text.Normal
                        font.bold: true
                        font.pointSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.fill: parent
                    }

                }

                Text {
                    id: text1
                    text: nameUp.replace(/\b\w/g, function(l){ return l.toUpperCase() })
                    font.bold: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillHeight: true
                    font.pixelSize: 12
                }

                Text {
                    id: text4
                    text: points
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    font.pixelSize: 12
                }

                Text {
                    id: text5
                    color: "#10ea25"
                    text: qsTr("★")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillHeight: true
                    font.bold: true
                    font.pointSize: 16
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }
            }

            RowLayout {
                id: rowLayout2
                 Layout.preferredHeight: parent.height*.3

                Layout.preferredWidth:parent.width


                Text {
                    id: text2
                    color: "#51bb51"
                    text: date
                    horizontalAlignment: Text.AlignLeft
                    Layout.fillWidth: true
                    font.pixelSize: 12
                }

                Text {
                    id: text7
                    text: qsTr("Por:")
                    horizontalAlignment: Text.AlignRight
                    font.italic: true
                }

                Text {
                    id: text3
                    color: "#000000"
                    text: nameDown.replace(/\b\w/g, function(l){ return l.toUpperCase() })
                    Layout.minimumWidth: 64
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillWidth: false

                    Layout.fillHeight: true
                    font.pixelSize: 12
                }

            }
        }

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            onClicked: app.g_stackView.push("qrc:/PublicationDetails.qml" , {
                                                url:root.url,

                                            });
        }







}
