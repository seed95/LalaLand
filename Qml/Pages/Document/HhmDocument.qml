import QtQuick 2.0
import Qt.labs.settings 1.0

Item
{
    id: container

    property int documentState:     con.hhm_DOCUMENT_NONE_STATE
    property int sidebarState:      con.hhm_SIDEBAR_NONE_STATE

    //Cpp Signals
    signal documentClicked(int casenumber)

    Settings
    {
        property alias documentSidebar: container.sidebarState
    }

    HhmDocumentAction
    {
        id: actions
        anchors.top: parent.top
        anchors.topMargin: -25
        anchors.left: parent.left
        emailState: container.sidebarState
        objectName: "DocumentAction"

        onSendDocumentClicked:
        {
            new_document.sendDocument()
        }

        onViewBackClicked:
        {
            container.documentState = con.hhm_DOCUMENT_NONE_STATE
            sidebar.clearSelectedItem()
        }

        onApproveClicked:
        {
            view_document.approve()
        }

        onRejectClicked:
        {
            view_document.reject()
        }

    }

    HhmSideBar
    {
        id: sidebar
        anchors.top: actions.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        emailState: container.sidebarState
        objectName: "DocumentSidebar"

        onInboxClicked:
        {
            container.sidebarState = con.hhm_SIDEBAR_INBOX_STATE
            if( container.documentState!==con.hhm_DOCUMENT_NEW_STATE )
            {
                container.documentState = con.hhm_DOCUMENT_NONE_STATE
            }
        }

        onOutboxClicked:
        {
            container.sidebarState = con.hhm_SIDEBAR_OUTBOX_STATE
            if( container.documentState!==con.hhm_DOCUMENT_NEW_STATE )
            {
                container.documentState = con.hhm_DOCUMENT_NONE_STATE
            }
        }

        onEmailClicked:
        {
            if( idSelectedEmail===con.hhm_NO_SELECTED_ITEM )
            {
                container.documentState = con.hhm_DOCUMENT_NONE_STATE
            }
            else
            {
                documentClicked(idItem)
            }
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
        id: view_document
        anchors.left: parent.left
        anchors.top: actions.bottom
        emailState: container.sidebarState
        objectName: "DocumentView"
        visible: documentState===con.hhm_DOCUMENT_VIEW_STATE
    }

    /*** Call this functions from cpp ***/
    function successfullySend()
    {
        container.documentState = con.hhm_DOCUMENT_NONE_STATE
        sidebar.syncSidebar()
    }

    function showDocument()
    {
        container.documentState = con.hhm_DOCUMENT_VIEW_STATE
    }

    /*** Call this functions from qml ***/
    function signOut()
    {
        container.documentState = con.hhm_DOCUMENT_NONE_STATE
        sidebar.signOut()
    }

}
