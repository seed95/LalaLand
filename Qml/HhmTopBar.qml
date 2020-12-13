import QtQuick 2.0

Rectangle
{

    width: 980 * scale_width
    height: 50 * scale_height
    color: "#3d598b"

    HhmActionButton
    {
        id: action_new
        height: parent.height
        width: 100 * scale_width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf067"
        action: "New"
        onButtonClicked: root.newButtonClicked()
    }

    HhmActionButton
    {
        id: action_reply
        height: parent.height
        width: 100 * scale_width
        anchors.left: action_new.right
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf3e5"
        action: "Reply"
        onButtonClicked: root.replyButtonClicked()
    }

    HhmActionButton
    {
        id: action_forward
        height: parent.height
        width: 120 * scale_width
        anchors.left: action_reply.right
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf14d"
        action: "Forward"
    }

    HhmActionButton
    {
        id: action_delete
        height: parent.height
        width: 100 * scale_width
        anchors.left: action_forward.right
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf1f8"
        action: "Delete"
        onButtonClicked: root.deleteButtonClicked()
    }

    HhmActionButton
    {
        id: action_archive
        height: parent.height
        width: 120 * scale_width
        anchors.left: action_delete.right
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf187"
        action: "Archive"
        onButtonClicked: root.archiveButtonClicked()
    }

    HhmActionButton
    {
        id: action_scan
        height: parent.height
        width: 100 * scale_width
        anchors.left: action_archive.right
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf574"
        action: "Scan"
        onButtonClicked: root.scanButtonClicked()
    }

    HhmActionButton
    {
        id: action_send
        height: parent.height
        width: 100 * scale_width
        anchors.left: action_scan.right
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf1d8"
        action: "Send"
        onButtonClicked: root.sendButtonClicked()
    }

}
