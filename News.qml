import QtQuick 2.8
import QtGraphicalEffects 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.LocalStorage 2.0 as Sql

import "news.js" as News
import "markdown.js" as MD

Item {
    id:thisWindow

    property string thenews: ""
     property string date: ""



     Timer {
         id:newscheck
         interval: 1000
         running: true
         repeat: true
         onTriggered: {
             if(heart != "OffLine") {
                 News.get_news();
             }
         }
     }

    Rectangle {
        id:internalArea
        anchors.fill: parent
        color: backgroundColor
        border.color: "black"
        border.width: 1
        //visible: false

    Text {
        id: title
        text: qsTr("NEWS")
        font.pixelSize: thisWindow.width * 0.1
        anchors.left: parent.left
        anchors.leftMargin:thisWindow.width * 0.03
        anchors.top:parent.top
        anchors.topMargin: thisWindow.width * 0.01
    }

    Text {
        id: thedate
        text:date
        font.pixelSize: thisWindow.width * 0.04
        anchors.right: parent.right
        anchors.rightMargin:thisWindow.width * 0.03
        anchors.bottom:title.bottom
        anchors.bottomMargin: thisWindow.width * 0.01
    }

    Rectangle {
        width: parent.width
        height: thisWindow.width * 0.01
        color: seperatorColor1
        anchors.top:title.bottom
    }


    Flickable {
        anchors.top:title.bottom
        anchors.topMargin: thisWindow.width * 0.01
        anchors.bottom:okay.top
        width: parent.width
        contentHeight: news.height
        clip:true
        Text {
            id: news
            text: "<p>"+MD.md2html(thenews)+"</p>"
            width: thisWindow.width * 0.93
            padding: thisWindow.width * 0.02
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignLeft
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    Button {
        id:okay
        anchors.bottom: parent.bottom
        anchors.bottomMargin: thisWindow.width * 0.01
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.60
        height: thisWindow.width * 0.1
        text:"Okay"
        onClicked: News.dismiss_news(date)

        background: Rectangle {
                color:highLightColor1
                radius: thisWindow.width * 0.01
        }
    }

    }

    DropShadow {
           anchors.fill: internalArea
           horizontalOffset: 0
           verticalOffset: 4
           radius: 8.0
           samples: 17
           color: "#80000000"
           source: internalArea
       }

}
