import QtQuick 2.10
import QtQuick.Window 2.10

Window
{
    id: root

    property real scale_width: width/1280
    property real scale_height: height/800

    visible: true
    width: 1280
    height: 800
    title: "Haeri HotMail"
    color: "#e6e6e6"

    //Fonts:
    FontLoader
    {
        id: fontAwesomeSolid
        source: "qrc:Resources/Fonts/Font Awesome 5 Free Solid.ttf"
    }
    FontLoader
    {
        id: fontRobotoMedium
        source: "qrc:Resources/Fonts/Roboto-Medium.ttf"
    }
    FontLoader
    {
        id: fontRobotoRegular
        source: "qrc:Resources/Fonts/Roboto-Regular.ttf"
    }

    HhmTopBar
    {
        id: topbar
        anchors.right: parent.right
        anchors.top: parent.top
    }

    HhmSideBar
    {
        id: sidebar
        width: 300 * scale_width
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
    }

    HhmEmailContent
    {
        anchors.left: sidebar.right
        anchors.top: topbar.bottom
        anchors.right: parent.right
        anchors.bottom: bottombar.top
    }

    HhmBottomBar
    {
        id: bottombar
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

}
