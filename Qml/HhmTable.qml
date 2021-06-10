import QtQuick 2.0

Item
{

    width: 584
    height: childrenRect.height

    property bool tableReadOnly: false

    Rectangle
    {
        id: title
        width: parent.width
        height: 25
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#464646"

        Text
        {
            text: "ملخص الملف"
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -1
            anchors.right: parent.right
            anchors.rightMargin: 25
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
            color: "#dcdcdc"
        }

    }

    Rectangle
    {
        id: row1
        width: parent.width
        height: 25
        anchors.top: title.bottom
        anchors.left: parent.left
        color: "#bebebe"

        HhmInputTable
        {
            id: subject_doc
            width: 245
            height: parent.height
            anchors.right: parent.right
            anchors.rightMargin: 23
            anchors.verticalCenter: parent.verticalCenter
            text_label: "موضوع الكتاب"
            right_margin_input: 32
            width_input: 125
            isEnabled: tableReadOnly
        }

        HhmInputTable
        {
            id: content_doc
            width: 275
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            text_label: "مضمون الكتاب"
            right_margin_input: 15
            width_input: 168
            isEnabled: tableReadOnly
        }
    }

    Rectangle
    {
        id: row2
        width: parent.width
        height: 25
        anchors.top: row1.bottom
        anchors.left: parent.left
        color: "#d2d2d2"

        HhmInputTable
        {
            id: send_number
            width: 235
            height: parent.height
            anchors.right: parent.right
            anchors.rightMargin: 37
            anchors.verticalCenter: parent.verticalCenter
            text_label: "عدد الصادر"
            right_margin_input: 41
            width_input: 125
            isNumber: true
            isEnabled: tableReadOnly
        }

        HhmDateInputTable
        {
            id: send_date
            width: 242
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 45
            anchors.verticalCenter: parent.verticalCenter
            text_label: "تاريخ الصادر"
            right_margin_input: 48
            width_input: 33
            isEnabled: tableReadOnly
        }

    }

    Rectangle
    {
        id: row3
        width: parent.width
        height: 25
        anchors.top: row2.bottom
        anchors.left: parent.left
        color: "#bebebe"

        HhmInputTable
        {
            id: receive_number
            width: 232
            height: parent.height
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            text_label: "عدد الوارد"
            right_margin_input: 42
            width_input: 125
            isNumber: true
            isEnabled: tableReadOnly
        }

        HhmDateInputTable
        {
            id: receive_date
            width: 240
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 45
            anchors.verticalCenter: parent.verticalCenter
            text_label: "تاريخ الوارد"
            right_margin_input: 50
            width_input: 33
            isEnabled: tableReadOnly
        }

    }

    //Return table data with csv format
    function getContent()
    {
        var result = subject_doc.getInput() + ","
        result += content_doc.getInput() + ","
        result += root.ar2en(send_number.getInput()) + ","
        result += send_date.getDate() + ","
        result += root.ar2en(receive_number.getInput()) + ","
        result += receive_date.getDate()
        return result
    }

    function setContent(content)
    {
        var split_content = content.split(",")
        subject_doc.setInput(split_content[0])
        content_doc.setInput(split_content[1])
        send_number.setInput(root.en2ar(split_content[2]))
        send_date.setDate(split_content[3])
        receive_number.setInput(root.en2ar(split_content[4]))
        receive_date.setDate(split_content[5])
    }

}
