import QtQuick 2.0

Rectangle
{   
    //Cpp Signals
    signal attachNewFile()

    //Qml Signals
    signal sendMessageClicked()
    signal newMessageClicked()

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
        icon: "\uf067"
        action: qsTr("انشاء")
        onButtonClicked:
        {
            newMessageClicked()
            messageState = con.hhm_MESSAGE_NEW_STATE
        }
    }

    //Acttion Box for Show State

    //Acttion Box for New State
    HhmActionBtn
    {
        id: action_back
        height: parent.height
        width: 100
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_NEW_STATE
        icon: "\uf061"
        action: qsTr("رجوع")
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
        anchors.right: action_back.left
        anchors.verticalCenter: parent.verticalCenter
        visible: messageState===con.hhm_MESSAGE_NEW_STATE
        icon: "\uf0c6"
        action: qsTr("مرفق")
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
        icon: "\uf1d8"
        action: qsTr("رسال")
        onButtonClicked: sendMessageClicked()
    }

}
