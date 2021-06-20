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
    }

    HhmMessageNew
    {
        id: new_message
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "MessageNew"
        visible: root.hhm_mode===con.hhm_MESSAGE_MODE &&
                 messageState===con.hhm_MESSAGE_NEW_STATE

    }

}
