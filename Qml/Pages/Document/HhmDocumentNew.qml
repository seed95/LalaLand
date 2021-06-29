import QtQuick 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.5

Rectangle
{
    id: container

    //Set this variables in cpp
    property int    new_casenumber:         0  //When click on new button to create new document get new casenumber from data base
    property int    receiver_id:            -1  //Id user for receive document
    property string receiver_username:      ""  //Username for receive document

    //Cpp Signals
    signal checkUsername(string username)
    signal uploadFileClicked()
    signal sendNewDocument(int caseNumber, variant toData,
                           string subject, variant attachFiles,
                           string tableContent)

    width: 980
    height: 675
    color: "#dcdcdc"

    onVisibleChanged:
    {
        receiver_id = -1
        receiver_username = ""
    }

    Rectangle
    {
        id: rect_top
        width: parent.width
        height: 150
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#dcdcdc"

        HhmDocumentInput
        {
            id: text_input_from
            anchors.right: parent.right
            anchors.rightMargin: 34
            anchors.top: parent.top
            anchors.topMargin: 22

            enable_input: false
            width_input: 500
            placeholder_input: root.username + "@" + root.domain
            font_name_input: fontRobotoRegular.name
            font_weight_input: Font.Normal
            font_size_input: 15
            align_input: TextInput.AlignLeft

            text_label: qsTr("من")
            font_name_label: fontDroidKufiRegular.name
            font_size_label: 17
        }

        HhmDocumentInput
        {
            id: text_input_to
            anchors.right: text_input_from.right
            anchors.top: text_input_from.bottom
            anchors.topMargin: 10

            enable_input: true
            width_input: 500
            placeholder_input: root.username + "@" + root.domain
            auto_complete_input: "@" + root.domain
            font_name_input: fontRobotoRegular.name
            font_weight_input: Font.Normal
            font_size_input: 15
            align_input: TextInput.AlignLeft

            text_label: qsTr("الى")
            font_name_label: fontDroidKufiRegular.name
            font_size_label: 17

            onInputChanged:
            {
                container.checkUsername(text.replace(auto_complete_input, ""))
            }
        }

        HhmDocumentInput
        {
            id: text_input_casenumber
            anchors.top: text_input_to.top
            anchors.right: text_input_to.left
            anchors.rightMargin: 54

            enable_input: false
            width_input: 150
            placeholder_input: root.en2ar(container.new_casenumber)
            font_name_input: fontRobotoRegular.name
            font_weight_input: Font.Normal
            font_size_input: 15
            align_input: TextInput.AlignRight

            text_label: qsTr("رقم الارسال")
            width_label: 116
            font_name_label: fontDroidKufiRegular.name
            font_size_label: 17
        }

        HhmDocumentInput
        {
            id: text_input_subject
            anchors.right: text_input_from.right
            anchors.top: text_input_to.bottom
            anchors.topMargin: 10

            enable_input: true
            width_input: 820
            placeholder_input: "الموضوع المراسلة"
            font_name_input: fontRobotoRegular.name
            font_weight_input: Font.Normal
            font_size_input: 15
            align_input: TextInput.AlignRight

            text_label: qsTr("الموضوع")
            font_name_label: fontDroidKufiRegular.name
            font_size_label: 17
        }

    }

    Rectangle
    {
        id: rect_middle
        width: parent.width
        color: "#e6e6e6"
        anchors.left: parent.left
        anchors.top: rect_top.bottom
        anchors.bottom:
        {
            if( attachbar.visible )
            {
                attachbar.top
            }
            else
            {
                parent.bottom
            }
        }
    }

    Flickable
    {
        id: flickable_container
        width: rect_middle.width
        height: rect_middle.height
        anchors.left: rect_middle.left
        anchors.top: rect_middle.top
        anchors.topMargin: 1
        contentHeight: canvas_upload.height + canvas_upload.y
        flickableDirection: Flickable.VerticalFlick
        clip: true

        HhmTable
        {
            id: table
            anchors.top: parent.top
            anchors.topMargin: 21
            anchors.horizontalCenter: parent.horizontalCenter
            tableMode: con.hhm_TABLE_MODE_NEW
        }

        Canvas
        {
            id: canvas_upload
            width: 666
            height: 200
            anchors.top: table.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter

            onPaint:
            {
                var ctx = getContext("2d")

                ctx.beginPath()
                ctx.moveTo(0, 0)
                ctx.lineTo(canvas_upload.width, 0)
                ctx.lineTo(canvas_upload.width, canvas_upload.height)
                ctx.lineTo(0, canvas_upload.height)
                ctx.lineTo(0, 0)
                ctx.closePath()
                ctx.lineWidth = 3
                ctx.strokeStyle = "#666666"
                ctx.setLineDash([3, 2])
                ctx.stroke()

            }

            Rectangle
            {
                id: rect_upload
                width: 215
                height: 145
                anchors.centerIn: parent
                color: "transparent"

                Text
                {
                    id: icon_upload
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "\uf382"
                    font.family: fontAwesomeSolid.name
                    font.pixelSize: 80
                    color: "#808080"
                }

                Text
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: icon_upload.bottom
                    text: "ارسال المستند"
                    font.family: fontDroidKufiRegular.name
                    font.pixelSize: 40
                    color: "#808080"
                }

            }

            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked:
                {
                    container.forceActiveFocus()
                    container.uploadFileClicked()
                }
            }

        }

    }

    HhmAttachmentBar
    {
        id: attachbar
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        attachMode: con.hhm_ATTACHMENT_UPLOAD_MODE
        objectName: "DocumentNewAttachbar"
    }

    /*** Call this functions from cpp ***/
    function usernameNotFound()
    {
        text_input_to.usernameNotFound()
    }

    function sendDocument()
    {
        var toData = []
        toData.push(container.receiver_id)
        toData.push(container.receiver_username)
        sendNewDocument(container.new_casenumber, toData,
                        text_input_subject.getInput(),
                        attachbar.getAttachFiles(),
                        table.getData())
    }

}
