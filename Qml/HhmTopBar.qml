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
        anchors.left: parent.left
        anchors.leftMargin: 40 * scale_width
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf067"
        action: "New"
    }

    HhmActionButton
    {
        id: action_reply
        height: parent.height
        anchors.left: action_new.right
        anchors.leftMargin: 45 * scale_width
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf3e5"
        action: "Reply"
    }

    HhmActionButton
    {
        id: action_forward
        height: parent.height
        anchors.left: action_reply.right
        anchors.leftMargin: 45 * scale_width
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf14d"
        action: "Forward"
    }

    HhmActionButton
    {
        id: action_delete
        height: parent.height
        anchors.left: action_forward.right
        anchors.leftMargin: 45 * scale_width
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf1f8"
        action: "Delete"
    }

    HhmActionButton
    {
        id: action_archive
        height: parent.height
        anchors.left: action_delete.right
        anchors.leftMargin: 45 * scale_width
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf187"
        action: "Archive"
    }

    HhmActionButton
    {
        id: action_scan
        height: parent.height
        anchors.left: action_archive.right
        anchors.leftMargin: 45 * scale_width
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf574"
        action: "Scan"
    }

    HhmActionButton
    {
        id: action_send
        height: parent.height
        anchors.left: action_scan.right
        anchors.leftMargin: 45 * scale_width
        anchors.verticalCenter: parent.verticalCenter
        icon: "\uf1d8"
        action: "Send"
    }

}
