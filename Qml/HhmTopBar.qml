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
        visible: email_content.visible
        icon: "\uf067"
        action: "New"
        onButtonClicked: root.showNewEmail()
    }

    HhmActionButton
    {
        id: action_back
        height: parent.height
        width: 100 * scale_width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: new_email.visible
        icon: "\uf104"
        action: "Back"
        onButtonClicked: root.showEmailContent()
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
        visible: new_email.visible
        icon: "\uf1d8"
        action: "Send"
        onButtonClicked: root.sendButtonClicked(new_email.getCaseNumber(), new_email.getSubject())
    }

    Text
    {
        id: department
        text: "Iraq Department of Justice"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 16
        anchors.topMargin: 5
        color: "#c8c8c8"
        font.family: fontRobotoMedium.name
        font.weight: Font.Medium
        font.pixelSize: 15
    }

    Text
    {
        id: office
        text: "Office of Legislative Affairs"
        anchors.right: parent.right
        anchors.top: department.bottom
        anchors.rightMargin: 16
        color: "#c8c8c8"
        font.family: fontRobotoLight.name
        font.weight: Font.Light
        font.pixelSize: 11
    }

}
