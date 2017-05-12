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
    width:imageWidth
    height: imageHeight

    readonly property int currentState : 0
    readonly property int nextState : 1

    property int firstViewState  :currentState
    property int secontViewState :nextState

    property bool enableAni: true

    Image {
        id: targetImage1
        width: imageWidth
        height: imageHeight
        fillMode:Image.PreserveAspectFit
    }

    Image {
        id: targetImage2
        width: imageWidth
        height: imageHeight
        fillMode:Image.PreserveAspectFit
    }

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
        initImage()
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
        }
    }

    function setNextImage(imgPath)
    {
        target1Ani.complete()
        target2Ani.complete()
        console.log("setNextImage(",imgPath,")")

        if (imgPath === "" || imgPath === undefined || imgPath === null )
        {
            console.log("dldyddn imgPath is NULL")
            if (firstViewState === currentState)
            {
                console.log("dldyddn firstViewState === currentState")
                console.log("default image path : " , defaultImagePath)
                nextImagePath = defaultImagePath
                targetImage1.source = nextImagePath
            }
            else
            {
                console.log("dldyddn firstViewState === nextState")
                console.log("default image path : " , defaultImagePath)
                nextImagePath = defaultImagePath
                targetImage2.source = nextImagePath
            }
        }
        else
        {
            console.log("dldyddn imgPath is valid")
            if (firstViewState === currentState)
            {
                console.log("dldyddn firstViewState === currentState")
                nextImagePath = imgPath
                targetImage1.source = nextImagePath
            }
            else
            {
                console.log("dldyddn firstViewState === nextState")
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
        console.log("animationTest() ===========")
        nameChanged()

        if (target1Ani.running)
        {
//            target1Ani.complete()
//            target1Ani.start()
        }
        else
        {
            target1Ani.start()
        }

        if (target2Ani.running)
        {
//            target2Ani.complete()
//            target2Ani.start()
        }
        else
        {
            target2Ani.start()
        }
    }
    PropertyAnimation{
        id: target1Ani
        target:getCurrentImage()
        properties: "opacity"
        from: 1
        to:0
        duration: 500

    }
    PropertyAnimation{
        id: target2Ani
        target:getNextImage()
        properties: "opacity"
        from: 0
        to:1
        duration: 500
        onStarted: {
            console.log("target 2 start")
        }
        onStopped: {
            console.log("target 2 stop")
        }

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
