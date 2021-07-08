import QtQuick 2.0

Rectangle
{
    id: container

    property int message_state: con.hhm_MESSAGE_NONE_STATE

    property string placeholder_content: "اكتب المحتوى هنا"

    property color color_input_normal:      "#464646"
    property color color_input_placeholder: "#828282"

    width: 980
    height:
    {
        if( container.message_state===con.hhm_MESSAGE_REPLY_STATE )
        {
            flick_middle.contentHeight + flick_middle.y + 100/*bottom margin*/
        }
        else//messageState===con.hhm_MESSAGE_NEW_STATE
        {
            675
        }
    }
    color: "#f0f0f0"

    onVisibleChanged:
    {
        content_message.text = placeholder_content
        content_message.color = color_input_placeholder
    }

    Rectangle
    {
        id: rect_top
        width: parent.width
        height: 150
        anchors.top: parent.top
        anchors.left: parent.left
        color: "#dcdcdc"

        HhmMessageInput
        {
            id: text_input_to
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 17
            text_label: "الی"
            objectName: "MessageNewTo"
            input_type: con.hhm_MTIT_USERNAME
        }

        HhmMessageInput
        {
            id: text_input_cc
            anchors.left: parent.left
            anchors.top: text_input_to.bottom
            anchors.topMargin: 10
            text_label: "نسخة إلى"
            objectName: "MessageNewCc"
            input_type: con.hhm_MTIT_USERNAME
        }

        HhmMessageInput
        {
            id: text_input_subject
            anchors.left: parent.left
            anchors.top: text_input_cc.bottom
            anchors.topMargin: 10
            text_label: "الموضوع"
            input_type: con.hhm_MTIT_DEFAULT
        }

    }

    Flickable
    {
        id: flick_middle
        width: parent.width
        anchors.left: parent.left
        anchors.top: rect_top.bottom
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        interactive:
        {
            if( container.message_state===con.hhm_MESSAGE_NEW_STATE )
            {
                contentHeight>height
            }
            else
            {
                false
            }
        }
        contentHeight: content_message.contentHeight + content_message.anchors.topMargin
        clip: true

        function updateContentY()
        {
            var cursorRect = content_message.cursorRectangle
            var top_margin = content_message.anchors.topMargin
            if( contentY>=cursorRect.y )
            {
                contentY = cursorRect.y
            }
            else if( contentY+height<=(cursorRect.y+cursorRect.height+top_margin) )
            {
                contentY = cursorRect.y+cursorRect.height + top_margin - height
            }
        }

        TextEdit
        {
            id: content_message
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.top: parent.top
            anchors.topMargin: 30
            text: placeholder_content
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
            color: color_input_placeholder
            wrapMode: TextEdit.Wrap
            horizontalAlignment: Text.AlignRight
            selectedTextColor: "#222"
            selectionColor: "#888"
            selectByMouse: true
            onCursorRectangleChanged: flick_middle.updateContentY()

            onFocusChanged:
            {
                if( focus )
                {
                    if( text===placeholder_content )
                    {
                        text = ""
                    }

                    color = color_input_normal
                }
                else
                {
                    if( text==="" )
                    {
                        text = placeholder_content
                        color = color_input_placeholder
                    }
                }
            }

        }

    }

    function getToData()
    {
        return text_input_to.getTags()
    }

    function getCcData()
    {
        return text_input_cc.getTags()
    }

    function getSubject()
    {
        return text_input_subject.getSubject()
    }

    function getContent()
    {
        if( content_message.text===container.placeholder_content )
        {
            return ""
        }
        return content_message.text
    }

}
