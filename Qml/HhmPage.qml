import QtQuick 2.0

Item
{
    HhmMessage
    {
        id: message
        anchors.fill: parent
        objectName: "Message"
        visible: root.hhm_mode===con.hhm_MESSAGE_MODE
    }

    HhmAdmin
    {
        id: admin_panel
        anchors.fill: parent
        objectName: "Admin"
        visible: root.hhm_mode===con.hhm_ADMINPANEL_MODE
    }

    HhmDocument
    {
        id: document
        anchors.fill: parent
        objectName: "Document"
        visible: root.hhm_mode===con.hhm_DOCUMENT_MODE
    }

    function signOut()
    {
        document.signOut()
    }

}
