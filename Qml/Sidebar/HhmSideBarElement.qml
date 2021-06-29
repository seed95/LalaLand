import QtQuick 2.0

Rectangle
{
    id: container

    property int    case_number:                1992
    property int    doc_status:                 1
    property string text_subject:               "Subject"
    property int    email_id:   0
    property bool   isActive:     false
    property bool   isRead:       false
    property bool   isFlag:       true

    property color color_background_normal:         "#d7d7d7"
    property color color_background_hovered:        "#e5e5e5"
    property color color_background_active:         "#545f88"
    property color color_background_active_hovered: "#6179cb"
    property color color_background:
    {
        if(isActive && isHovered)
        {
            color_background_active_hovered
        }
        else if(isActive)
        {
            color_background_active
        }
        else if(isHovered)
        {
            color_background_hovered
        }
        else
        {
            color_background_normal
        }
    }

    property color color_text_active:           "#d7d7d7"
    property color color_text_active_hovered:   "#e6e6e6"

    property bool isHovered:    false

    signal clickItem()

    height: 60
    color: color_background

    Text
    {
        id: label_read
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 16
        anchors.topMargin: 14
        text:
        {
            if( isRead )
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
            if( isRead )
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
            if( isRead )
            {
                Font.Normal
            }
            else
            {
                Font.Bold
            }
        }
        font.pixelSize: 15
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#505050"
            }
        }
    }

    Text
    {
        id: label_subject
        text: root.sliceString(text_subject, 22)
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 13
        anchors.right: label_read.left
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 8
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#3c3c3c"
            }
        }
    }

    Text
    {
        id: label_doc_status
        text:
        {
            if( doc_status===con.id_DOC_STATUS_SUCCESS )
            {
                con.hhm_TEXT_DOC_STATUS_SUCCESS
            }
            else if( doc_status===con.id_DOC_STATUS_PENDING )
            {
                con.hhm_TEXT_DOC_STATUS_PENDING
            }
            else if( doc_status===con.id_DOC_STATUS_FAILED )
            {
                con.hhm_TEXT_DOC_STATUS_FAILED
            }
        }
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 10
        anchors.right: label_subject.right
        anchors.top: label_casenumber.bottom
        anchors.topMargin: 5
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#3c598c"
            }
        }
    }

    Text
    {
        id: label_casenumber
        text: "#" + root.en2ar(case_number)
        font.family: fontRobotoRegular.name
        font.weight: Font.Normal
        font.pixelSize: 13
        anchors.left: split_line.left
        anchors.leftMargin: 1
        anchors.top: parent.top
        anchors.topMargin: 10
        color:
        {
            if(isHovered && isActive)
            {
                color_text_active_hovered
            }
            else if(isActive)
            {
                color_text_active
            }
            else
            {
                "#646464"
            }
        }
    }

    Text
    {
        id: label_flag
        text: "\uf024"
        anchors.top: label_casenumber.bottom
        anchors.topMargin: 3
        anchors.left: split_line.left
        anchors.leftMargin: 2
        font.family: fontAwesomeSolid.name
        font.pixelSize: 15
        color:
        {
            if( doc_status===con.id_DOC_STATUS_SUCCESS )
            {
                "#508c57"
            }
            else if( doc_status===con.id_DOC_STATUS_PENDING )
            {
                "#a68536"
            }
            else if( doc_status===con.id_DOC_STATUS_FAILED )
            {
                "#b95f5f"
            }
        }
        visible: isFlag
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
