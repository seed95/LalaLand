import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle
{
    property string text_input:         "يوم"
    property string color_input:        ""
    property string font_name:    fontDroidKufiRegular.name

    property bool   isReadOnly: false
    property int    max_number: 30
    property int    min_number: 1
    property var    regex_input: /[0-9۰-۹٠-٩]{4}/

    color:
    {
        if( isReadOnly )
        {
            "#dcdcdc"
        }
        else
        {
            "#e6e6e6"
        }
    }
    border.color: "#969696"
    border.width: 1
    radius: 4

    TextField
    {
        id: id_input
        width: parent.width
        anchors.right: parent.right
        anchors.rightMargin: 1
        anchors.verticalCenter: parent.verticalCenter
        font.family: font_name
        font.pixelSize: 13
        selectByMouse: true
        readOnly: isReadOnly
        text: text_input
        horizontalAlignment: TextInput.AlignRight
        background: Rectangle
        {
            color: "transparent"
        }
        color:
        {
            if( text==="" || text===text_input )
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
            regExp: regex_input
        }

        onAccepted:
        {
            focus = false
        }

        onFocusChanged:
        {
            if( focus )
            {
                if( text===text_input )
                {
                    if( !isReadOnly )
                    {
                        text = ""
                    }
                }
            }
            else
            {
                if( text==="" )
                {
                    text = text_input
                }
                else if( text!=="-" && text!==text_input )
                {
                    var en_input = root.ar2en(text)
                    var int_input = parseInt(en_input)
                    if( int_input!==NaN )
                    {
                        if( int_input<min_number )
                        {
                            int_input = min_number
                        }
                        if( int_input>max_number )
                        {
                            int_input = max_number
                        }
                        text = root.en2ar(int_input.toString())
                    }
                }
            }
        }

        onTextChanged:
        {
            text = root.en2ar(text)
        }

        Keys.onEscapePressed:
        {
            focus = false
        }

    }

    function getInput()
    {
        if( id_input.text==="" || id_input.text===text_input )
        {
            return "-"
        }
        else
        {
            return id_input.text
        }

    }

    function setInput(text)
    {
        id_input.text = text
    }

    function clearInput()
    {
        id_input.text = text_input
    }
}
