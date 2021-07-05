import QtQuick 2.0

Rectangle
{   
    //Cpp Signals
    signal attachNewFile()
    signal newMessageClicked()

    //Qml Signals
    signal sendMessageClicked()
    signal viewBackClicked()

    width: 980
    height: 50
    color: "#c8c8c8"

    //Acttion Box for None State
    HhmActionBtn
    {
        id: action_new
        height: parent.height
        width: 100
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_NONE_STATE
        icon_text: "\uf067"
        action_text: "انشاء"
        icon_left_margin: 6
        action_vertical_offset: -2
        action_left_margin: 2
        onButtonClicked:
        {
            newMessageClicked()
            messageState = con.hhm_MESSAGE_NEW_STATE
        }
    }

    //Acttion Box for View State
    HhmActionBtn
    {
        id: action_back1
        height: parent.height
        width: 100
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_VIEW_STATE
        icon_text: "\uf061"
        action_text: "رجوع"
        icon_left_margin: 3
        action_vertical_offset: -4
        action_left_margin: 0
        onButtonClicked:
        {
            viewBackClicked()
        }
    }

    HhmActionBtn
    {
        id: action_reply
        height: parent.height
        width: 80
        anchors.right: action_back1.left
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_VIEW_STATE
        icon_text: "\uf3e5"
        action_text: "الرد"
        action_left_margin: 0
        action_vertical_offset: -2
        icon_left_margin: 9
    }

    HhmActionBtn
    {
        id: action_forward
        height: parent.height
        width: 140
        anchors.right: action_reply.left
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_VIEW_STATE
        icon_text: "\uf356"
        action_text: "إلى الأمام"
        action_left_margin: 2
        action_vertical_offset: -2
        icon_left_margin: 7
    }

    //Acttion Box for New State
    HhmActionBtn
    {
        id: action_back2
        height: parent.height
        width: 100
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_NEW_STATE
        icon_text: "\uf061"
        action_text: "رجوع"
        icon_left_margin: 3
        action_vertical_offset: -4
        action_left_margin: 0
        onButtonClicked:
        {
            messageState = con.hhm_MESSAGE_NONE_STATE
        }
    }

    HhmActionBtn
    {
        id: action_attach
        height: parent.height
        width: 100
        anchors.right: action_back2.left
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_NEW_STATE
        icon_text: "\uf0c6"
        action_text: "مرفق"
        action_left_margin: 0
        action_vertical_offset: -2
        icon_left_margin: 7
        onButtonClicked: attachNewFile()
    }

    HhmActionBtn
    {
        id: action_send
        height: parent.height
        width: 100
        anchors.right: action_attach.left
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_NEW_STATE
        icon_text: "\uf1d8"
        action_text: "رسال"
        action_left_margin: 0
        action_vertical_offset: -1
        icon_left_margin: 5
        onButtonClicked: sendMessageClicked()
    }

}
