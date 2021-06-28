import QtQuick 2.0

Rectangle
{
    property int    case_number: con.hhm_NO_SELECTED_ITEM
    property string text_name: "خايمي كاميل"
    property int    doc_status: 1
    property string text_username: "jamiecamil"
    property string text_email: text_username + "@" + root.domain
    property string text_time: "12:15"
    property string text_to: "جيروم ألين ساينفيلد"
    property string text_subject: "وقال السيناتور بيرني ساندرز"
    property string download_filepath: ""
    property string table_content: ""

    width: 980
    height: 675
    color: "#e8e8e8"

    onTable_contentChanged:
    {
        table.setData(table_content)
    }

    Rectangle
    {
        id: rect_status
        width: 200
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 18
        color: "transparent"

        Text
        {
            id: label_status
            anchors.left: parent.left
            anchors.top: parent.top
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
            font.pixelSize: 16
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

        Text
        {
            anchors.left: label_status.right
            anchors.leftMargin: 10
            anchors.top: parent.top
            text: qsTr("حالة المستند:")
            font.family: fontDroidKufiRegular.name
            font.weight: Font.Normal
            font.pixelSize: 16
            color: "#5a5a5a"
        }

    }

    Text
    {
        id: label_subject
        text: root.sliceString(text_subject, 40)
        anchors.right: parent.right
        anchors.rightMargin: 24
        anchors.top: parent.top
        anchors.topMargin: 10
        font.family: fontDroidKufiBold.name
        font.weight: Font.Bold
        font.pixelSize: 24
        color: "#5a5a5a"
    }

    Rectangle
    {
        id: split_line
        width: 940
        height: 1
        anchors.right: label_subject.right
        anchors.top: label_subject.bottom
        anchors.topMargin: 9
        color: "#646464"
    }

    Rectangle
    {
        id: rect_user
        width: 111
        height: width
        anchors.right: label_subject.right
        anchors.top: split_line.bottom
        color: "#c8c8c8"
        border.width: 1
        border.color: "#bebebe"

        Text
        {
            id: icon_user
            anchors.top: parent.top
            anchors.topMargin: 17
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
            text: root.sliceString(text_username, 7)
            font.family: fontRobotoRegular.name
            font.pixelSize: 22
            color: "#5a5a5a"
        }

    }

    Text
    {
        id: label_name
        text: text_name
        anchors.right: rect_user.left
        anchors.rightMargin: 34
        anchors.top: split_line.bottom
        anchors.topMargin: 7
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 20
        color: "#5a5a5a"
    }

    Text
    {
        id: label_email
        text: "(" +  text_username + "@" + root.domain + ")"
        anchors.right: label_name.left
        anchors.rightMargin: 19
        anchors.top: split_line.bottom
        anchors.topMargin: 13
        font.family: fontRobotoRegular.name
        font.pixelSize: 18
        color: "#5a5a5a"
    }

    Text
    {
        id: label_time
        text: root.en2ar(text_time)
        anchors.top: split_line.bottom
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.leftMargin: 322
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 15
        color: "#646464"
    }

    Rectangle
    {
        id: rect_download
        width: childrenRect.width
        height: childrenRect.height
        anchors.left: parent.left
        anchors.leftMargin: 41
        anchors.top: split_line.bottom
        anchors.topMargin: 16
        color: "transparent"

        Text
        {
            id: icon_download
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 6
            text: "\uf078"
            font.family: fontAwesomeSolid.name
            font.pixelSize: 12
            color: "#3c598c"
        }


        Text
        {
            id: label_download
            anchors.left: icon_download.right
            anchors.leftMargin: 10
            anchors.top: parent.top
            text: qsTr("تحميل")
            font.family: fontDroidKufiBold.name
            font.weight: Font.Bold
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
        text: qsTr("الى: ") + text_to
        anchors.right: label_name.right
        anchors.top: label_name.bottom
        anchors.topMargin: -1
        font.family: fontDroidKufiRegular.name
        font.weight: Font.Normal
        font.pixelSize: 12
        color: "#646464"
    }

    HhmTable
    {
        id: table
        anchors.top: rect_user.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        tableMode: con.hhm_TABLE_MODE_CONTENT
    }

    function getDataContent()
    {
        return table.getDataContent()
    }

}
