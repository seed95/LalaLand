import QtQuick 2.0

Rectangle
{

    color: "#3d598b"

    Item
    {
        id: rtl_action_box
        anchors.fill: parent
        anchors.left: parent.left
        anchors.top: parent.top
        visible: root.rtl

        //Top Bar for Content Email Page
        HhmActionButton
        {
            id: action_new_rtl
            height: parent.height
            width: 100
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            visible: !root.createNewEmail
            icon: "\uf067"
            action: qsTr("جدید")
            onButtonClicked: root.showPageNewEmail()
        }

        HhmActionButton
        {
            id: action_reply_rtl
            height: parent.height
            width: 100
            anchors.right: action_new_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: email_content_rtl.isActiveEmail() && !root.createNewEmail
            icon: "\uf3e5"
            action: qsTr("پاسخ")
            onButtonClicked: root.replyButtonClicked()
        }

        HhmActionButton
        {
            id: action_approve_rtl
            height: parent.height
            width: 120
            anchors.right: action_reply_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isAdmin() && email_content_rtl.isActiveEmail() && !root.createNewEmail
            icon: "\uf00c"
            action: qsTr("تایید")
            onButtonClicked:
            {
                root.approveButtonClicked(email_content_rtl.case_number)
                root.syncEmail()
            }
        }

        HhmActionButton
        {
            id: action_reject_rtl
            height: parent.height
            width: 100
            anchors.right: action_approve_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isAdmin() && email_content_rtl.isActiveEmail() && !root.createNewEmail
            icon: "\uf00d"
            action: qsTr("لغو")
            onButtonClicked:
            {
                root.rejectButtonClicked(email_content_rtl.case_number)
                root.syncEmail()
            }
        }

        HhmActionButton
        {
            id: action_archive_rtl
            height: parent.height
            width: 120
            anchors.right:
            {
                if( action_reject_rtl.visible )
                {
                    action_reject_rtl.left
                }
                else
                {
                    action_reply_rtl.left
                }
            }
            anchors.verticalCenter: parent.verticalCenter
            visible: email_content_rtl.isActiveEmail() && !root.createNewEmail
            icon: "\uf187"
            action: qsTr("آرشیو")
            onButtonClicked: root.archiveButtonClicked()
        }

        //Top Bar for New Email Page
        HhmActionButton
        {
            id: action_back_rtl
            height: parent.height
            width: 100
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            visible: root.createNewEmail
            icon: "\uf060"
            action: qsTr("بازگشت")
            onButtonClicked: root.createNewEmail = false
        }

        HhmActionButton
        {
            id: action_scan_rtl
            height: parent.height
            width: 100
            anchors.right: action_back_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.createNewEmail
            icon: "\uf574"
            action: qsTr("اسکن")
            onButtonClicked: root.scanButtonClicked()
        }

        HhmActionButton
        {
            id: action_send_rtl
            height: parent.height
            width: 100
            anchors.right: action_scan_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.createNewEmail
            icon: "\uf1d8"
            action: qsTr("ارسال")
            onButtonClicked: root.sendEmail()
        }

    }

    Rectangle
    {
        id: rtl_rect_text
        height: parent.height
        width: 130
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"
        visible: root.rtl

        Text
        {
            id: department_rtl
            text: "قوه قضاییه عراق"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 16
            anchors.topMargin: 5
            color: "#c8c8c8"
            font.family: fontSansRegular.name
            font.weight: Font.Bold
            font.pixelSize: 14
        }

        Text
        {
            id: office_rtl
            text: "دفتر استراتژیک و برنامه ریزی"
            anchors.right: parent.right
            anchors.top: department_rtl.bottom
            anchors.rightMargin: 16
            color: "#c8c8c8"
            font.family: fontSansRegular.name
            font.weight: Font.Normal
            font.pixelSize: 12
        }

    }

    Item
    {
        id: ltr_action_box
        anchors.fill: parent
        anchors.left: parent.left
        anchors.top: parent.top
        visible: !root.rtl

        //Top Bar for Content Email Page
        HhmActionButton
        {
            id: action_new
            height: parent.height
            width: 100
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            visible: !root.createNewEmail
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
            visible: email_content.isActiveEmail() && !root.createNewEmail
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
            visible: root.isAdmin() && email_content.isActiveEmail() && !root.createNewEmail
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
            visible: root.isAdmin() && email_content.isActiveEmail() && !root.createNewEmail
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
            visible: email_content.isActiveEmail() && !root.createNewEmail
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
            visible: root.createNewEmail
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
            visible: root.createNewEmail
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
            visible: root.createNewEmail
            icon: "\uf1d8"
            action: "Send"
            onButtonClicked: root.sendEmail()
        }

    }

    Rectangle
    {
        id: ltr_rect_text
        height: parent.height
        width: 130
        anchors.right: parent.right
        anchors.top: parent.top
        color: "transparent"
        visible: !root.rtl

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
