import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0

Rectangle
{
    id: container

    property string last_searched_text: ""

    property int sidebarState:      con.hhm_SIDEBAR_NONE_STATE

    property color color_email_mode_normal:    "#505050"
    property color color_email_mode_hovered:   "#6e6e6e"
    property color color_email_mode_select:    "#3c598c"

    //Cpp Signals
    signal syncInbox()
    signal syncOutbox()

    color: "#d7d7d7"
    width: 300
    height: 675

    onSidebarStateChanged:
    {
        syncSidebar()
    }

    Settings
    {
        property alias sidebarState: container.sidebarState
    }

    HhmSearchDialog
    {
        id: search
        anchors.left: parent.left
        anchors.top: parent.top

        onChangedFocus:
        {
            if( text==="" )
            {
                email_list.visible = true
                email_search_list.visible = false
            }
            else
            {
                email_list.visible = false
                email_search_list.visible = true
            }
        }

        onSearchDocument:
        {
            if( text==="" )
            {
                email_list.visible = true
                email_search_list.visible = false
            }
            else
            {
                email_list.visible = false
                email_search_list.visible = true
                searchDoc(text)
            }
        }
    }

    Rectangle
    {
        id: inbox_outbox
        height: 20
        width: parent.width
        anchors.top: search.bottom
        anchors.left: parent.left
        color: "#c8c8c8"

        Text
        {
            id: inbox
            text: qsTr("الواردة")
            anchors.right: parent.right
            anchors.rightMargin: 34
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 11
            color:
            {
                if( container.sidebarState===con.hhm_SIDEBAR_INBOX_STATE )
                {
                    color_email_mode_select
                }
                else if( inbox.isHovered )
                {
                    color_email_mode_hovered
                }
                else
                {
                    color_email_mode_normal
                }
            }

            property bool isHovered: false

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered:
                {
                    inbox.isHovered = true
                }

                onExited:
                {
                    inbox.isHovered = false
                }

                onClicked:
                {
                    if( container.sidebarState!==con.hhm_SIDEBAR_INBOX_STATE )
                    {
                        container.sidebarState = con.hhm_SIDEBAR_INBOX_STATE
                        root.selected_doc_case_number = con.hhm_NO_SELECTED_ITEM
                        searchDoc(last_searched_text)
                    }
                }

            }
        }

        Text
        {
            id: outbox
            text: qsTr("الصادرة")
            anchors.right: inbox.left
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 11
            color:
            {
                if( container.sidebarState===con.hhm_SIDEBAR_OUTBOX_STATE )
                {
                    color_email_mode_select
                }
                else if( outbox.isHovered )
                {
                    color_email_mode_hovered
                }
                else
                {
                    color_email_mode_normal
                }
            }

            property bool isHovered: false

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered:
                {
                    outbox.isHovered = true
                }

                onExited:
                {
                    outbox.isHovered = false
                }

                onClicked:
                {
                    if( container.sidebarState!==con.hhm_SIDEBAR_OUTBOX_STATE )
                    {
                        container.sidebarState = con.hhm_SIDEBAR_OUTBOX_STATE
                        root.selected_doc_case_number = con.hhm_NO_SELECTED_ITEM
                        searchDoc(last_searched_text)
                    }
                }

            }
        }

    }

    HhmEmailList
    {
        id: email_list
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
        anchors.bottom: parent.bottom
        objectName: "SidebarList"
    }

    HhmEmailList
    {
        id: email_search_list
        width: parent.width
        anchors.left: parent.left
        anchors.top: inbox_outbox.bottom
        anchors.bottom: parent.bottom
        visible: false
    }

    /*** Call this function from cpp ***/
    function addToBox()
    {
        email_list.addToList()
    }

    function searchDoc(text)
    {
        last_searched_text = text
        email_search_list.clearEmails()
        email_search_list.addObjects(email_list.searchObject(root.ar2en(text)))
    }

    function finishSync()
    {
        search.finishSync()
    }

    function clearEmails()
    {
        email_list.clearEmails()
        email_search_list.clearEmails()
    }

    /*** Call this function from qml ***/
    function syncSidebar()
    {
        email_list.clearEmails()
        if( sidebarState===con.hhm_SIDEBAR_INBOX_STATE )
        {
            syncInbox()
        }
        else if( sidebarState===con.hhm_SIDEBAR_OUTBOX_STATE )
        {
            syncOutbox()
        }
    }

}
