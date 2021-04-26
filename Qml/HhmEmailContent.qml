import QtQuick 2.0

Item
{

    property int    case_number: con.id_NO_SELECTED_ITEM
    property string text_name: "Cassie Hicks"
    property int    doc_status: 1
    property string text_user: "User #1"
    property string text_username: "Amy E. Alberts."
    property string text_email: text_username + "@" + root.domain
    property string text_time: "12:15PM"
    property string text_to: "April Robegan, Jamie Reading"
    property string text_subject: ""
    property string download_filepath: ""

    Item
    {
        id: container_rtl
        anchors.fill: parent
        anchors.left: parent.left
        anchors.top: parent.top
        visible: root.rtl

        Text
        {
            id: label_subject_rtl
            text: root.sliceString(text_subject, 40)
            anchors.right: parent.right
            anchors.rightMargin: 24
            anchors.topMargin:
            {
                if( root.fontOffset )
                {
                    8
                }
                else
                {
                    18
                }
            }
            anchors.top: parent.top
            font.family: fontSansBold.name
            font.pixelSize: 40
            color: "#5a5a5a"
        }

        Rectangle
        {
            id: rect_status_rtl
            width: 200
            height: 30
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.top: parent.top
            anchors.topMargin: 22
            color: "transparent"

            Text
            {
                id: label_status_rtl
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("وضعیت پرونده: ")
                font.family: fontSansRegular.name
                font.weight: Font.Normal
                font.pixelSize: 20
                color: "#5a5a5a"
            }

            Text
            {
                anchors.right: label_status_rtl.left
                anchors.verticalCenter: parent.verticalCenter
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
                font.pixelSize: 20
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
            }
        }

        Rectangle
        {
            id: split_line_rtl
            width: 940
            height: 1
            anchors.right: label_subject_rtl.right
            anchors.top: label_subject_rtl.bottom
            anchors.topMargin:
            {
                if( root.fontOffset )
                {
                    2
                }
                else
                {
                    8
                }
            }
            color: "#646464"
        }

        Rectangle
        {
            id: rect_user_rtl
            width: 111
            height: width
            anchors.right: label_subject_rtl.right
            anchors.top: split_line_rtl.bottom
            anchors.topMargin: -1
            color: "#c8c8c8"
            border.width: 1
            border.color: "#bebebe"

            Text
            {
                id: icon_user_rtl
                anchors.top: parent.top
                anchors.topMargin: 16
                anchors.horizontalCenter: parent.horizontalCenter
                text: "\uf4fb"
                font.family: fontAwesomeSolid.name
                font.pixelSize: 50
                color: "#646464"
            }

            Text
            {
                id: label_user_rtl
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                anchors.horizontalCenter: parent.horizontalCenter
                text: text_username
                font.family: fontRobotoRegular.name
                font.pixelSize: 22
                color: "#5a5a5a"
            }

        }

        Rectangle
        {
            id: rect_username_rtl
            height: 90
            anchors.right: rect_user_rtl.left
            anchors.left: split_line_rtl.left
            anchors.top: split_line_rtl.bottom
            color: "transparent"

            Text
            {
                id: label_name_rtl
                text: text_name
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.top: parent.top
                anchors.topMargin:
                {
                    if( root.fontOffset )
                    {
                        3
                    }
                    else
                    {
                        7
                    }
                }
                font.family: fontSansRegular.name
                font.weight: Font.Normal
                font.pixelSize: 27
                color: "#5a5a5a"
            }

            Text
            {
                id: label_email_rtl
                text: "(" +  text_username + "@" + root.domain + ")"
                anchors.right: label_name_rtl.left
                anchors.rightMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 13
                font.family: fontRobotoRegular.name
                font.pixelSize: 18
                color: "#5a5a5a"
            }

            Text
            {
                id: label_time_rtl
                text: text_time
                anchors.top: parent.top
                anchors.topMargin: 17
                anchors.left: parent.left
                anchors.leftMargin: 306
                font.family: fontSansRegular.name
                font.weight: Font.Normal
                font.pixelSize: 16
                color: "#646464"
            }

            Rectangle
            {
                id: rect_download_rtl
                width: 60
                height: 30
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.top: label_time_rtl.top
                color: "transparent"

                Text
                {
                    id: label_download_rtl
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin:
                    {
                        if( root.fontOffset )
                        {
                           0
                        }
                        else
                        {
                            0
                        }
                    }
                    text: qsTr("دانلود")
                    font.family: fontSansBold.name
                    font.pixelSize: 17
                    color: "#3c598c"
                }

                Text
                {
                    id: icon_download_rtl
                    anchors.right: label_download_rtl.left
                    anchors.rightMargin: 13
                    anchors.top: parent.top
                    anchors.topMargin:
                    {
                        if( root.fontOffset )
                        {
                            6
                        }
                        else
                        {
                            2
                        }
                    }
                    text: "\uf078"
                    font.family: fontAwesomeSolid.name
                    font.pixelSize: 12
                    color: "#3c598c"
                }

                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked:
                    {
                        root.downloadFileClicked(download_filepath, case_number)
                    }
                }

            }

            Text
            {
                id: label_to_rtl
                text: qsTr("الى: ") + text_to
                anchors.right: label_name_rtl.right
                anchors.top: label_name_rtl.bottom
                anchors.topMargin: -2
                font.family: fontSansRegular.name
                font.weight: Font.Normal
                font.pixelSize: 18
                color: "#646464"
            }

        }

    }

    Item
    {
        id: container
        anchors.fill: parent
        anchors.left: parent.left
        anchors.top: parent.top
        visible: !root.rtl

        Text
        {
            id: label_name
            text: text_name
            font.family: fontRobotoRegular.name
            font.pixelSize: 36
            anchors.left: parent.left
            anchors.leftMargin: 22
            anchors.topMargin: 4
            anchors.top: parent.top
            color: "#5a5a5a"
        }

        Rectangle
        {
            id: rect_status
            width: 220
            height: 30
            anchors.right: parent.right
            anchors.rightMargin: 45
            anchors.top: parent.top
            anchors.topMargin: 20
            color: "transparent"

            Text
            {
                id: label_status
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "Document Status: "
                font.family: fontRobotoMedium.name
                font.weight: Font.Medium
                font.pixelSize: 20
                color: "#5a5a5a"
            }

            Text
            {
                anchors.left: label_status.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 2
                text:
                {
                    if( doc_status===1 )
                    {
                        "Success"
                    }
                    else if( doc_status===2 )
                    {
                        "Pending"
                    }
                    else if( doc_status===3 )
                    {
                        "Failed"
                    }
                }
                font.family: fontRobotoRegular.name
                font.pixelSize: 17
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
            }
        }

        Rectangle
        {
            id: split_line
            anchors.left: label_name.left
            anchors.leftMargin: 3
            anchors.top: label_name.bottom
            anchors.topMargin: 13
            width: 940
            height: 1
            color: "#646464"
        }

        Rectangle
        {
            id: rect_user
            width: 111
            height: width
            anchors.left: label_name.left
            anchors.leftMargin: 3
            anchors.top: split_line.bottom
            anchors.topMargin: -1
            color: "#c8c8c8"
            border.width: 1
            border.color: "#bebebe"

            Text
            {
                id: icon_user
                anchors.top: parent.top
                anchors.topMargin: 16
                anchors.horizontalCenter: parent.horizontalCenter
                text: "\uf4fb"
                font.family: fontAwesomeSolid.name
                font.pixelSize: 50
                color: "#646464"
            }

            Text
            {
                id: label_user
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                anchors.horizontalCenter: parent.horizontalCenter
                text: text_user
                font.family: fontRobotoRegular.name
                font.pixelSize: 20
                color: "#5a5a5a"
            }

        }

        Rectangle
        {
            id: rect_username
            height: 90
            anchors.left: rect_user.right
            anchors.right: split_line.right
            anchors.top: split_line.bottom
            color: "transparent"

            Text
            {
                id: label_username
                text: text_username
                anchors.left: parent.left
                anchors.leftMargin: 34
                anchors.top: parent.top
                anchors.topMargin: 9
                font.family: fontRobotoRegular.name
                font.pixelSize: 25
                color: "#5a5a5a"
            }

            Text
            {
                id: label_email
                text: "(" +  text_email + ")"
                anchors.left: label_username.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 9
                font.family: fontRobotoRegular.name
                font.pixelSize: 25
                color: "#5a5a5a"
            }

            Text
            {
                id: label_time
                text: text_time
                anchors.top: parent.top
                anchors.topMargin: 19
                anchors.right: parent.right
                anchors.rightMargin: 169
                font.family: fontRobotoRegular.name
                font.pixelSize: 12
                color: "#646464"
            }

            Rectangle
            {
                id: rect_download
                width: childrenRect.width
                height: childrenRect.height
                anchors.right: parent.right
                anchors.rightMargin: 25
                anchors.top: label_time.top
                color: "transparent"

                Text
                {
                    id: label_download
                    anchors.left: parent.left
                    anchors.top: parent.top
                    text: "Download"
                    font.family: fontRobotoRegular.name
                    font.pixelSize: 12
                    color: "#3c598c"

                }

                Text
                {
                    id: icon_download
                    anchors.left: label_download.right
                    anchors.leftMargin: 7
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    text: "\uf078"
                    font.family: fontAwesomeSolid.name
                    font.pixelSize: 12
                    color: "#3c598c"
                }

                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked:
                    {
                        root.downloadFileClicked(download_filepath, case_number)
                    }
                }

            }

            Text
            {
                id: label_to
                text: "To: " + text_to
                anchors.left: label_username.left
                anchors.top: label_username.bottom
                anchors.topMargin: 4
                font.family: fontRobotoRegular.name
                font.pixelSize: 18
                color: "#646464"
            }

        }

    }

}
