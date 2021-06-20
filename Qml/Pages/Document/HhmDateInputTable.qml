import QtQuick 2.0
import QtQuick.Controls 2.5

Item
{
    property string text_label:         "تاريخ الصادر"
    property int    left_margin_label:  32
    property string font_name_label:    fontDroidKufiRegular.name

    property string text_color: "#464646"

    property bool isEnabled: true

    HhmDateFieldInput
    {
        id: id_year
        height: parent.height
        width: 48
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        text_input: "سنة"
        isReadOnly: !isEnabled
        min_number: 1400
        max_number: 1500
        regex_input: /[0-9۰-۹٠-٩]{4}/
        color_input: text_color
    }

    Text
    {
        id: split1
        anchors.left: id_year.right
        anchors.leftMargin: 3
        text: "/"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
        color: text_color
    }

    HhmDateFieldInput
    {
        id: id_month
        height: parent.height
        width: 48
        anchors.left: split1.right
        anchors.leftMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        text_input: "شهر"
        isReadOnly: !isEnabled
        min_number: 1
        max_number: 12
        regex_input: /[0-9۰-۹٠-٩]{2}/
        color_input: text_color
    }

    Text
    {
        id: split2
        anchors.left: id_month.right
        anchors.leftMargin: 3
        text: "/"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
        color: text_color
    }

    HhmDateFieldInput
    {
        id: id_day
        height: parent.height
        width: 48
        anchors.left: split2.right
        anchors.leftMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        text_input: "يوم"
        isReadOnly: !isEnabled
        min_number: 1
        max_number: 30
        regex_input: /[0-9۰-۹٠-٩]{2}/
        color_input: text_color
    }

    Text
    {
        id: id_label
        text: text_label
        anchors.left: id_day.right
        anchors.leftMargin: left_margin_label
        anchors.verticalCenter: parent.verticalCenter
        font.family: font_name_label
        font.pixelSize: 15
        color: text_color
    }

    function getDate()
    {
        var result = root.ar2en(id_year.getInput()) + "/"
        result += root.ar2en(id_month.getInput()) + "/"
        result += root.ar2en(id_day.getInput())
        return result
    }

    function setDate(date)
    {
        var split_date = date.split("/")
        if( split_date.length===3 )
        {
            if( split_date[0]==="-1" )
            {
                id_year.clearInput()
            }
            else
            {
                id_year.setInput(root.en2ar(split_date[0]))
            }

            if( split_date[1]==="-1" )
            {
                id_month.clearInput()
            }
            else
            {
                id_month.setInput(root.en2ar(split_date[1]))
            }

            if( split_date[2]==="-1" )
            {
                id_day.clearInput()
            }
            else
            {
                id_day.setInput(root.en2ar(split_date[2]))
            }
        }
        else
        {
            id_year.clearInput("-")
            id_month.clearInput("-")
            id_day.clearInput("-")
        }
    }

}
