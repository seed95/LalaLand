import QtQuick 2.0

Item
{
    id: container

    property int num_attach_file: 0

    //Qml Signals
    signal fileClicked(int idFile)

    height:
    {
        if( num_attach_file<3 )
        {
            attach1.height + attach1.y
        }
        else
        {
            lv_attach.height + lv_attach.y
        }
    }

    HhmAttachmentBtn
    {
        id: attach1
        height: 30
        anchors.left: parent.left
        anchors.top: parent.top
        text_filename: ""
        download_mode: true
        visible: container.num_attach_file>0

        onDownloadAttachment:
        {
            fileClicked(id_file)
        }
    }

    HhmAttachmentBtn
    {
        id: attach2
        height: 30
        anchors.left: attach1.right
        anchors.leftMargin: 20
        anchors.top: parent.top
        text_filename: ""
        download_mode: true
        visible: container.num_attach_file>1

        onDownloadAttachment:
        {
            fileClicked(id_file)
        }
    }

    ListView
    {
        id: lv_attach
        height: 30
        width: parent.width
        anchors.left: parent.left
        anchors.top: attach1.bottom
        anchors.topMargin: 11
        model: ListModel
        {
            id: lm_attachment
        }
        orientation: ListView.Horizontal
        layoutDirection: Qt.LeftToRight
        spacing: attach2.anchors.leftMargin
        interactive: contentWidth>width
        clip: true
        visible: container.num_attach_file>2

        delegate: HhmAttachmentBtn
        {
            height: 30
            text_filename   : attachFilename
            id_file         : idFile
            download_mode   : true

            onDownloadAttachment:
            {
                fileClicked(idFile)
            }
        }

    }

    function addAttachFile(fileId, filename)
    {
        if( container.num_attach_file==0 )
        {
            attach1.text_filename = filename
            attach1.id_file = fileId
        }
        else if( container.num_attach_file==1 )
        {
            attach2.text_filename = filename
            attach2.id_file = fileId
        }
        else
        {
            lm_attachment.append({"attachFilename" : filename,
                                  "idFile" : fileId})
        }
        container.num_attach_file += 1
    }

    function removeAllAttach()
    {
        container.num_attach_file = 0
        attach1.text_filename = ""
        attach2.text_filename = ""
        lm_attachment.clear()
    }

}
