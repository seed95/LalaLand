import QtQuick 2.0

Rectangle
{
    property string text_filename: ""
    property int    id_file: 0

    signal deleteAttachment()

    width: childrenRect.width + 10/*right margin*/
    height: 40
    color: "#e6e6e6"
    border.width: 1
    border.color: "#7593b7"

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
                "#f0f0f0"
            }
            else
            {
                parent.color
            }
        }
        border.width: parent.border.width
        border.color:
        {
            if( delete_attach.isHovered )
            {
                "#829dbe"
            }
            else
            {
                parent.border.color
            }
        }

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
        anchors.left: delete_attach.right
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

}
