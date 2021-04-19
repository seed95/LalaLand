import QtQuick 2.0

Rectangle
{
    id: container

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

    property int    case_number:                1992
    property int    doc_status:                 1
    property int    id_email_in_emails_table:   0
    property string text_subject:               "Subject"
    property string text_time:                  "7:17PM"
    property string text_name:                  "Cassie Hicks"
    property string text_username:              "Admin"
    property string text_filepath:              "Filename.pdf"
    property string receiver_names: value

    property bool isHovered:    false
    property bool isActive:     false
    property bool isRead:       false
    property bool isFlag:       true

    signal emailClicked()

    height: 60
    color: color_background

    Item
    {
        anchors.fill: parent
        visible: root.rtl

        Text
        {
            id: label_read_rtl
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
            id: label_subject_rtl
            text: text_subject
            font.family: fontSansRegular.name
            font.weight: Font.Normal
            font.pixelSize: 18
            anchors.right: label_read_rtl.left
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
            id: label_doc_status_rtl
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
            font.family: fontSansRegular.name
            font.weight: Font.Normal
            font.pixelSize: 15
            anchors.right: label_subject_rtl.right
            anchors.top: label_case_number_rtl.bottom
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
            id: label_time_rtl
            text: text_time
            font.family: fontRobotoRegular.name
            font.weight: Font.Normal
            font.pixelSize: 13
            anchors.left: split_line_rtl.left
            anchors.leftMargin: 1
            anchors.top: parent.top
            anchors.topMargin: 10
            visible: false
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
            id: label_case_number_rtl
            text: "#" + root.en2ar(case_number)
            font.family: fontRobotoRegular.name
            font.weight: Font.Normal
            font.pixelSize: 13
            anchors.left: split_line_rtl.left
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
            id: label_flag_rtl
            text: "\uf024"
            anchors.top: label_time_rtl.bottom
            anchors.left: split_line_rtl.left
            anchors.leftMargin: 2
            anchors.topMargin: 3
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
            id: split_line_rtl
            width: 260
            height: 1
            anchors.right: parent.right
            anchors.rightMargin: 14
            anchors.bottom: parent.bottom
            color: "#969696"
        }

    }

    Item
    {
        anchors.fill: parent
        visible: !root.rtl

        Text
        {
            id: label_read
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 16
            anchors.topMargin: 14
            text: "\uf2b6"
            font.family: fontAwesomeRegular.name
            font.weight: Font.Normal
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
            visible: isRead
        }

        Text
        {
            id: label_unread
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 16
            anchors.topMargin: 14
            text: "\uf0e0"
            font.family: fontAwesomeSolid.name
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
            visible: !isRead
        }

        Text
        {
            id: label_subject
            text: text_subject
            font.family: fontRobotoMedium.name
            font.weight: Font.Medium
            font.pixelSize: 18
            anchors.left:
            {
                if(isRead)
                {
                    label_read.right
                }
                else
                {
                    label_unread.right
                }

            }
            anchors.leftMargin: 10
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
                    "Accept"
                }
                else if( doc_status===con.id_DOC_STATUS_PENDING )
                {
                    "Waiting for approved"
                }
                else if( doc_status===con.id_DOC_STATUS_FAILED )
                {
                    "Reject"
                }
            }

            font.family: fontRobotoRegular.name
            font.weight: Font.Normal
            font.pixelSize: 15
            anchors.left: label_subject.left
            anchors.top: label_case_number.bottom
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
            id: label_time
            text: text_time
            font.family: fontRobotoRegular.name
            font.weight: Font.Normal
            font.pixelSize: 13
            anchors.right: split_line.right
            anchors.rightMargin: 1
            anchors.top: parent.top
            anchors.topMargin: 10
            visible: false
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
            id: label_case_number
            text: "#" + case_number
            font.family: fontRobotoRegular.name
            font.weight: Font.Normal
            font.pixelSize: 13
            anchors.right: split_line.right
            anchors.rightMargin: 1
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
            anchors.top: label_time.bottom
            anchors.right: split_line.right
            anchors.rightMargin: 2
            anchors.topMargin: 3
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
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.bottom: parent.bottom
            color: "#969696"
        }

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
            emailClicked()
//            isActive = !isActive
        }

    }

}
