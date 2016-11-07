import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import my.qajax 0.5



ApplicationWindow {
    id:app
    Material.accent: Material.Green
    property string g_baseUrl: "https://itwapp-cesargb504.c9users.io/"

    visible: true
    width: 400
    height: 600
    title: qsTr("itw app!")

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: AppView{}
    }

}
