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
        objectName: "Admin"
        anchors.fill: parent
        visible: root.hhm_mode===con.hhm_ADMINPANEL_MODE
    }

    HhmDocument
    {
        id: document
        anchors.fill: parent
        objectName: "Document"
        visible: root.hhm_mode===con.hhm_DOCUMENT_MODE
    }

}
