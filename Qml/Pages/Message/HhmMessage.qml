import QtQuick 2.0

Item
{

    property int messageState:  con.hhm_MESSAGE_NONE_STATE

    signal sendNewMessage(variant toData, variant ccData, string subject,
                          string content, variant attachFiles)

    HhmMessageAction
    {
        id: actions
        anchors.top: parent.top
        anchors.topMargin: -25
        anchors.left: parent.left
        objectName: "MessageAction"
        onSendMessageClicked: sendMessage()
    }

    HhmMessageNew
    {
        id: new_message
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "MessageNew"
        visible: messageState===con.hhm_MESSAGE_NEW_STATE
    }

    /*** Call this function from qml ***/

    function sendMessage()
    {
        if( new_message.getToData().length===0 )
        {
            console.log("please select that you want to send witch user")
        }
        else
        {
            sendNewMessage(new_message.getToData(),
                           new_message.getCcData(),
                           new_message.getSubject(),
                           new_message.getContent(),
                           new_message.getFiles())
        }
    }

    /*** Call this function from cpp ***/

    function successfullySend()
    {
        //Check if a message selected, state changed to hhm_MESSAGE_SHOW_STATE
        messageState = con.hhm_MESSAGE_NONE_STATE
    }

}
