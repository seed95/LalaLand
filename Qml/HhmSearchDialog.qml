import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle
{
    id: container

    width: 300
    height: 40
    color: "#e1e1e1"

    signal searchCasenumber(string caseNumber)
    signal changedFocus(string text)

    Item
    {
        id: rect_rtl
        anchors.fill: parent
        visible: root.rtl

        Rectangle
        {
            id: rect_refresh_rtl
            height: parent.height
            width: 30
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            Text
            {
                id: refresh_rtl
                anchors.centerIn: parent
                text: "\uf2f1"
                font.family: fontAwesomeSolid.name
                font.pixelSize: 15
                color: "#505050"

                RotationAnimation on rotation
                {
                    id: rotation_refresh_rtl
                    loops: Animation.Infinite
                    duration: 2000
                    from: 0
                    to: 360
                    running: false
                    onStopped:
                    {
                        if(refresh_rtl.rotation!==360)
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
                    rotation_refresh_rtl.start()
                    rotation_refresh_rtl.loops = Animation.Infinite
                    root.syncEmail()
                }
            }

        }

        Rectangle
        {
            id: rect_search_rtl
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
                id: icon_search_rtl
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
                id: text_search_rtl
                anchors.right: icon_search_rtl.left
                anchors.rightMargin: 2
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: hint_search
                font.family: fontSansRegular.name
                font.pixelSize: 13
                horizontalAlignment: TextInput.AlignRight
                selectByMouse: true
                color:
                {
                    if( text===hint_search )
                    {
                        "#969696"
                    }
                    else
                    {
                        "#464646"
                    }
                }
                selectedTextColor: "#222"
                selectionColor: "#888"
                background: Rectangle
                {
                    color: "transparent"
                }
                validator: RegExpValidator { regExp: /\d+/ }

                property string hint_search: qsTr("البحث السجلات")

                onFocusChanged:
                {
                    if( !focus )
                    {
                        if( text==="" )
                        {
                            text = hint_search
                        }

                        if( text===hint_search )
                        {
                            changedFocus("")
                        }
                        else
                        {
                            changedFocus(text)
                        }
                    }
                    else if( text===hint_search )
                    {
                        text = ""
                    }
                }

                onAccepted:
                {
                    focus = false
                }

                onTextChanged:
                {
                    if( text!==hint_search )
                    {
                        searchCasenumber(text)
                    }
                }

                Keys.onEscapePressed:
                {
                    focus = false
                }

            }

        }

    }

    Rectangle
    {
        anchors.fill: parent
        color: "transparent"
        visible: !root.rtl

        Rectangle
        {
            id: rect_refresh
            height: parent.height
            width: 30
            anchors.right: parent.right
            anchors.rightMargin: 2
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
                    root.syncEmail()
                }
            }

        }

        Rectangle
        {
            id: rect_search
            width: 251
            height: 26
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 13
            color: "#f0f0f0"
            border.width: 1
            border.color: "#aaaaaa"
            radius: 4

            Text
            {
                id: icon_search
                text: "\uf002"
                color: "#969696"
                font.family: fontAwesomeSolid.name
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 15
            }

            TextField
            {
                id: text_search
                anchors.left: icon_search.right
                anchors.leftMargin: 4
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 1
                text: hint_search
                font.family: fontRobotoRegular.name
                font.pixelSize: 11
                selectByMouse: true
                color:
                {
                    if( text===hint_search )
                    {
                        "#969696"
                    }
                    else
                    {
                        "#464646"
                    }
                }
                selectedTextColor: "#222"
                selectionColor: "#888"
                background: Rectangle
                {
                    color: "transparent"
                }
                validator: RegExpValidator { regExp: /\d+/ }

                property string hint_search: "Search a document id"

                onFocusChanged:
                {
                    if( !focus )
                    {
                        if( text==="" )
                        {
                            text = hint_search
                        }

                        if( text===hint_search )
                        {
                            changedFocus("")
                        }
                        else
                        {
                            changedFocus(text)
                        }
                    }
                    else if( text===hint_search )
                    {
                        text = ""
                    }
                }

                onAccepted:
                {
                    focus = false
                }

                onTextChanged:
                {
                    if( text!==hint_search )
                    {
                        searchCasenumber(text)
                    }
                }

                Keys.onEscapePressed:
                {
                    focus = false
                }

            }

        }

    }

    function finishSync()
    {
        var obj
        if( root.rtl )
        {
            obj = rotation_refresh_rtl
        }
        else
        {
            obj = rotation_refresh
        }
        obj.stop()
    }

}
