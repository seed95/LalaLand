import QtQuick 2.0
import QtQuick.Controls 2.5

Item
{
    property bool isError:      false

    property int    width_label:        85
    property string text_label:         "من"
    property string font_name_label:    fontRobotoRegular.name
    property int    font_weight_label:  Font.Normal
    property int    font_size_label:    22

    property bool   enable_input:           false
    property int    width_input:            500
    property string placeholder_input:      "الموضوع المراسلة"
    property string auto_complete_input:    ""
    property string font_name_input:        fontRobotoRegular.name
    property int    font_weight_input:      Font.Normal
    property int    font_size_input:        18
    property int    align_input:            TextInput.AlignLeft

    property color color_input_normal:      "#464646"
    property color color_input_placeholder: "#828282"
    property color color_input_error:       "#e08888"

    property color color_border_normal: "#aaaaaa"
    property color color_border_error:  "#e08888"
    property color color_border:
    {
        if( isError )
        {
            color_border_error
        }
        else
        {
            color_border_normal
        }
    }

    property color color_background_enabled: "#f0f0f0"
    property color color_background_disabled: "#dcdcdc"
    property color color_background:
    {
        if( enable_input )
        {
            color_background_enabled
        }
        else
        {
            color_background_disabled
        }
    }

    signal inputChanged(string text)

    height: 30
    width: childrenRect.width

    onVisibleChanged:
    {
        input_text.text = placeholder_input
        input_text.color = color_input_placeholder
    }

    Rectangle
    {
        id: rect_input
        width: width_input
        height: parent.height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: color_background
        border.width: 1
        border.color: color_border
        radius: 5

        TextField
        {
            id: input_text
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.right: parent.right
            anchors.rightMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: align_input
            text: placeholder_input
            font.family: font_name_input
            font.weight: font_weight_input
            font.pixelSize: font_size_input
            selectByMouse: true
            enabled: enable_input
            background: Rectangle
            {
                color: "transparent"
            }
            color: color_input_placeholder
            selectedTextColor: "#222"
            selectionColor: "#888"

            onAccepted:
            {
                focus = false
            }

            onFocusChanged:
            {
                if( focus )
                {
                    isError = false
                    if( text===placeholder_input )
                    {
                        text = ""
                    }
                    else
                    {
                        selectAll()
                    }

                    color = color_input_normal
                }
                else
                {
                    if( text==="" )
                    {
                        text = placeholder_input
                        color = color_input_placeholder
                    }
                    else if( text!==placeholder_input )
                    {
                        completeText()
                        inputChanged(input_text.text)
                    }
                }
            }

            Keys.onEscapePressed:
            {
                focus = false
            }

            Keys.onTabPressed:
            {
                completeText()
            }

            function completeText()
            {
                if( text!=="" )
                {
                    var index_atsign = text.indexOf("@");
                    if( index_atsign!==-1 )
                    {
                        text = text.slice(0, index_atsign)
                    }
                    text += auto_complete_input
                }
            }

        }

    }

    Item
    {
        id: rect_label
        width: width_label
        height: parent.height
        anchors.left: rect_input.right

        Text
        {
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -2
            text: text_label + ":"
            font.family: font_name_label
            font.weight: font_weight_label
            font.pixelSize: font_size_label
            color: "#646464"
        }

    }

    function usernameNotFound()
    {
        isError = true
        input_text.color = color_input_error
    }

    function getInput()
    {
        var result = input_text.text
        if( input_text.text===placeholder_input )
        {
            return ""
        }
        return input_text.text
    }

}
