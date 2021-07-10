import QtQuick 2.0
import QtQuick.Controls 2.5

Item
{
    id: container

    property int    input_type: con.hhm_MTIT_DEFAULT
    property string text_label: ""

    //Set this variables in cpp
    property int    tagMode:        con.hhm_TAG_USER
    property int    tagId:          0
    property string tagName:        ""
    property string tagUsername:    ""

    property string username_placeholder:   "User or Department"
    property string subject_placeholder:    "الموضوع"
    property color  color_background:       "#f0f0f0"
    property color  color_border:           "#aaaaaa"
    property int    rect_radius:            5

    property color color_input_error:       "#e08888"
    property color color_input_placeholder: "#828282"
    property color color_input_normal:      "#505050"

    property bool   username_department_err: false

    //Cpp Signals
    signal addNewTag(string tagName)

    width: 980
    height: 30

    onVisibleChanged:
    {
        input_username_department.text = username_placeholder
        input_subject.text = subject_placeholder
        lm_username.clear()
    }

    Rectangle
    {
        id: rect_add
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        width: 24
        height: width
        radius: 6
        color:
        {
            if( rect_add.isHovered )
            {
                "#eff0f1"
            }
            else
            {
                "#e5e6e7"
            }
        }
        border.width: 1
        border.color:
        {
            if( rect_add.isHovered )
            {
                "#679bd9"
            }
            else
            {
                "#5790d5"
            }
        }
        visible: input_type===con.hhm_MTIT_USERNAME

        property bool isHovered: false

        Text
        {
            text: "+"
            font.family: fontRobotoRegular.name
            font.pixelSize: 15
            anchors.centerIn: parent
            color:
            {
                if( rect_add.isHovered )
                {
                    "#679bd9"
                }
                else
                {
                    "#5790d5"
                }
            }
        }

        MouseArea
        {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onEntered:
            {
                rect_add.isHovered = true
            }

            onExited:
            {
                rect_add.isHovered = false
            }

            onClicked:
            {
                container.forceActiveFocus()
                if( checkUniqueUsername(input_username_department.text) )
                {
                    addNewTag(root.ar2en(input_username_department.text))
                }
                else
                {
                    setPlaceholderStyle()
                }
            }
        }

    }

    Rectangle
    {
        id: rect_username_department
        width: 150
        height: 30
        anchors.left: rect_add.right
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        color: color_background
        border.width: 1
        border.color:
        {
            if( username_department_err )
            {
                "#cb8989"
            }
            else
            {
                color_border
            }
        }
        radius: rect_radius
        visible: input_type===con.hhm_MTIT_USERNAME

        TextField
        {
            id: input_username_department
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            text: username_placeholder
            font.family: fontRobotoRegular.name
            font.pixelSize: 12
            color: color_input_placeholder
            selectByMouse: true
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
                    username_department_err = false
                    if( text===username_placeholder )
                    {
                        text = ""
                    }
                    else
                    {
                        selectAll()
                    }

                    setNormalStyle()
                }
                else
                {
                    if( text==="" )
                    {
                        setPlaceholderStyle()
                    }
                }
            }

            onAccepted:
            {
                focus = false
                if( text!=="" && text!==username_placeholder )
                {
                    if( checkUniqueUsername(input_username_department.text) )
                    {
                        addNewTag(root.ar2en(input_username_department.text))
                    }
                    else
                    {
                        setPlaceholderStyle()
                    }
                }
            }

            Keys.onEscapePressed:
            {
                focus = false
            }

        }

    }

    Rectangle
    {
        id: entered_username
        width: 620
        height: 30
        anchors.left: rect_username_department.right
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        color: color_background
        border.width: 1
        border.color: color_border
        radius: rect_radius
        visible: input_type===con.hhm_MTIT_USERNAME

        ListView
        {
            id: lv_username
            width: parent.width
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            model: ListModel
            {
                id: lm_username
            }
            clip: true
            orientation: ListView.Horizontal
            layoutDirection: Qt.RightToLeft

            delegate: HhmTag
            {
                tag_text:           textName
                separator_visible:  sepVisible

                onClickTag:
                {
                    removeTag(textName)
                }
            }
        }
    }

    Rectangle
    {
        id: subject
        width: 810
        height: 30
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        color: color_background
        border.width: 1
        border.color: color_border
        radius: rect_radius
        visible: input_type===con.hhm_MTIT_DEFAULT

        TextField
        {
            id: input_subject
            width: parent.width
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: TextField.AlignRight
            text: subject_placeholder
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
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
            selectByMouse: true
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
                focus = false
            }

        }

    }

    Item
    {
        width: 80
        height: parent.height
        anchors.left:
        {
            if( input_type===con.hhm_MTIT_DEFAULT )
            {
                subject.right
            }
            else///hhm_MTIT_USERNAME
            {
                entered_username.right
            }
        }
        anchors.leftMargin: 6

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: text_label + ":"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#646464"
            horizontalAlignment: Text.AlignLeft
        }

    }

    //Return true if not found 'username' in lm_username
    function checkUniqueUsername(username)
    {
        for( var i=0 ; i<lm_username.count ; i++)
        {
            if( lm_username.get(i).modeTag===1 )
            {
                if( lm_username.get(i).username.toLowerCase()===username.toLowerCase() )
                {
                    return false
                }
            }
        }
        return true
    }

    function addTag()
    {
        setPlaceholderStyle()
        for( var i=0 ; i<lm_username.count ; i++)
        {
            lm_username.get(i).sepVisible = true
        }


        lm_username.append({"textName" : container.tagName,
                            "idTag" : container.tagId,
                            "username" : container.tagUsername,
                            "modeTag" : container.tagMode,
                            "sepVisible" : false})
    }

    function nameNotFound()
    {
        container.username_department_err = true
        input_username_department.color = color_input_error
    }

    function removeTag(textName)
    {
        for(var i=0; i<lm_username.count; i++)
        {
            if( lm_username.get(i).textName===textName )
            {
                lm_username.remove(i)
                break
            }
        }

        if( lm_username.count )
        {
            lm_username.get(lm_username.count-1).sepVisible = false
        }
    }

    function getSubject()
    {
        var result = input_subject.text
        if( input_subject.text===subject_placeholder )
        {
            return ""
        }
        return input_subject.text
    }


    //Return list of tags
    function getTags()
    {
        var result = []
        for(var i=0; i<lm_username.count ; i++)
        {
            var item = []
            item.push(lm_username.get(i).modeTag)
            item.push(lm_username.get(i).idTag)
            item.push(lm_username.get(i).username)
            result.push(item)
        }
        return result
    }

    function clearInput()
    {
        input_username_department.text = username_placeholder
        input_subject.text = subject_placeholder
        lm_username.clear()
    }

    function setPlaceholderStyle()
    {
        input_username_department.text = username_placeholder
        input_username_department.color = color_input_placeholder
        input_username_department.font.pixelSize = 12
    }

    function setNormalStyle()
    {
        input_username_department.color = color_input_normal
        input_username_department.font.pixelSize = 17
    }

}
