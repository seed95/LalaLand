import QtQuick 2.0

Rectangle
{
    id: container

    //Set this variables in qml
    property int    attachMode:         con.hhm_ATTACHMENT_NONE_MODE

    //Set this variables in cpp
    property string attach_filename:    ""
    property int    attach_fileId:      0

    property int cnt_id: 0//Counter for id of attach file in upload mode

    //Qml Signals
    signal fileClicked(int idFile)

    height: 70
    color: "#dcdcdc"
    visible: lm_attachment.count!==0

    Flickable
    {
        id: flickbar
        width: parent.width
        height: container.height
        anchors.right: parent.right
        anchors.rightMargin: 1
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        flickableDirection: Flickable.AutoFlickIfNeeded
        clip: true

        onContentWidthChanged:
        {
            if( contentWidth<container.width )
            {
                interactive = false
                anchors.leftMargin = container.width - contentWidth
            }
            else
            {
                interactive = true
                anchors.leftMargin = 1
            }
        }

        ListView
        {
            id: lv_attachment
            height: parent.height
            width: parent.width
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 15
            model: ListModel
            {
                id: lm_attachment
            }
            orientation: ListView.Horizontal
            layoutDirection: Qt.RightToLeft
            spacing: 20
            interactive: false

            onCountChanged:
            {
                flickbar.contentWidth = getContentWidth()
            }

            delegate: HhmAttachmentBtn
            {
                text_filename   : attachFilename
                id_file         : idFile
                id_list         : idList
                download_mode   : container.attachMode===con.hhm_ATTACHMENT_DOWNLOAD_MODE

                onDeleteAttachment:
                {
                    removeAttachFile(idList)
                }

                onDownloadAttachment:
                {
                    fileClicked(idFile)
                }
            }

        }

    }

    /*** Call this function from cpp ***/
    function addAttachFile()
    {
        lm_attachment.append({"attachFilename" : container.attach_filename,
                              "idFile" : attach_fileId,
                              "idList" : cnt_id})
        cnt_id += 1
    }

    /*** Call this function from qml ***/
    function removeAttachFile(listId)
    {
        for(var i=0; i<lm_attachment.count; i++)
        {
            if( lm_attachment.get(i).idList===listId )
            {
                lm_attachment.remove(i)
                break
            }
        }
    }

    //Return format: list
    function getAttachFiles()
    {
        var result = []
        for(var i=0; i<lm_attachment.count ; i++)
        {
            result.push(lm_attachment.get(i).attachFilename)
        }
        return result
    }

    function getContentWidth()
    {
        var result = 0
        for(var childId=1; childId<lv_attachment.contentItem.children.length; childId++)
        {
            result += lv_attachment.contentItem.children[childId].width + lv_attachment.spacing
        }
        result += lv_attachment.anchors.rightMargin
        return result
    }

    function clearList()
    {
        lm_attachment.clear()
    }
}
