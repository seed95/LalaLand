import QtQuick 2.0

Rectangle
{
    property color backcolor_HomePage:
                           {
                                if( is_hovered )
                                {
                                    "#7083a8"
                                }
                                else
                                {
                                    "#586070"
                                }
                           }
    property color itemcolor_HomePage:
                               {
                                if( is_hovered )
                                {
                                    "#eff0f1"
                                }
                                else
                                {
                                    "#dadcde"
                                }
                               }

    property bool is_hovered: false
    property string iconProp: ""
    property string textProp: ""

    signal clickedBtn()

    width: 250
    height: 250
    color: backcolor_HomePage
    radius: 20

    Text
    {
        id: homePageBoxIcon
        text: iconProp
        color: itemcolor_HomePage
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -30
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: fontAwesomeSolid.name
        font.pixelSize: 60
    }

    Text
    {
        id: homePageBoxText
        text: textProp
        color: itemcolor_HomePage
        anchors.verticalCenter: homePageBoxIcon.verticalCenter
        anchors.verticalCenterOffset: 60
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 28
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
//        onClicked: clickedBtn();
        onEntered:
                 {
                   is_hovered = true;
                 }
        onExited:
                 {
                   is_hovered = false;
                 }
    }
}
