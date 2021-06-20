import QtQuick 2.0

Rectangle
{

    width: 980
    height: 50
    color: "#c8c8c8"

    Item
    {
        id: rtl_action_box
        anchors.fill: parent
        anchors.left: parent.left
        anchors.top: parent.top
        visible: root.rtl

        //Top Bar for Content Email Page
        HhmActionBtn
        {
            id: action_new_rtl
            height: parent.height
            width: 100
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            visible: !root.createNewEmail
            icon: "\uf067"
            action: qsTr("انشاء")
            onButtonClicked: root.showPageNewEmail()
        }

        HhmActionBtn
        {
            id: action_reply_rtl
            height: parent.height
            width: 100
            anchors.right: action_new_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isDocSelected() && !root.createNewEmail && root.email_mode===con.id_EMAIL_MODE_INBOX
            icon: "\uf3e5"
            action: qsTr("الرد")
            onButtonClicked: root.replyButtonClicked()
        }

        HhmActionBtn
        {
            id: action_approve_rtl
            height: parent.height
            width: 100
            anchors.right: action_reply_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isDocSelected() && !root.createNewEmail && root.email_mode===con.id_EMAIL_MODE_INBOX
            icon: "\uf00c"
            action: qsTr("تأیید المستند")
            onButtonClicked:
            {
                root.approveButtonClicked(email_content_rtl.case_number,
                                          email_content_rtl.getDataContent(),
                                          email_content_rtl.email_id)
            }
        }

        HhmActionBtn
        {
            id: action_reject_rtl
            height: parent.height
            width: 80
            anchors.right: action_approve_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isDocSelected() && !root.createNewEmail && root.email_mode===con.id_EMAIL_MODE_INBOX
            icon: "\uf00d"
            action: qsTr("رفض")
            onButtonClicked:
            {
                root.rejectButtonClicked(email_content_rtl.case_number)
                root.syncEmail()
            }
        }

        HhmActionBtn
        {
            id: action_archive_rtl
            height: parent.height
            width: 100
            anchors.right:
            {
                if( action_reject_rtl.visible )
                {
                    action_reject_rtl.left
                }
                else
                {
                    action_new_rtl.left
                }
            }
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isDocSelected() && !root.createNewEmail
            icon: "\uf187"
            action: qsTr("ارشفة")
            onButtonClicked: root.archiveButtonClicked()
        }

        //Top Bar for New Email Page
        HhmActionBtn
        {
            id: action_back_rtl
            height: parent.height
            width: 100
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            visible: root.createNewEmail
            icon: "\uf061"
            action: qsTr("رجوع")
            onButtonClicked: root.createNewEmail = false
        }

        HhmActionBtn
        {
            id: action_scan_rtl
            height: parent.height
            width: 120
            anchors.right: action_back_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.createNewEmail
            icon: "\uf574"
            action: qsTr("المسح الضوئي")
            onButtonClicked: root.scanButtonClicked()
        }

        HhmActionBtn
        {
            id: action_send_rtl
            height: parent.height
            width: 100
            anchors.right: action_scan_rtl.left
            anchors.verticalCenter: parent.verticalCenter
            visible: root.createNewEmail
            icon: "\uf1d8"
            action: qsTr("رسال")
            onButtonClicked: root.sendEmail()
        }

        HhmActionBtn
        {
            id: action_signout_rtl
            height: parent.height
            width: 100
            anchors.right:
            {
                if( root.createNewEmail )
                {

                    action_send_rtl.left
                }
                else if( root.isDocSelected() )
                {
                    action_archive_rtl.left
                }
                else
                {
                    action_new_rtl.left
                }
            }
            anchors.verticalCenter: parent.verticalCenter
            icon: "\uf2f5"
            action: qsTr("الخروج")
            onButtonClicked: root.signOut()
        }

    }

    Item
    {
        id: action_box
        anchors.fill: parent
        anchors.left: parent.left
        anchors.top: parent.top
        visible: !root.rtl

        //Top Bar for Content Email Page
        HhmActionBtn
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

        HhmActionBtn
        {
            id: action_reply
            height: parent.height
            width: 100
            anchors.left: action_new.right
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isDocSelected() && !root.createNewEmail
            icon: "\uf3e5"
            action: "Reply"
            onButtonClicked: root.replyButtonClicked()
        }

        HhmActionBtn
        {
            id: action_approve
            height: parent.height
            width: 120
            anchors.left: action_reply.right
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isDocSelected() && !root.createNewEmail && root.email_mode===con.id_EMAIL_MODE_INBOX
            icon: "\uf00c"
            action: "Approve"
            onButtonClicked:
            {
                root.approveButtonClicked(email_content.case_number)
                root.syncEmail()
            }
        }

        HhmActionBtn
        {
            id: action_reject
            height: parent.height
            width: 100
            anchors.left: action_approve.right
            anchors.verticalCenter: parent.verticalCenter
            visible: root.isDocSelected() && !root.createNewEmail && root.email_mode===con.id_EMAIL_MODE_INBOX
            icon: "\uf00d"
            action: "Reject"
            onButtonClicked:
            {
                root.rejectButtonClicked(email_content.case_number)
                root.syncEmail()
            }
        }

        HhmActionBtn
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
            visible: root.isDocSelected() && !root.createNewEmail
            icon: "\uf187"
            action: "Archive"
            onButtonClicked: root.archiveButtonClicked()
        }

        //Top Bar for New Email Page
        HhmActionBtn
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

        HhmActionBtn
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

        HhmActionBtn
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

}
