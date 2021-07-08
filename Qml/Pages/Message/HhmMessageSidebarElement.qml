import QtQuick 2.0

Rectangle
{
    id: container

    property string message_id:             ""//The Qml does not support int64
    property int    source_id:              0//The Qml does not support int64
    property string text_subject:           "Subject"
    property int    text_number_sources:    7
    property string text_name:              "Subject"
    property string text_date:              "Subject"
    property bool   is_active:              false
    property bool   is_open:                false
    property bool   is_attach:              true

    property color color_background_normal:         "#d7d7d7"
    property color color_background_hovered:        "#e5e5e5"
    property color color_background_active:         "#4f5965"
    property color color_background_active_hovered: "#607690"
    property color color_background:
    {
        if( is_active && isHovered )
        {
            color_background_active_hovered
        }
        else if( is_active )
        {
            color_background_active
        }
        else if( isHovered )
        {
            color_background_hovered
        }
        else
        {
            color_background_normal
        }
    }

    property color color_text_normal:           "#505050"
    property color color_text_hovered:          "#3c3c3c"
    property color color_text_active:           "#e6e6e6"
    property color color_text_active_hovered:   "#fafafa"
    property color color_text:
    {
        if( is_active && isHovered )
        {
            color_text_active_hovered
        }
        else if( is_active )
        {
            color_text_active
        }
        else if( isHovered )
        {
            color_text_hovered
        }
        else
        {
            color_text_normal
        }
    }

    property bool isHovered:    false

    signal clickItem()

    height: 60
    color: color_background

    Text
    {
        id: label_read
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 17
        anchors.topMargin: 12
        text:
        {
            if( is_open )
            {
                "\uf2b6"
            }
            else
            {
                "\uf0e0"
            }
        }
        font.family:
        {
            if( is_open )
            {
                fontAwesomeRegular.name
            }
            else
            {
                fontAwesomeSolid.name
            }
        }
        font.weight:
        {
            if( is_open )
            {
                Font.Normal
            }
            else
            {
                Font.Bold
            }
        }
        font.pixelSize: 15
        color: color_text
    }

    Text
    {
        id: label_subject
        text: root.sliceString(text_subject, 32)
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 12
        anchors.right: label_read.left
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 7
        color: color_text
    }

    Text
    {
        id: label_number_sources
        text: root.en2ar(text_number_sources)
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 12
        anchors.right: label_subject.left
        anchors.rightMargin: 12
        anchors.top: label_subject.top
        color:
        {
            if( is_active )
            {
                "#c6c8ca"
            }
            else
            {
                "#6e6e6e"
            }
        }
        visible: text_number_sources!==1
    }

    Text
    {
        id: label_name
        text: root.sliceString(text_name, 30)
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 11
        anchors.right: label_subject.right
        anchors.rightMargin: 1
        anchors.top: label_subject.bottom
        anchors.topMargin: -3
        color:
        {
            if( is_active && isHovered )
            {
                color_text_active_hovered
            }
            else if( is_active )
            {
                color_text_active
            }
            else if( isHovered )
            {
                "#4068b0"
            }
            else
            {
                "#3c598c"
            }
        }
    }

    Text
    {
        id: label_date
        text: root.en2ar(text_date)
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 12
        anchors.left: split_line.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 5
        color: color_text
    }

    Text
    {
        id: label_attach
        text: "\uf0c6"
        anchors.top: label_date.bottom
        anchors.topMargin: -2
        anchors.left: split_line.left
        anchors.leftMargin: 2
        font.family: fontAwesomeRegular.name
        font.pixelSize: 15
        color: color_text
        visible: is_attach
    }

    Rectangle
    {
        id: split_line
        width: 260
        height: 1
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.bottom: parent.bottom
        color: "#969696"
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true

        onEntered:
        {
            container.isHovered = true
        }

        onExited:
        {
            container.isHovered = false
        }

        onClicked:
        {
            clickItem()
        }

    }

}
