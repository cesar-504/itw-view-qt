import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0


Button {
    property real tam: 60.0
    width: tam
    height: tam
    Material.elevation: 6
    background: Rectangle{
        color: "#4caf50"
        radius: tam/2
    }
    contentItem: Text {
                id: text1
                text: qsTr("＋")
                font.pointSize: 32
                font.bold: true
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
}
