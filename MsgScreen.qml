import QtQuick 2.0
import QtQuick.Controls 2.0
Page{
    id: root
    property string text: ""
    property string buttonText: ""
    property var  buttonOnClicked: function(){}
    property alias  button1: button11
    signal btnClicked(real xPosition, real yPosition)
    Rectangle {
        id: rectangle1
        gradient: Gradient {
            GradientStop {
                position: 0.061
                color: "#ffffff"
            }

            GradientStop {
                position: 0.392
                color: "#dddddd"
            }

            GradientStop {
                position: 0.947
                color: "#42eba0"
            }
        }
        anchors.fill: parent

        Button {
            id: button11
            x: 270
            y: 213
            width: 99
            height: 53
            text: root.buttonText
            onClicked: {root.buttonOnClicked();root.btnClicked(mouse.x, mouse.y);}
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: text1
            x: 153
            y: 110
            color: "#222222"
            text: root.text
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 18
            font.family: "Verdana"
            horizontalAlignment: Text.AlignHCenter
        }
    }

}
