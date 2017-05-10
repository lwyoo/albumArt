import QtQuick 2.0

//album art
/*
  현재 보여지고 있는 이미지가 있고 (CurrentImage  OR  DefaultImage)
  다음 이미지를 입력 받으면 (NextImage) 둘사이 애니메이션 효과를 이용해서
  이미지 변환 시키는것
  */

Item {
    //이미지 레이어 만들고
    //해당 레이어에 맞게 이미지를 넣을수 있도록 하자
    //image Control
    property string defaultImagePath    : ""
    property string currentImagePath    : ""
    property string nextImagePath       : ""
    property real imageWidth    :200
    property real imageHeight   :200


    readonly property int currentState : 0
    readonly property int nextState : 1

    property int firstViewState  :currentState
    property int secontViewState :nextState

    //animation Control
    property bool enableAni: true

    Image {
        id: targetImage1
        width: imageWidth
        height: imageHeight
        opacity: 1
        //        source: currentImagePath

        fillMode:Image.PreserveAspectFit
    }

    Image {
        id: targetImage2
        width: imageWidth
        height: imageHeight
        opacity: 0
        //        source: nextImagePath
        fillMode:Image.PreserveAspectFit
    }

//    Image {
//        id: defaultImage
//        width: imageWidth
//        height: imageHeight
//        //        source: defaultImagePath
//        fillMode:Image.PreserveAspectFit
//    }

    Image {
        id: validCheckImage
        source: ""
        visible: false
        onStatusChanged:
        {
            if (status === Image.Null)
            {
                console.log("image status check Null")
            }
            else if (status === Image.Ready)
            {
                console.log("image status check Ready")
            }
            else if (status === Image.Loading )
            {
                console.log("image status check Loading")
            }
            else if (status === Image.Error )
            {
                console.log("image status check Error")
            }

        }
    }

    function setDefaultImage(imgPath)
    {
        if (imgPath === null )
        {
            console.log("defaultImagePat is NULL")
        }

        if (imgPath === undefined)
        {
            console.log("defaultImagePat is undefined")
        }

        if (imgPath === "")
        {
            console.log("default image is not found")

        }
        else
        {
            if (isImagePathEnable(imgPath))
            {
                if (firstViewState === currentState)
                {
                    currentImagePath = imgPath
                    targetImage1.source = currentImagePath
                }
                else
                {
                    currentImagePath = imgPath
                    targetImage2.source = currentImagePath
                }
            }
            else
            {
                console.log("error")
            }
        }
    }

    function setCurrentImage(imgPath)
    {
        console.log("setCurrentImage(" , imgPath , ")")
        initImage()


        if ( true === isImagePathEnable(imgPath) )
        {
            if (firstViewState === currentState)
            {
                currentImagePath = imgPath
                targetImage1.source = currentImagePath
            }
            else
            {
                currentImagePath = imgPath
                targetImage2.source = currentImagePath
            }
        }
        else
        {
            /*
            현재 이미지가 없고
            , 화면에 보여주고 있는 이미지가 defaultImage 이면
            , 입력 받은 이미지가 유효 하면
            , 해당 이미지로 변경
            */
            if (firstViewState === currentState)
            {
                //1번째 image 가 current 이면
                currentImagePath = defaultImagePath
                targetImage1.source = currentImagePath
            }
            else
            {
                currentImagePath = defaultImagePath
                targetImage2.source = currentImagePath
            }

//            initNextImage()

        }
    }

    function setNextImage(imgPath)
    {
        console.log("setNextImage(",imgPath,")")
        if (imgPath === null )
        {
            console.log("setNextImage is NULL")
        }

        if (imgPath === undefined)
        {
            console.log("setNextImage is undefined")
        }

        if (imgPath === "" || imgPath === undefined || imgPath === null )
        {
            if (firstViewState === currentState)
            {
                //1번째 image 가 current 이면
                nextImagePath = defaultImagePath
                targetImage1.source = nextImagePath
            }
            else
            {
                nextImagePath = defaultImagePath
                targetImage2.source = nextImagePath
            }
        }
        else
        {
            if (firstViewState === currentState)
            {
                //1번째 image 가 current 이면
                nextImagePath = imgPath
                targetImage1.source = nextImagePath
            }
            else
            {
                nextImagePath = imgPath
                targetImage2.source = nextImagePath
            }
        }
        //start animation

        //effect!!

        //opacity

        animationTest()
//        nameChanged()
    }
    function animationTest()
    {
        //        first -> secont
        //        testTimer.running = true
        nameChanged()
        target1Ani.start()
        target2Ani.start()

    }

    //    Timer
    //    {
    //        id: testTimer
    //        interval: 100
    //        running : false
    //        repeat: true
    //        onTriggered:{


    //            if ( firstViewState === currentState)
    //            {
    //                targetImage1.opacity -= 0.1
    //                targetImage2.opacity += 0.1
    //                if (targetImage1.opacity < 0)
    //                {
    //                    stop()
    //                    console.log("timer end")
    //                }

    //            }
    //            else
    //            {
    //                targetImage1.opacity += 0.1
    //                targetImage2.opacity -= 0.1
    //                if (targetImage2.opacity < 0)
    //                {
    //                    stop()
    //                    console.log("timer end")
    //                }
    //            }
    //        }
    //    }
    PropertyAnimation{
        id: target1Ani
        target:getCurrentImage()
        properties: "opacity"
        from: 1
        to:0
        duration: 2000
    }
    PropertyAnimation{
        id: target2Ani
        target:getNextImage()
        properties: "opacity"
        from: 0
        to:1
        duration: 2000
    }


    function isImagePathEnable(imgPath)
    {
        //이미지가 있는지 확인 하는 용도
        //이미지를 넣고 해당 상태를 봐서 가능한지 판단 하는것

        if (imgPath === null)
        {
            console.log("imgPath is NULL")
            return false
        }
        if (imgPath === undefined)
        {
            console.log("imgPath is UnDefined")
            return false
        }


        validCheckImage.source = imgPath
        if (validCheckImage.status === Image.Error)
        {
            console.log("imagePath is Error")
            return false
        }
        else
        {
            console.log("imagePath is Enable")
            return true
        }

    }

    function nameChanged()
    {
        console.log("nameChanged() start")
        if ( firstViewState === currentState)
        {
            console.log("nameChanged() firstViewState === currentState")
            firstViewState  = nextState
            secontViewState = currentState
        }
        else
        {
            console.log("nameChanged() secondViewState === currentState")
            firstViewState  = currentState
            secontViewState = nextState
        }
        console.log("nameChanged() end")

    }

    function initNextImage()
    {
        console.log("initNextImage()")
        nextImagePath = ""
        if (firstViewState === currentState)
        {
            targetImage2.source = nextImagePath
        }
        else
        {
            targetImage1.source = nextImagePath
        }
    }
    function initImage()
    {
        defaultImagePath = ""
        currentImagePath = ""
        nextImagePath = ""
        targetImage1.opacity = 1
        targetImage2.opacity = 1
        firstViewState  = currentState
        secontViewState = nextState
    }

    function getCurrentImage()
    {
        if (firstViewState === currentState)
        {
            return targetImage1
        }
        else
        {
            return targetImage2
        }
    }

    function getNextImage()
    {
        if (firstViewState === nextState)
        {
            return targetImage1
        }
        else
        {
            return targetImage2
        }
    }
}
