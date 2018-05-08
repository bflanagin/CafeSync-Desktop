import QtQuick 2.2
import QtQml 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

//import QtQuick.Controls 1.3


/*!
    \brief MainView with a Label and Button elements.
*/
import QtQuick.LocalStorage 2.0 as Sql
import "main.js" as Scripts
import "openseed.js" as OpenSeed



ListView {
    id:ms
    property string number: "0"
    property string list:""
    property bool fromRequest: false
    property string requestID: "0"


    z:0
    //width: parent.width * 0.25//- units.gu(.4)
   // height: parent.height //- units.gu(4.8)
    snapMode: GridView.SnapOneRow
    //flow: GridView.FlowLeftToRight
 //   flow:GridView.FlowTopToBottom
    boundsBehavior: Flickable.DragAndOvershootBounds
    orientation: Qt.Horizontal
   // flickableDirection: Flickable.VerticalFlick
    //pressDelay: 1000
    onDraggingVerticallyChanged: if (draggingVertically == true) {enabled = false}
   // highlightFollowsCurrentItem: true
    focus:true
    visible: true
    //cellHeight: units.gu(26)
    clip:true
    //cacheBuffer : 80
  //  cellHeight:parent.height //passerbyGrid.height
   // cellWidth: mainScreen.width

    //onStateChanged: Scripts.loadActions(list)
    onStateChanged: if(state == "Active") {} else {gc();}
    states: [
        State {
            name:"Active"
            PropertyChanges {
                target: ms
             //   visible:true
                x:if(hmode == false) {0} else {passerbyGrid.width}
            }

        },
        State {
          name:"InActive"
          PropertyChanges {
              target: ms
             // visible:false
              x:width+passerbyGrid.width
          }
        }
    ]

    transitions: [
        Transition {
            from: "InActive"
            to: "Active"
            reversible: true

            NumberAnimation {
                target: ms
                property: "x"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }


    ]

    delegate: Pages {
                    pindex: index
                }

    Rectangle {
        anchors.centerIn:pagedots
        width:pagedots.width * 1.2
        height:pagedots.height * 1.6
        radius: parent.height * 0.1
        color:Qt.rgba(0.1,0.1,0.1,0.4)
        visible: pagedots.visible
    }

    Row {
        id:pagedots
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.width * 0.02
        spacing: parent.width * 0.02
        visible: if(ms.count > 1) {true} else {false}
    Repeater {
            model:ms.count
            id:pageIndicator
            Rectangle {
                       width: ms.width * 0.044
                       height: ms.width * 0.044
                       border.width: 1
                       border.color:barColor
                       color: if(index == ms.indexAt(ms.contentX,0)) {highLightColor1} else {Qt.rgba(9,9,9,0);}
                       radius:width /2

                        MouseArea {
                            anchors.fill:parent
                            onClicked: ms.positionViewAtIndex(index,GridView.Center)
                        }
                   }

            }
    }





 }





