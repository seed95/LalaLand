import QtQuick 2.0

Item
{

    property int tableMode: con.hhm_TABLE_NEW_MODE

    width: 584
    height: childrenRect.height

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
            isEnabled: tableMode===con.hhm_TABLE_NEW_MODE
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
            right_margin_input: 13
            width_input: 168
            isEnabled: tableMode===con.hhm_TABLE_NEW_MODE
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
            isEnabled: tableMode===con.hhm_TABLE_NEW_MODE
        }

        HhmDateInputTable
        {
            id: send_date
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            text_label: "تاريخ الصادر"
            left_margin_label: 26
            isEnabled: tableMode===con.hhm_TABLE_NEW_MODE
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
            isEnabled: tableMode===con.hhm_TABLE_VIEW_INBOX_MODE
        }

        HhmDateInputTable
        {
            id: receive_date
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 25
            anchors.verticalCenter: parent.verticalCenter
            text_label: "تاريخ الوارد"
            left_margin_label: 28
            isEnabled: tableMode===con.hhm_TABLE_VIEW_INBOX_MODE
        }

    }

    function getDataContent()
    {
        var result = ""
        var number = root.ar2en(receive_number.getInput())
        if( number==="" )
        {
            result += "-1,"
        }
        else
        {
            result += number + ","
        }
        result += receive_date.getDate()
        return result
    }

    //https://download.qt.io/archive/qt/5.13/5.13.1/
    function getDataNew()
    {
        var result = subject_doc.getInput() + ","
        result += content_doc.getInput() + ","
        var number = root.ar2en(send_number.getInput())
        if( number==="" )
        {
            result += "-1,"
        }
        else
        {
            result += number + ","
        }
        result += send_date.getDate()
        return result
    }

    function getData()
    {
        var result = subject_doc.getInput() + ","
        result += content_doc.getInput() + ","
        var number = root.ar2en(send_number.getInput())
        if( number==="" )
        {
            result += "-1,"
        }
        else
        {
            result += number + ","
        }
        result += send_date.getDate() + ","
        number = root.ar2en(receive_number.getInput())
        if( number==="" )
        {
            result += "-1,"
        }
        else
        {
            result += number + ","
        }
        result += receive_date.getDate()
        return result
    }

    function setData(data)
    {
        if( data==="" )
        {
            subject_doc.setInput("")
            content_doc.setInput("")
            send_number.setInput("")
            send_date.setDate("")
            receive_number.setInput("")
            receive_date.setDate("")
            return
        }
        var split_data = data.split(",")
        subject_doc.setInput(split_data[0])
        content_doc.setInput(split_data[1])
        if( split_data[2]==="-1" )
        {
            send_number.setInput("-")
        }
        else
        {
            send_number.setInput(root.en2ar(split_data[2]))
        }
        send_date.setDate(split_data[3])
        if( split_data[4]==="-1" )
        {
            receive_number.setInput("")
        }
        else
        {
            receive_number.setInput(root.en2ar(split_data[4]))
        }
        split_data[5] = split_data[5].toString().replace(/-/g, "-1")
        receive_date.setDate(split_data[5])
    }

}
