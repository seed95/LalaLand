import QtQuick 2.0

Item
{

    property int messageState:  con.hhm_MESSAGE_NONE_STATE

    HhmMessageAction
    {
        id: actions
        anchors.top: parent.top
        anchors.topMargin: -25
        anchors.left: parent.left
        objectName: "MessageAction"
        onSendMessageClicked: new_message.sendMessage()
    }

    HhmMessageNew
    {
        id: new_message
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "MessageNew"
        visible: messageState===con.hhm_MESSAGE_NEW_STATE
    }

    /*** Call this function from cpp ***/
    function successfullySend()
    {
        //Check if a message selected, state changed to hhm_MESSAGE_VIEW_STATE
        messageState = con.hhm_MESSAGE_NONE_STATE
    }

}
