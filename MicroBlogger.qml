import QtQuick 2.8
import QtGraphicalEffects 1.0
import IO 1.0

import QtQuick.LocalStorage 2.0 as Sql

import "microblogger.js" as MicroBlog



Item {
    id:thisWindow
    anchors.fill:parent
    clip:true

    property int narrativeList: 0
    property var remotelog:[]
    property bool fupdate: false

    Component.onCompleted:{ MicroBlog.retrieve_log(currentcard_thecard,usercardNum);
                           // MicroBlog.show_log(currentcard_thecard);
                            if(currentcard_thecard != usercardNum) {
                           // remotelogGet.start();
                            } else {
                                MicroBlog.show_log(currentcard_thecard);
                            }
                               // MicroBlog.dump();
                            remotelogGet.start();
    }

    onFocusChanged: if(focus ==true) {console.log("I have focus");}

   Timer {
        id:remotelogGet
        interval: 60000
        repeat: true
        running: false
        onTriggered: { MicroBlog.retrieve_log(currentcard_thecard,usercardNum);
            // MicroBlog.show_log(currentcard_thecard);
             if(currentcard_thecard != usercardNum) {
           //  remotelogGet.start();
             } else {
                 MicroBlog.show_log(currentcard_thecard);
             }
                // MicroBlog.dump();
}
   }

   onFupdateChanged: if(fupdate == true) {
                        MicroBlog.retrieve_log(currentcard_thecard,usercardNum);
                                    // MicroBlog.show_log(currentcard_thecard);
                                     if(currentcard_thecard != usercardNum) {
                                   //  remotelogGet.start();
                                     } else {
                                         MicroBlog.show_log(currentcard_thecard);
                                     }
                                     fupdate = false;
                    }

    Rectangle {
        anchors.fill: parent
        color:backgroundColor
    }

    Item {
        visible: if(narrativeList > 1) {false} else {true}
        //anchors.centerIn: parent
        anchors.fill: parent
        Image {
            source:"./img/overlay.svg"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset:-thisWindow.width * 0.02
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            fillMode: Image.PreserveAspectFit
            opacity: 0.5

            Text {
                anchors.top: parent.bottom
                anchors.topMargin: thisWindow.width * 0.02
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("No Micro Blog Entries")

            }
        }

    }


 ListView {
     id:statlistView
     visible: if(narrativeList == 0) {false} else {true}
     anchors.horizontalCenter: parent.horizontalCenter
     anchors.bottom:parent.bottom
     width:if(hmode == false) {parent.width * 0.98} else {parent.width * 0.48}
     height:parent.height
     spacing: thisWindow.width * 0.05

     model:statlist

     delegate:  Item {
         id:microBlogPost
         width:parent.width
         height:logContent.height + thisWindow.width * 0.1
            clip:true
         Rectangle {
             anchors.horizontalCenter: parent.horizontalCenter
             width:parent.width * 0.98
             height:parent.height
             color: cardcolor
         }

         Column {
             id:logContent
             anchors.centerIn: parent
             width:parent.width * 0.98
             spacing: thisWindow.width * 0.015
             padding:5

             Item {
                 width: parent.width
                 height:thisWindow.width * 0.1
                 CirclePic {
                     id:pic
                     width: parent.height
                     height: parent.height
                     whichPic: card
                     where: listget
                   //  thesource:imgsource
                 }

             Text {
                 anchors.left: pic.right
                 anchors.verticalCenter: pic.verticalCenter
                text:who
                font.pixelSize: thisWindow.width * 0.06
                }
             }
             Text {
                 anchors.right:parent.right
                text:if(compname !="") {"Company: "+compname} else {""}
                font.pixelSize: thisWindow.width * 0.03

             }

             Rectangle {
                 width: parent.width
                 height: thisWindow.width * 0.007
                 color:seperatorColor1
             }

             Text {
                 width: parent.width * 0.98
                 padding:thisWindow.width * 0.01
                 horizontalAlignment: Text.AlignJustify
                 wrapMode: Text.WordWrap
                text:status
             }

             Text {
                 width: parent.width * 0.98
                 anchors.rightMargin: thisWindow.width * 0.01
                 anchors.right: parent.right
                 horizontalAlignment: Text.AlignRight
                text:date
                color:"gray"
             }

             Rectangle {
                 width: parent.width
                 height: thisWindow.width * 0.007
                 color:seperatorColor1
             }

             Actions {
                menu: 2
                backingColor: cardcolor
                width: parent.width
                height: thisWindow.width * 0.1
             }
         }


      }

 }



 ListModel {
     id:statlist

 }

}



