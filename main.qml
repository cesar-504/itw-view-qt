import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

ApplicationWindow {
    id:app

    property string g_baseUrl: "https://itwapp-cesargb504.c9users.io"

    visible: true
    width: 400
    height: 600
    title: qsTr("Hello World")



    Login {
        id: login1
        anchors.fill: parent
    }

}