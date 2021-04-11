import QtQuick 2.0

Item
{

    property string text_from: "User"
    property string text_to: "Admin"
    property string text_subject: "Subject"
    property string text_case_number: "1245"
    property string text_file_path: ""


    Item
    {
        id: rect_input_box_rtl
        width: parent.width
        height: 160
        anchors.right: parent.right
        anchors.top: parent.top
        visible: root.rtl

        HhmInputBox
        {
            id: from_input_box_rtl
            width: 555
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: parent.top
            anchors.topMargin: 18
            width_box: 500
            text_label: "از:"
            text_input_box: text_from
            left_margin: 50
        }

        HhmInputBox
        {
            id: to_input_box_rtl
            width: 555
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: from_input_box_rtl.bottom
            width_box: 500
            text_label: "به:"
            text_input_box: text_to
            left_margin: 50
        }

        HhmInputBox
        {
            id: case_number_input_box_rtl
            width: 200
            height: 40
            anchors.top: to_input_box_rtl.top
            anchors.right: to_input_box_rtl.left
            anchors.rightMargin: 60
            width_box: 150
            isEnabled: true
            isNumber: true
            text_label: "شماره پرونده:"
            text_input_box: text_case_number
            left_margin: 15
        }

        HhmInputBox
        {
            id: subject_input_box_rtl
            width: 875
            height: 40
            anchors.top: to_input_box_rtl.bottom
            anchors.right: parent.right
            anchors.rightMargin: 50
            width_box: 820
            isEnabled: true
            text_label: "موضوع:"
            text_input_box: text_subject
            left_margin: 10
        }

    }

    Item
    {
        id: rect_input_box
        width: parent.width
        height: 160
        anchors.left: parent.left
        anchors.top: parent.top
        visible: !root.rtl

        HhmInputBox
        {
            id: from_input_box
            width: 555
            height: 40
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 50
            anchors.topMargin: 18
            width_box: 500
            text_label: "From:"
            text_input_box: text_from
            left_margin: 29
        }

        HhmInputBox
        {
            id: to_input_box
            width: 555
            height: 40
            anchors.left: parent.left
            anchors.top: from_input_box.bottom
            anchors.leftMargin: 51
            width_box: 500
            text_label: "To:"
            text_input_box: text_to
            left_margin: 50
        }

        HhmInputBox
        {
            id: case_number_input_box
            width: 200
            height: 40
            anchors.left: to_input_box.right
            anchors.top: to_input_box.top
            anchors.leftMargin: 60
            width_box: 150
            isEnabled: true
            isNumber: true
            text_label: "Case Number:"
            text_input_box: text_case_number
            left_margin: 15
        }

        HhmInputBox
        {
            id: subject_input_box
            width: 875
            height: 40
            anchors.top: to_input_box.bottom
            anchors.left: parent.left
            anchors.leftMargin: 51
            width_box: 820
            isEnabled: true
            text_label: "Subject:"
            text_input_box: text_subject
            left_margin: 10
        }

    }

    Canvas
    {
        id: canvas_upload
        width: 702
        height: 502
        anchors.top: rect_input_box.bottom
        anchors.left: parent.left
        anchors.leftMargin: 181

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
                text: "Upload File"
                font.family: fontRobotoMedium.name
                font.pixelSize: 40
                color: "#808080"
            }

        }

        Text
        {
            id: label_file
            text: text_file_path
            font.family: fontRobotoRegular.name
            font.pixelSize: 20
            color: "#808080"
            anchors.centerIn: parent
            visible: false
        }

        MouseArea
        {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked:
            {
                root.uploadFileClicked()
            }
        }

    }

    function getCaseNumber()
    {
        var obj = case_number_input_box
        if( root.rtl )
        {
            obj = case_number_input_box_rtl
        }

        var case_number_text = obj.getInput()
        var persian_numbers = [/۰/g, /۱/g, /۲/g, /۳/g, /۴/g, /۵/g, /۶/g, /۷/g, /۸/g, /۹/g]
        var arabic_numbers  = [/٠/g, /١/g, /٢/g, /٣/g, /٤/g, /٥/g, /٦/g, /٧/g, /٨/g, /٩/g]
        for(var i=0; i<10; i++)
        {
            case_number_text = case_number_text.replace(persian_numbers[i], i).replace(arabic_numbers[i], i)
        }

        return case_number_text
    }

    function getSubject()
    {
        var obj = subject_input_box
        if( root.rtl )
        {
            obj = subject_input_box_rtl
        }
        return obj.getInput()
    }

    function showSelectedFile()
    {
        rect_upload.visible = false
        label_file.visible = true
        text_file_path = root.selected_file_path
    }

    function compeleteItems()
    {
        if( text_file_path==="" )
        {
            root.error_msg = "Please choose a document"
            root.d_error_msg = 2000
            root.showMessage()
            return false
        }

        if( getSubject()===text_subject )
        {
            root.error_msg = "Please write a subject"
            root.d_error_msg = 2000
            root.showMessage()
            return false
        }

        if( getCaseNumber()===text_case_number )
        {
            root.error_msg = "Please write a case number"
            root.d_error_msg = 2000
            root.showMessage()
            return false
        }

        return true
    }

}
