import QtQuick 2.0

Rectangle
{
    property string text_filename:  ""
    property int    id_file:        0
    property int    id_list:        0 //Handle for delete attach files
    property bool   download_mode:  false


    property color color_background_normal:     "#e6e6e6"
    property color color_background_hovered:    "#f0f0f0"
    property color color_background:
    {
        if( isHovered )
        {
            color_background_hovered
        }
        else
        {
            color_background_normal
        }
    }

    property color color_border_normal:     "#7593b7"
    property color color_border_hovered:    "#829dbe"
    property color color_border:
    {
        if( isHovered )
        {
            color_border_hovered
        }
        else
        {
            color_border_normal
        }
    }

    property bool   isHovered: false

    signal deleteAttachment()
    signal downloadAttachment()

    width: rect_file.width + rect_file.x + 10/*right margin*/
    height: 40
    color: color_background
    border.width: 1
    border.color: color_border

    Rectangle
    {
        id: delete_attach
        width: 35
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top
        color:
        {
            if( delete_attach.isHovered )
            {
                color_background_hovered
            }
            else
            {
                color_background_normal
            }
        }
        border.width: parent.border.width
        border.color:
        {
            if( delete_attach.isHovered )
            {
                color_border_hovered
            }
            else
            {
                color_border_normal
            }
        }
        visible: !download_mode

        property bool isHovered: false

        Text
        {
            text: "X"
            font.family: fontRobotoRegular.name
            font.pixelSize: 17
            anchors.centerIn: parent
            color:
            {
                if( delete_attach.isHovered )
                {
                    "#b07368"
                }
                else
                {
                    "#b77f75"
                }
            }
        }

        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onEntered: delete_attach.isHovered = true

            onExited: delete_attach.isHovered = false

            onClicked: deleteAttachment()
        }

    }

    Rectangle
    {
        id: rect_file
        width: childrenRect.width
        height: parent.height
        anchors.left:
        {
            if( download_mode )
            {
                parent.left
            }
            else
            {
                delete_attach.right
            }
        }
        anchors.leftMargin: 10
        color: "transparent"

        Text
        {
            id: label_file
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            elide: Text.ElideRight
            text: text_filename.replace(/^.*[\\\/]/, '')
            font.family: fontRobotoRegular.name
            font.pixelSize: 17
            color: "#556373"
        }

        Text
        {
            id: icon_file
            anchors.left: label_file.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf15b"
            font.family: fontAwesomeSolid.name
            font.weight: Font.Bold
            font.pixelSize: 14
            color: "#556373"
        }

    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        visible: download_mode

        onClicked:
        {
            downloadAttachment()
        }

        onEntered:
        {
            isHovered = true
        }

        onExited:
        {
            isHovered = false
        }
    }

}
