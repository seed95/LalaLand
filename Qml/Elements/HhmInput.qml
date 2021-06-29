import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle
{
    property color color_background: "#E6E6E6"
    property string text_label: "From"
    property string font_name_label:
    {
        if( root.rtl )
        {
            fontArialRegular.name
        }
        else
        {
            fontRobotoRegular.name
        }
    }
    property int    font_weight_label: Font.Normal
    property int    font_size_label: 22

    property string subject_placeholder: "وظيفة"
    property string text_val: ""
    property string font_name_input_box: fontDroidKufiRegular.name
    property int    font_weight_input_box: Font.Normal
    property int    font_size_input_box: 12

    property int    left_margin: 30

    property string auto_complete_text: ""
    property int    textAlign: TextInput.AlignRight

    property bool isEnabled:    false
    property bool isError:      false

    signal inputChanged(string text)
    signal enterPressed(string text)

    id: rect_input_rtl
    height: 25
    color: color_background
    border.width: 1.5
    border.color:
                {
                    if( isError===true )
                    {
                        "#EA7E7E"
                    }
                    else
                    {
                        "#969696"
                    }
                }

    radius: 5

    TextField
    {
        id: input

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right

        font.family: font_name_input_box
        font.pixelSize: font_size_input_box
        selectByMouse: true
        enabled: true
        text: subject_placeholder
        horizontalAlignment: textAlign
        width: parent.width
        background: Rectangle
                    {
                        color: "transparent"
                    }

        color:
        {
            if( text===subject_placeholder )
            {
                "#828282"
            }
            else
            {
                "#505050"
            }
        }

        selectedTextColor: "#222"
        selectionColor: "#888"

        onTextChanged:
                     {
                         text_val = text;
                     }
        onFocusChanged:
        {
            if( focus )
            {
                if( text===subject_placeholder )
                {
                    text = ""
                }
            }
            else
            {
                if( text==="" )
                {
                    text = subject_placeholder
                }
            }
        }
        onAccepted:
        {
            focus = false
        }

        Keys.onEscapePressed:
        {
            focus = false;
            text = subject_placeholder;
            isError = false;
        }

        Keys.onEnterPressed:
        {
            dataEntered();
        }

        Keys.onReturnPressed:
        {
            dataEntered();
        }
    }


    function getInput()
    {
        var obj = input
        if( input.text===subject_placeholder )
        {
            return "";
        }
        return obj.text
    }

    function setInput(text)
    {
        input.text = text
    }

    function dataEntered()
    {
        if( getInput()==="" )
        {
            isError = true;
        }
        else
        {
            isError = false;
            enterPressed(input.text);
        }
    }
}

