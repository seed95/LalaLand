import QtQuick 2.0
import QtQuick.Controls 2.5

Item
{
    property string text_label:         "تاريخ الصادر"
    property string font_name_label:    fontDroidKufiRegular.name

    property int    right_margin_input: 32
    property int    width_input:        33

    property string text_input_day:         "يوم"
    property string text_input_month:       "شهر"
    property string text_input_year:        "سنة"
    property string font_name_input:    fontDroidKufiRegular.name

    property string text_color: "#464646"

    property bool isEnabled: true

    Text
    {
        id: id_label
        text: text_label
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font.family: font_name_label
        font.pixelSize: 15
        color: text_color
    }

    Rectangle
    {
        id: id_day
        width: width_input
        anchors.right: id_label.left
        anchors.rightMargin: right_margin_input
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        color: "#e6e6e6"
        border.color: "#969696"
        border.width: 1
        radius: 4

        TextField
        {
            id: id_input_day
            width: width_input + 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 1
            font.family: font_name_input
            font.pixelSize: 11
            selectByMouse: true
            readOnly: isEnabled
            text: text_input_day
            horizontalAlignment: TextInput.AlignRight
            background: Rectangle
            {
                color: "transparent"
            }
            color:
            {
                if( text==="" || text===text_input_day )
                {
                    "#868686"
                }
                else
                {
                    text_color
                }
            }
            selectedTextColor: "#222"
            selectionColor: "#888"
            validator: RegExpValidator
            {
                regExp: /[0-9۰-۹٠-٩]{2}/
            }

            onAccepted:
            {
                focus = false
            }

            onFocusChanged:
            {
                if( focus )
                {
                    if( text===text_input_day && !readOnly )
                    {
                        text = ""
                    }
                }
                else
                {
                    if( text==="" )
                    {
                        text = text_input_day
                    }
                }
            }

            Keys.onEscapePressed:
            {
                focus = false
            }

            Keys.onTabPressed:
            {
            }

        }
    }

    Text
    {
        id: split1
        anchors.right: id_day.left
        anchors.rightMargin: 3
        text: "/"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
        color: text_color
    }

    Rectangle
    {
        id: id_month
        width: width_input
        anchors.right: split1.left
        anchors.rightMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        color: "#e6e6e6"
        border.color: "#969696"
        border.width: 1
        radius: 4

        TextField
        {
            id: id_input_month
            width: width_input + 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 1
            font.family: font_name_input
            font.pixelSize: 11
            selectByMouse: true
            readOnly: isEnabled
            text: text_input_month
            horizontalAlignment: TextInput.AlignRight
            background: Rectangle
            {
                color: "transparent"
            }
            color:
            {
                if( text==="" || text===text_input_month )
                {
                    "#868686"
                }
                else
                {
                    text_color
                }
            }
            selectedTextColor: "#222"
            selectionColor: "#888"
            validator: RegExpValidator
            {
                regExp: /[0-9۰-۹٠-٩]{2}/
            }

            onAccepted:
            {
                focus = false
            }

            onFocusChanged:
            {
                if( focus )
                {
                    if( text===text_input_month )
                    {
                        text = ""
                    }
                }
                else
                {
                    if( text==="" )
                    {
                        text = text_input_month
                    }
                }
            }

            Keys.onEscapePressed:
            {
                focus = false
            }

            Keys.onTabPressed:
            {
            }

        }
    }

    Text
    {
        id: split2
        anchors.right: id_month.left
        anchors.rightMargin: 3
        text: "/"
        font.family: fontDroidKufiRegular.name
        font.pixelSize: 15
        color: text_color
    }

    Rectangle
    {
        id: id_year
        width: width_input
        anchors.right: split2.left
        anchors.rightMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        color: "#e6e6e6"
        border.color: "#969696"
        border.width: 1
        radius: 4


        TextField
        {
            id: id_input_year
            width: width_input + 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 1
            font.family: font_name_input
            font.pixelSize: 11
            selectByMouse: true
            readOnly: isEnabled
            text: text_input_year
            horizontalAlignment: TextInput.AlignRight
            background: Rectangle
            {
                color: "transparent"
            }
            color:
            {
                if( text==="" || text===text_input_year )
                {
                    "#868686"
                }
                else
                {
                    text_color
                }
            }
            selectedTextColor: "#222"
            selectionColor: "#888"
            validator: RegExpValidator
            {
                regExp: /[0-9۰-۹٠-٩]{4}/
            }

            onAccepted:
            {
                focus = false
            }


            onFocusChanged:
            {
                if( focus )
                {
                    if( text===text_input_year )
                    {
                        text = ""
                    }
                }
                else
                {
                    if( text==="" )
                    {
                        text = text_input_year
                    }
                }
            }

            Keys.onEscapePressed:
            {
                focus = false
            }

            Keys.onTabPressed:
            {
            }

        }
    }

    function getDate()
    {
        var result = root.ar2en(id_input_year.text) + "/"
        result += root.ar2en(id_input_month.text) + "/"
        result += root.ar2en(id_input_day.text)
        return result
    }

    function setDate(date)
    {
        var split_date = date.split("/")
        if( split_date.length===3 )
        {
            id_input_year.text = root.en2ar(split_date[0])
            id_input_month.text = root.en2ar(split_date[1])
            id_input_day.text = root.en2ar(split_date[2])
        }
        else
        {
            id_input_year.text = text_input_year
            id_input_month.text = text_input_month
            id_input_day.text = text_input_day
        }
    }

}
