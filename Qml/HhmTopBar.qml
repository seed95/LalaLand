import QtQuick 2.0

Rectangle
{

    width: 980
    height: childrenRect.height
    color: "#3d598b"

    HhmNews
    {
        id: news
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }

    Rectangle
    {
        width: parent.width
        height: 50
        anchors.left: parent.left
        anchors.top: news.bottom
        color: "transparent"

        //Top Bar for Content Email Page
        HhmActionButton
        {
            id: action_new
            height: parent.height
            width: 100
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            visible: !new_email.visible
            icon: "\uf067"
            action: "New"
            onButtonClicked: root.showPageNewEmail()
        }

        HhmActionButton
        {
            id: action_reply
            height: parent.height
            width: 100
            anchors.left: action_new.right
            anchors.verticalCenter: parent.verticalCenter
            visible: email_content.isActiveEmail()
            icon: "\uf3e5"
            action: "Reply"
            onButtonClicked: root.replyButtonClicked()
        }

        HhmActionButton
        {
            id: action_approve
            height: parent.height
            width: 120
            anchors.left: action_reply.right
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isAdmin() && email_content.isActiveEmail()
            icon: "\uf00c"
            action: "Approve"
            onButtonClicked:
            {
                root.approveButtonClicked(email_content.case_number)
                root.syncEmail()
            }
        }

        HhmActionButton
        {
            id: action_reject
            height: parent.height
            width: 100
            anchors.left: action_approve.right
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isAdmin() && email_content.isActiveEmail()
            icon: "\uf00d"
            action: "Reject"
            onButtonClicked:
            {
                root.rejectButtonClicked(email_content.case_number)
                root.syncEmail()
            }
        }

        HhmActionButton
        {
            id: action_archive
            height: parent.height
            width: 120
            anchors.left:
            {
                if(action_reject.visible)
                {
                    action_reject.right
                }
                else
                {
                    action_reply.right
                }

            }
            anchors.verticalCenter: parent.verticalCenter
            visible: email_content.isActiveEmail()
            icon: "\uf187"
            action: "Archive"
            onButtonClicked: root.archiveButtonClicked()
        }

        //Top Bar for New Email Page
        HhmActionButton
        {
            id: action_back
            height: parent.height
            width: 100
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            visible: new_email.visible
            icon: "\uf060"
            action: "Back"
            onButtonClicked: root.createNewEmail = false
        }

        HhmActionButton
        {
            id: action_scan
            height: parent.height
            width: 100
            anchors.left: action_back.right
            anchors.verticalCenter: parent.verticalCenter
            visible: new_email.visible
            icon: "\uf574"
            action: "Scan"
            onButtonClicked: root.scanButtonClicked()
        }

        HhmActionButton
        {
            id: action_send
            height: parent.height
            width: 100
            anchors.left: action_scan.right
            anchors.verticalCenter: parent.verticalCenter
            visible: new_email.visible
            icon: "\uf1d8"
            action: "Send"
            onButtonClicked: root.sendEmail()
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

}
