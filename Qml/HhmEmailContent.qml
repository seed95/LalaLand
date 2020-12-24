import QtQuick 2.0

Item
{

    property string text_name: "Cassie Hicks"
    property int    doc_status: 1
    property string text_user: "User #1"
    property string text_username: "Amy E. Alberts."
    property string text_email: "amy.alberts@lolo.com"
    property string text_time: "12:15PM"
    property string text_to: "April Robegan, Jamie Reading"

    Text
    {
        id: label_name
        text: text_name
        font.family: fontRobotoRegular.name
        font.pixelSize: 36
        anchors.left: parent.left
        anchors.leftMargin: 22 * scale_width
        anchors.topMargin: 4 * scale_height
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
                if( doc_status===1 )
                {
                    "#377d42"
                }
                else if( doc_status===2 )
                {
                    "#5a5a5a"
                }
                else if( doc_status===3 )
                {
                    "#cc3333"
                }
            }
        }
    }

    Rectangle
    {
        id: split_line
        anchors.left: label_name.left
        anchors.leftMargin: 3 * scale_width
        anchors.top: label_name.bottom
        anchors.topMargin: 13 * scale_height
        width: 940 * scale_width
        height: 1
        color: "#646464"
    }

    Rectangle
    {
        id: rect_user
        width: 111 * scale_width
        height: width
        anchors.left: label_name.left
        anchors.leftMargin: 3 * scale_width
        anchors.top: split_line.bottom
        anchors.topMargin: -1 * scale_height
        color: "#c8c8c8"
        border.width: 1
        border.color: "#bebebe"

        Text
        {
            id: icon_user
            anchors.top: parent.top
            anchors.topMargin: 16 * scale_height
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
            anchors.bottomMargin: 12 * scale_height
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
        height: 90 * scale_height
        anchors.left: rect_user.right
        anchors.right: split_line.right
        anchors.top: split_line.bottom
        color: "transparent"

        Text
        {
            id: label_username
            text: text_username
            anchors.left: parent.left
            anchors.leftMargin: 34 * scale_width
            anchors.top: parent.top
            anchors.topMargin: 9 * scale_height
            font.family: fontRobotoRegular.name
            font.pixelSize: 25
            color: "#5a5a5a"
        }

        Text
        {
            id: label_email
            text: "(" +  text_email + ")"
            anchors.left: label_username.right
            anchors.leftMargin: 6 * scale_width
            anchors.top: parent.top
            anchors.topMargin: 9 * scale_height
            font.family: fontRobotoRegular.name
            font.pixelSize: 25
            color: "#5a5a5a"
        }

        Text
        {
            id: label_time
            text: text_time
            anchors.top: parent.top
            anchors.topMargin: 19 * scale_height
            anchors.right: parent.right
            anchors.rightMargin: 169 * scale_width
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
            anchors.rightMargin: 25 * scale_width
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
                anchors.leftMargin: 7 * scale_width
                anchors.top: parent.top
                anchors.topMargin: 2 * scale_height
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
                    console.log("Download pdf")
                }
            }

        }

        Text
        {
            id: label_to
            text: "To: " + text_to
            anchors.left: label_username.left
            anchors.top: label_username.bottom
            anchors.topMargin: 4 * scale_height
            font.family: fontRobotoRegular.name
            font.pixelSize: 18
            color: "#646464"
        }

    }

}
