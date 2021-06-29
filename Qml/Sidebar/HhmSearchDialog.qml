import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle
{
    id: container

    property string text_placeholder: qsTr("البحث السجلات")

    property color  color_input_placeholder:    "#969696"
    property color  color_input_normal:         "#464646"

    //Qml Signals
    signal refreshClicked()
    signal searchDocument(string text)

    height: 40
    color: "#e1e1e1"

    Rectangle
    {
        id: rect_refresh
        height: parent.height
        width: 30
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Text
        {
            id: refresh
            anchors.centerIn: parent
            text: "\uf2f1"
            font.family: fontAwesomeSolid.name
            font.pixelSize: 15
            color: "#505050"

            RotationAnimation on rotation
            {
                id: rotation_refresh
                loops: Animation.Infinite
                duration: 2000
                from: 0
                to: 360
                running: false
                onStopped:
                {
                    if(refresh.rotation!==360)
                    {
                        loops = 1
                        running = true
                    }
                    else
                    {
                        running = false
                    }
                }
            }

        }

        MouseArea
        {
            anchors.fill: parent

            onClicked:
            {
                rotation_refresh.start()
                rotation_refresh.loops = Animation.Infinite
                refreshClicked()
            }
        }

    }

    Rectangle
    {
        id: rect_search
        width: 251
        height: 26
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 13
        color: "#f0f0f0"
        border.width: 1
        border.color: "#aaaaaa"
        radius: 4

        Text
        {
            id: icon_search
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 7
            text: "\uf002"
            color: "#969696"
            font.family: fontAwesomeSolid.name
            font.pixelSize: 12
        }

        TextField
        {
            id: text_search
            anchors.right: icon_search.left
            anchors.rightMargin: 2
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: text_placeholder
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 10
            horizontalAlignment: TextInput.AlignRight
            selectByMouse: true
            color: color_input_placeholder
            selectedTextColor: "#222"
            selectionColor: "#888"
            background: Rectangle
            {
                color: "transparent"
            }

            onFocusChanged:
            {
                if( focus )
                {
                    if( text===text_placeholder )
                    {
                        text = ""
                        color = color_input_normal
                    }
                }
                else
                {
                    if( text==="" )
                    {
                        text = text_placeholder
                        color = color_input_placeholder
                    }

                    if( text===text_placeholder )
                    {
                        searchDocument("")
                    }
                    else
                    {
                        searchDocument(text)
                    }
                }
            }

            onAccepted:
            {
                focus = false
            }

            onTextChanged:
            {
                if( text===text_placeholder )
                {
                    searchDocument("")
                }
                else
                {
                    searchDocument(text)
                }
            }

            Keys.onEscapePressed:
            {
                focus = false
            }

        }

    }

    function finishSync()
    {
        rotation_refresh.stop()
    }

}
