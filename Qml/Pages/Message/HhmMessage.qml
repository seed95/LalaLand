import QtQuick 2.0
import Qt.labs.settings 1.0

Item
{
    id: container

    property int messageState:  con.hhm_MESSAGE_NONE_STATE
    property int sidebarState:  con.hhm_SIDEBAR_NONE_STATE

    property string replyMessageId: ""//The Qml does not support int64

    //Cpp Signals
    signal sendNewMessage(variant toData, variant ccData, string subject,
                          string content, variant attachFiles)
    signal messageClicked(string idMessage)
    signal replyMessage(string replyMessageId)
    signal sendReplyMessage(variant toData, variant ccData, string subject,
                            string content, variant attachFiles, string replyMessageId)

    Settings
    {
        property alias messageSidebar: container.sidebarState
    }

    HhmMessageAction
    {
        id: actions
        anchors.top: parent.top
        anchors.topMargin: -10
        anchors.left: parent.left
        message_state: container.messageState
        objectName: "MessageAction"

        onNewMessageClicked:
        {
            container.messageState = con.hhm_MESSAGE_NEW_STATE
        }

        onSendMessageClicked:
        {
            sendMessage()
        }

        onViewBackClicked:
        {
            container.messageState = con.hhm_MESSAGE_NONE_STATE
            sidebar.clearSelectedItem()
        }

        onReplyClicked:
        {
            container.messageState = con.hhm_MESSAGE_REPLY_STATE
            container.replyMessageId = view_message.getFirstMessageId()
            replyMessage(container.replyMessageId)
        }

        onNewBackClicked:
        {
            container.messageState = con.hhm_MESSAGE_NONE_STATE
            sidebar.clearSelectedItem()
            attachbar.clearList()
        }

    }

    HhmMessageSidebar
    {
        id: sidebar
        anchors.top: actions.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        boxState: container.sidebarState
        objectName: "MessageSidebar"

        onInboxClicked:
        {
            container.sidebarState = con.hhm_SIDEBAR_INBOX_STATE
            if( container.messageState!==con.hhm_MESSAGE_NEW_STATE )
            {
                container.messageState = con.hhm_MESSAGE_NONE_STATE
            }
        }

        onOutboxClicked:
        {
            container.sidebarState = con.hhm_SIDEBAR_OUTBOX_STATE
            if( container.messageState!==con.hhm_MESSAGE_NEW_STATE )
            {
                container.messageState = con.hhm_MESSAGE_NONE_STATE
            }
        }

        onSelectMessage:
        {
            messageClicked(idMessage)
        }

        onDeselectMessage:
        {
            container.messageState = con.hhm_MESSAGE_NONE_STATE
        }

    }

    Flickable
    {
        anchors.top: actions.bottom
        anchors.left: parent.left
        anchors.right: sidebar.left
        anchors.bottom:
        {
            if( attachbar.visible )
            {
                attachbar.top
            }
            else
            {
                parent.bottom
            }
        }
        contentHeight:
        {
            if( container.messageState===con.hhm_MESSAGE_NEW_STATE )
            {
                new_message.height + new_message.y
            }
            else//con.hhm_MESSAGE_VIEW_STATE || con.hhm_MESSAGE_REPLY_STATE
            {
                view_message.height + view_message.y
            }
        }
        interactive:
        {
            if( container.messageState===con.hhm_MESSAGE_REPLY_STATE )
            {
                contentHeight>height
            }
            else//hhm_MESSAGE_VIEW_STATE || hhm_MESSAGE_NEW_STATE
            {
                false
            }
        }
        clip: true
        flickableDirection: Flickable.VerticalFlick

        HhmMessageNew
        {
            id: new_message
            anchors.left: parent.left
            anchors.top: parent.top
            message_state: container.messageState
            objectName: "MessageNew"
            visible: container.messageState===con.hhm_MESSAGE_NEW_STATE ||
                     container.messageState===con.hhm_MESSAGE_REPLY_STATE
        }

        HhmMessageView
        {
            id: view_message
            anchors.left: parent.left
            anchors.top:
            {
                if( container.messageState===con.hhm_MESSAGE_VIEW_STATE )
                {
                    parent.top
                }
                else//con.hhm_MESSAGE_REPLY_STATE
                {
                   new_message.bottom
                }
            }
            message_state: container.messageState
            objectName: "MessageView"
            visible: container.messageState===con.hhm_MESSAGE_VIEW_STATE ||
                     container.messageState===con.hhm_MESSAGE_REPLY_STATE

            onReplyClicked:
            {
                container.messageState = con.hhm_MESSAGE_REPLY_STATE
                container.replyMessageId = replyMessageId
                replyMessage(replyMessageId)
            }

        }

    }

    HhmAttachmentBar
    {
        id: attachbar
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: sidebar.left
        attachMode: con.hhm_ATTACHMENT_UPLOAD_MODE
        objectName: "MessageAttachbar"
    }

    /*** Call this function from cpp ***/
    function successfullySend()
    {
        //Check if a message selected, state changed to hhm_MESSAGE_VIEW_STATE
        container.messageState = con.hhm_MESSAGE_NONE_STATE
        attachbar.clearList()
        sidebar.clearSelectedItem()
    }

    function showMessage()
    {
        container.messageState = con.hhm_MESSAGE_VIEW_STATE
    }

    /*** Call this functions from qml ***/
    function signOut()
    {
        container.messageState = con.hhm_MESSAGE_NONE_STATE
        sidebar.signOut()
    }

    function sendMessage()
    {
        if( container.messageState===con.hhm_MESSAGE_NEW_STATE )
        {
            sendNewMessage(new_message.getToData(),
                           new_message.getCcData(),
                           new_message.getSubject(),
                           new_message.getContent(),
                           attachbar.getAttachFiles())
        }
        else//con.hhm_MESSAGE_REPLY_STATE
        {
            sendReplyMessage(new_message.getToData(),
                             new_message.getCcData(),
                             new_message.getSubject(),
                             new_message.getContent(),
                             attachbar.getAttachFiles(),
                             container.replyMessageId)
        }

    }

}
