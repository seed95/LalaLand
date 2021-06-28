import QtQuick 2.0
import Qt.labs.settings 1.0

Item
{
    id: container

    property int documentState: con.hhm_DOCUMENT_NONE_STATE

    HhmDocumentAction
    {
        id: actions
        anchors.top: parent.top
        anchors.topMargin: -25
        anchors.left: parent.left
        objectName: "DocumentAction"
        onSendDocumentClicked:
        {
            new_document.sendDocument()
        }
    }

    HhmDocumentNew
    {
        id: new_document
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "DocumentNew"
        visible: documentState===con.hhm_DOCUMENT_NEW_STATE
    }

    HhmDocumentView
    {
        id: show_document
        anchors.left: parent.left
        anchors.top: actions.bottom
        objectName: "DocumentView"
        visible: documentState===con.hhm_DOCUMENT_VIEW_STATE
    }

    function successfullySend()
    {
        //Check if a document selected, state changed to hhm_DOCUMENT_VIEW_STATE
        documentState = con.hhm_DOCUMENT_NONE_STATE
    }

    function showDocument()
    {
        documentState = con.hhm_DOCUMENT_VIEW_STATE
    }

}
