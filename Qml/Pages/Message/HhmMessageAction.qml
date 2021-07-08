import QtQuick 2.0

Rectangle
{
    id: container

    property int message_state: con.hhm_MESSAGE_NONE_STATE

    //Cpp Signals
    signal attachNewFile()
    signal newMessageClicked()//Qml,Cpp Signals

    //Qml Signals
    signal sendMessageClicked()
    signal viewBackClicked()
    signal replyClicked()
    signal newBackClicked()

    width: 980
    height: 50
    color: "#c8c8c8"

    //Acttion Box for None State
    Item
    {
        id: none_actions
        anchors.fill: parent
        visible: container.message_state===con.hhm_MESSAGE_NONE_STATE

        HhmActionBtn
        {
            id: action_new
            height: parent.height
            width: 100
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            icon_text: "\uf067"
            action_text: "انشاء"
            icon_left_margin: 6
            action_vertical_offset: -2
            action_left_margin: 2

            onButtonClicked:
            {
                newMessageClicked()
            }

        }
    }

    //Acttion Box for View State
    Item
    {
        id: view_actions
        anchors.fill: parent
        visible: container.message_state===con.hhm_MESSAGE_VIEW_STATE

        HhmActionBtn
        {
            id: action_back1
            height: parent.height
            width: 100
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
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
            icon_text: "\uf3e5"
            action_text: "الرد"
            action_left_margin: 0
            action_vertical_offset: -2
            icon_left_margin: 9

            onButtonClicked:
            {
                replyClicked()
            }

        }

        HhmActionBtn
        {
            id: action_forward
            height: parent.height
            width: 140
            anchors.right: action_reply.left
            anchors.verticalCenter: parent.verticalCenter
            icon_text: "\uf356"
            action_text: "إلى الأمام"
            action_left_margin: 2
            action_vertical_offset: -2
            icon_left_margin: 7
        }

    }

    //Acttion Box for New State
    Item
    {
        id: new_actions
        anchors.fill: parent
        visible: container.message_state===con.hhm_MESSAGE_NEW_STATE ||
                 container.message_state===con.hhm_MESSAGE_REPLY_STATE

        HhmActionBtn
        {
            id: action_back2
            height: parent.height
            width: 100
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            icon_text: "\uf061"
            action_text: "رجوع"
            icon_left_margin: 3
            action_vertical_offset: -4
            action_left_margin: 0

            onButtonClicked:
            {
                newBackClicked()
            }

        }

        HhmActionBtn
        {
            id: action_attach
            height: parent.height
            width: 100
            anchors.right: action_back2.left
            anchors.verticalCenter: parent.verticalCenter
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
            icon_text: "\uf1d8"
            action_text: "رسال"
            action_left_margin: 0
            action_vertical_offset: -1
            icon_left_margin: 5

            onButtonClicked: sendMessageClicked()
        }

    }

}
