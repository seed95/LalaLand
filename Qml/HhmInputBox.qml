import QtQuick 2.0

Rectangle
{

    property color color_background_enabled: "#dcdcdc"
    property color color_background_disabled: "#f0f0f0"
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

    property string label_input_box: "From"

    property bool isEnabled: false

}
