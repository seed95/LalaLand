import QtQuick 2.0
import QtQuick.Controls 2.5

Item
{
    property string text_label:         "موضوع الكتاب"
    property string font_name_label:    fontDroidKufiRegular.name

    property string text_input:         ""
    property string font_name_input:    fontDroidKufiRegular.name
    property int    right_margin_input: 32
    property int    width_input:        125

    property bool isEnabled: true
    property bool isNumber: false

    Text
    {
        id: id_label
        text: text_label
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        font.family: font_name_label
        font.pixelSize: 15
        color: "#464646"
    }

    Rectangle
    {
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
            id: id_input
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            anchors.right: parent.right
            anchors.rightMargin: 1
            font.family: font_name_input
            font.pixelSize: 13
            selectByMouse: true
            readOnly: isEnabled
            text: text_input
            horizontalAlignment: TextInput.AlignRight
            background: Rectangle
            {
                color: "transparent"
            }
            color: "#464646"
            selectedTextColor: "#222"
            selectionColor: "#888"
            validator: RegExpValidator
            {
                regExp:
                {
                    if( isNumber )
                    {
                       /[0-9۰-۹٠-٩]+/
                    }
                    else
                    {
                        /.+/
                    }
                }
            }

            onAccepted:
            {
                focus = false
            }

            onFocusChanged:
            {
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

    function getInput()
    {
        return id_input.text
    }

    function setInput(text)
    {
        id_input.text = text
    }

}
