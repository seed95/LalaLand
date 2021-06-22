import QtQuick 2.0

Item
{
    property int documentState: con.hhm_MESSAGE_NONE_STATE

    HhmMessage
    {
        id: message
        anchors.fill: parent
        objectName: "message"
        visible: root.hhm_mode===con.hhm_MESSAGE_MODE
    }

    HhmAdmin
    {
        id: admin_panel
        anchors.fill: parent
        visible: root.hhm_mode===con.hhm_ADMINPANEL_MODE
    }


//    HhmEmailContent
//    {
//        id: document_content
//        anchors.left: parent.left
//        anchors.right: sidebar.left
//        height: parent.height
//        visible: root.hhm_mode===con.hhm_DOCUMENT_MODE &&
//                 !createNewEmail && root.isDocSelected()
//    }

//    HhmNewEmail
//    {
//        id: new_document
//        anchors.left: parent.left
//        anchors.right: sidebar.left
//        height: parent.height
//        anchors.bottomMargin: 100
//        visible: root.hhm_mode===con.hhm_DOCUMENT_MODE && createNewEmail
//    }

}
