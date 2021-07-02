import QtQuick 2.0

Item
{
    id: container

    property int messageState:  con.hhm_MESSAGE_NONE_STATE
    property int sidebarState:      con.hhm_SIDEBAR_NONE_STATE

    HhmMessageAction
    {
        id: actions
        anchors.top: parent.top
        anchors.topMargin: -10
        anchors.left: parent.left
        objectName: "MessageAction"
        onSendMessageClicked: new_message.sendMessage()
    }

    HhmSideBar
    {
        id: sidebar
        anchors.top: actions.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        emailState: container.sidebarState
        objectName: "MessageSidebar"
    }

    HhmMessageNew
    {
        id: new_message
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "MessageNew"
        visible: container.messageState===con.hhm_MESSAGE_VIEW_STATE
    }

    HhmMessageView
    {
        id: view_message
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "MessageView"
        visible: container.messageState===con.hhm_MESSAGE_NEW_STATE
    }

    /*** Call this function from cpp ***/
    function successfullySend()
    {
        //Check if a message selected, state changed to hhm_MESSAGE_VIEW_STATE
        container.messageState = con.hhm_MESSAGE_NONE_STATE
    }

}
