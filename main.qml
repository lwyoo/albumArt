import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    width: 1000
    height: 480
    title: qsTr("Hello World")

    MyImage{
        id: testCode
    }

    Rectangle{
        x: 300
        y: 400
        width: 100
        height: 50
        color: "red"
        Label{
            anchors.centerIn: parent
            text: "set Default \nImage"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("ccc")
                testCode.setDefaultImage( "default.PNG")

            }
        }
    }
    Rectangle{
        x: 400
        y: 400
        width: 100
        height: 50
        color: "red"
        Label{
            anchors.centerIn: parent
            text: "Current \nImage 0"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                testCode.setCurrentImage("0.PNG")

            }
        }
    }
    Rectangle{
        x: 500
        y: 400
        width: 100
        height: 50
        color: "salmon"
        Label{
            anchors.centerIn: parent
            text: "Next \nImage 0"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("ccc")
                testCode.setNextImage("0.PNG")
            }
        }
    }
    Rectangle{
        x: 600
        y: 400
        width: 100
        height: 50
        color: "red"
        Label{
            anchors.centerIn: parent
            text: "Next \nImage 1"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                testCode.setNextImage("1.PNG")

            }
        }
    }
    Rectangle{
        x: 700
        y: 400
        width: 100
        height: 50
        color: "red"
        Label{
            anchors.centerIn: parent
            text: "Next \nImage 2"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                testCode.setNextImage("2.PNG")

            }
        }
    }
    Rectangle{
        x: 800
        y: 400
        width: 100
        height: 50
        color: "red"
        Label{
            anchors.centerIn: parent
            text: "Next \nImage empty"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                testCode.setNextImage()

            }
        }
    }

    Rectangle{
        id: dynamicScreen
        x: 400
        width:100
        height: 100
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Qt.createComponent()
                var newObject = Qt.createQmlObject('
import QtQuick 2.0;
Rectangle {
color: "red";
width: 20;
height: 20;
}',
                parent, "dynamicSnippet1");
                newObject.destroy(1000);
            }
        }
    }
}
