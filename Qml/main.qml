import QtQuick 2.10
import QtQuick.Window 2.10

Window
{
    id: root

    property real scale_width: width/1280
    property real scale_height: height/800

    property string r_email_sender_name: "Cassie Hicks" //Received email sender name
    property string r_email_title: "Launch this week" //Received email title
    property string r_email_date: "7:17PM" //Received email date

    property string s_new_email_username: "Admin"//Sender email username

    signal newButtonClicked()
    signal replyButtonClicked()
    signal forwardButtonClicked()
    signal deleteButtonClicked()
    signal archiveButtonClicked()
    signal scanButtonClicked()
    signal sendButtonClicked()
    signal syncButtonClicked()
    signal flagButtonClicked(int id)
    signal uploadFileClicked()

    visible: true
    width: 1280
    height: 800
    title: "Haeri HotMail"
    color: "#e6e6e6"

    //Fonts:
//    FontLoader
//    {
//        id: fontAwesomeSolid
//        source: "qrc:/Fonts/fa-solid.ttf"
//    }
    FontLoader
    {
        id: fontAwesomeSolid
        source: "qrc:/Fonts/fasolid.ttf"
    }
    FontLoader
    {
        id: fontAwesomeBrand
        source: "qrc:/Fonts/fa-brands-400.ttf"
    }

    FontLoader
    {
        id: fontRobotoMedium
        source: "qrc:/Fonts/Roboto-Medium.ttf"
    }
    FontLoader
    {
        id: fontRobotoRegular
        source: "qrc:/Fonts/Roboto-Regular.ttf"
    }
    FontLoader
    {
        id: fontRobotoLight
        source: "qrc:/Fonts/Roboto-Light.ttf"
    }

    HhmNews
    {
        id: news
        anchors.right: parent.right
        anchors.top: parent.top
    }

    HhmTopBar
    {
        id: topbar
        anchors.right: parent.right
        anchors.top: news.bottom
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
        id: email_content
        anchors.left: sidebar.right
        anchors.top: topbar.bottom
        anchors.right: parent.right
        anchors.bottom: bottombar.top
    }

    HhmNewEmail
    {
        id: new_email
        anchors.left: sidebar.right
        anchors.top: topbar.bottom
        anchors.right: parent.right
        anchors.bottom: bottombar.top
        visible: false
        text_from: s_new_email_username
    }

    HhmBottomBar
    {
        id: bottombar
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }


    function receivedNewEmail()
    {
        sidebar.receivedNewEmail()

    }

    function showNewEmail()
    {
        email_content.visible = false
        new_email.visible = true
        newButtonClicked()
    }

    function showEmailContent()
    {
        email_content.visible = true
        new_email.visible = false
    }

}
