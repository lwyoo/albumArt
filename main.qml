import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true
    width: 1000
    height: 480
    title: qsTr("Hello World")


    //    Image{
    //        id: targetImage
    //        x:0
    //        source:"test.png"
    //        Component.onCompleted: {
    //            console.log("width: " , targetImage.width)
    //            console.log("height: " , targetImage.height)
    //        }
    //    }
    //    Image{
    //        id: targetImage2
    //        x:300
    //        source:"test.png"
    //        width: 200
    //        height: 200

    //    }
    //    Image{
    //        id: targetImage3
    //        x:600
    //        source:"test.png"
    //        width: 240
    //        height: 400
    //        fillMode:Image.PreserveAspectFit
    //    }
    MyImage{
        id: testCode
        //        defaultImagePath: "0.PNG"
        //        currentImagePath: "1.PNG"
        //        nextImagePath   : "1.PNG"
    }

    Rectangle{
        x: 300
        y: 400
        width: 100
        height: 50
        color: "red"
        Label{
            anchors.centerIn: parent
            text: "set Default Image"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("ccc")
                //                testCode.defaultImagePath = "0.PNG"
                testCode.initImage()
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
            text: "Current Image 0"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("ccc")
                //                testCode.defaultImagePath = "0.PNG"
                testCode.setCurrentImage("0.PNG")

            }
        }
    }
    Rectangle{
        x: 500
        y: 400
        width: 100
        height: 50
        color: "red"
        Label{
            anchors.centerIn: parent
            text: "Next Image 1"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("ccc")
                //                testCode.defaultImagePath = "0.PNG"
                testCode.setNextImage("1.PNG")
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
            text: "Next Image 0"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("ccc")
                //                testCode.defaultImagePath = "0.PNG"
                testCode.setNextImage("0.PNG")

            }
        }
    }
}
