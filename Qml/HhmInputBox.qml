import QtQuick 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.5

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
    property string font_name_label:
    {
        if( root.rtl )
        {
            fontSansRegular.name
        }
        else
        {
            fontRobotoRegular.name
        }
    }
    property int    font_weight_label: Font.Normal
    property int    font_size_label: 22

    property string text_input_box: "User"
    property string font_name_input_box: fontRobotoRegular.name
    property int    font_weight_input_box: Font.Normal
    property int    font_size_input_box: 18

    property int    left_margin: 30
    property int    width_box: 500
    property int    height_box: 30

    property string auto_complete_text: ""
    property int    textAlign: TextInput.AlignLeft

    property bool isEnabled: false
    property bool isNumber:  false

    signal inputChanged(string text)

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
            anchors.rightMargin:
            {
                if( textAlign===TextInput.AlignLeft )
                {
                    0
                }
                else
                {
                    5
                }
            }
            anchors.leftMargin:
            {
                if( textAlign===TextInput.AlignLeft )
                {
                    5
                }
                else
                {
                    0
                }
            }
            font.family: font_name_input_box
            font.pixelSize: font_size_input_box
            selectByMouse: !isEnabled
            text: text_input_box
            horizontalAlignment: textAlign
            background: Rectangle
            {
                color: "transparent"
            }
            color:
            {
                if( text===text_input_box )
                {
                    "#828282"
                }
                else
                {
                    "#464646"
                }
            }
            selectedTextColor: "#222"
            selectionColor: "#888"
//            readOnly: !isEnabled
            activeFocusOnPress: isEnabled

            onAccepted:
            {
                focus = false
            }

            onFocusChanged:
            {
                if( !focus )
                {
                    if( text==="" )
                    {
                        text = text_input_box
                    }
                    else if( text!==text_input_box )
                    {
                        completeText()
                        inputChanged(input_rtl.text)
                    }
                }
                else if( text===text_input_box )
                {
                    text = ""
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

//            Label
//            {
//                id: typed_text
//                anchors.left: parent.left
//                anchors.top: parent.top
//                text: input_rtl.text
//                font.family: font_name_input_box
//                font.pixelSize: font_size_input_box
//                color: "transparent"
//            }

//            Label
//            {
//                id: suggestion_text
//                anchors.right: parent.right
////                anchors.left: typed_text.right
////                anchors.leftMargin: 10
//                anchors.verticalCenter: parent.verticalCenter
//                text: auto_complete_text
//                font.family: font_name_input_box
//                font.pixelSize: font_size_input_box
//                color: "#999"
//                visible: input_rtl.focus && input_rtl.text!=="" && !input_rtl.text.includes(auto_complete_text) &&
//                         !input_rtl.checkUnicode()
//            }

            function completeText()
            {
                if( text!=="" )
                {
                    var index_atsign = text.indexOf("@");
                    if( index_atsign!==-1 )
                    {
                        text = text.slice(0, index_atsign)
                    }
                    text = text + auto_complete_text
                }
            }

//            //return true if text contains letters other than English
//            function checkUnicode()
//            {
//                for(var i=0; i<input_rtl.text.length; i++)
//                {
//                    if( input_rtl.text.charCodeAt(i)>255 )
//                    {
//                        return true
//                    }
//                }
//                return false
//            }

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


    ///FIXME: update this segment from rtl segment
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
            placeholderText: text_input_box
            placeholderTextColor: "#828282"
            horizontalAlignment: TextInput.AlignRight
            background: Rectangle
            {
                color: "transparent"
            }
            color: "#464646"
            selectedTextColor: "#222"
            selectionColor: "#888"
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

    function setInput(text)
    {
        input_rtl.text = text
        input.text = text
    }

}
