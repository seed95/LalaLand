import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item
{

    property color color_background_enabled: "#f0f0f0"
    property color color_background_disabled: "#dcdcdc"
    property color color_background:
    {
        if(isEnabled)
        {
            color_background_enabled
        }
        else
        {
            color_background_disabled
        }
    }

    property string text_label: "From"
    property string font_name_label: fontRobotoRegular.name
    property int    font_weight_label: Font.Normal
    property int    font_size_label: 18

    property string text_input_box: "User"
    property string font_name_input_box: fontRobotoRegular.name
    property int    font_weight_input_box: Font.Normal
    property int    font_size_input_box: 18

    property int    left_margin: 30
    property int    width_box: 500
    property int    height_box: 30

    property bool isEnabled: false
    property bool isNumber:  false

    Text
    {
        id: label_input_box_rtl
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: text_label
        font.family: font_name_label
        font.weight: font_weight_label
        font.pixelSize: font_size_label
        color: "#646464"
        visible: root.rtl
    }

    Rectangle
    {
        id: rect_input_rtl
        width: width_box
        height: height_box
        anchors.right: label_input_box_rtl.left
        anchors.rightMargin: left_margin
        anchors.verticalCenter: parent.verticalCenter
        color: color_background
        border.width: 1
        border.color: "#aaaaaa"
        radius: 5
        visible: root.rtl

        TextField
        {
            id: input_rtl
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 5
            text: text_input_box
            font.family: font_name_input_box
            font.pixelSize: font_size_input_box
            selectByMouse: true
            textColor:
            {
                if(text===text_input_box)
                {
                    "#828282"
                }
                else
                {
                    "#464646"
                }

            }

            style: TextFieldStyle
            {
                background: Rectangle
                {
                    color: "transparent"
                }
                selectedTextColor: "#222"
                selectionColor: "#888"
            }
            readOnly: !isEnabled

            onFocusChanged:
            {
                if( isEnabled )
                {
                    if(focus)
                    {
                        if(text===text_input_box)
                        {
                            text = ""
                        }
                    }
                    else
                    {
                        if(text==="")
                        {
                            text = text_input_box
                        }
                    }
                }
            }

            onAccepted:
            {
                focus = false
            }

            Keys.onEscapePressed:
            {
                focus = false
            }

        }

    }

    Text
    {
        id: label_input_box
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: text_label
        font.family: font_name_label
        font.weight: font_weight_label
        font.pixelSize: font_size_label
        color: "#646464"
        visible: !root.rtl
    }

    Rectangle
    {
        id: rect_input
        width: width_box
        height: height_box
        anchors.left: label_input_box.right
        anchors.leftMargin: left_margin
        anchors.verticalCenter: parent.verticalCenter
        color: color_background
        border.width: 1
        border.color: "#aaaaaa"
        radius: 5
        visible: !root.rtl

        TextField
        {
            id: input
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            text: text_input_box
            font.family: font_name_input_box
            font.pixelSize: font_size_input_box
            selectByMouse: true
            textColor:
            {
                if(text===text_input_box)
                {
                    "#828282"
                }
                else
                {
                    "#464646"
                }

            }

            style: TextFieldStyle
            {
                background: Rectangle
                {
                    color: "transparent"
                }
                selectedTextColor: "#222"
                selectionColor: "#888"
            }
            readOnly: !isEnabled

            onFocusChanged:
            {
                if(focus)
                {
                    if(text===text_input_box)
                    {
                        text = ""
                    }
                }
                else
                {
                    if(text==="")
                    {
                        text = text_input_box
                    }
                }
            }

            onAccepted:
            {
                focus = false
            }

            Keys.onEscapePressed:
            {
                focus = false
            }

        }

    }

    function getInput()
    {
        var obj = input
        if( root.rtl )
        {
            obj = input_rtl
        }
        return obj.text
    }

}
