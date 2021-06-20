import QtQuick 2.0

Rectangle
{
    id: container

    property string attach_filename: ""//Set this variable in cpp

    property int cnt_id: 0//Counter for id of attach file

    width: 980
    height: 675
    color: "#f0f0f0"

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
        height: 455
        anchors.left: parent.left
        anchors.top: rect_top.bottom
        anchors.topMargin: 1
        contentHeight: input_message.contentHeight + input_message.anchors.topMargin
        clip: true
        flickableDirection: Flickable.VerticalFlick

        onContentHeightChanged:
        {
            //disable interactive for prevent stealing mouse event
            interactive = height<contentHeight ? true : false
        }

        function updateContentY()
        {
            var cursorRect = input_message.cursorRectangle
            var top_margin = input_message.anchors.topMargin
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
            id: input_message
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.top: parent.top
            anchors.topMargin: 30
            text: "علي عدنان (من مواليد 19 ديسمبر 1993 في حي القاهرة في الأعظمية، بغداد، العراق)، لاعب المنتخب العراقي لكرة القدم. يلعب في الظهير الايسر مع نادي فانكوفر وايتكابس الكندي في الدوري الأميركي. كان أحد الفائزين كأفضل لاعب آسيوي شاب للعام 2013. لعب في كأس آسيا للشباب 2012 في الإمارات، وحصل مع منتخب بلاده على القلادة الفضية.
عمه هو علي كاظم أحد أشهر لاعبين كرة القدم لعب مع الفرق الكروية العراقية في عقد السبعينيات من القرن الماضي.علي عدنان (من مواليد 19 ديسمبر 1993 في حي القاهرة في الأعظمية، بغداد، العراق)، لاعب المنتخب العراقي لكرة القدم. يلعب في الظهير الايسر مع نادي فانكوفر وايتكابس الكندي في الدوري الأميركي. كان أحد الفائزين كأفضل لاعب آسيوي شاب للعام 2013. لعب في كأس آسيا للشباب 2012 في الإمارات، وحصل مع منتخب بلاده على القلادة الفضية.
عمه هو علي كاظم أحد أشهر لاعبين كرة القدم لعب مع الفرق الكروية العراقية في عقد السبعينيات من القرن الماضي. علي عدنان (من مواليد 19 ديسمبر 1993 في حي القاهرة في الأعظمية، بغداد، العراق)، لاعب المنتخب العراقي لكرة القدم. يلعب في الظهير الايسر مع نادي فانكوفر وايتكابس الكندي في الدوري الأميركي. كان أحد الفائزين كأفضل لاعب آسيوي شاب للعام 2013. لعب في كأس آسيا للشباب 2012 في الإمارات، وحصل مع منتخب بلاده على القلادة الفضية.
عمه هو علي كاظم أحد أشهر لاعبين كرة القدم لعب مع الفرق الكروية العراقية في عقد السبعينيات من القرن الماضي. علي عدنان (من مواليد 19 ديسمبر 1993 في حي القاهرة في الأعظمية، بغداد، العراق)، لاعب المنتخب العراقي لكرة القدم. يلعب في الظهير الايسر مع نادي فانكوفر وايتكابس الكندي في الدوري الأميركي. كان أحد الفائزين كأفضل لاعب آسيوي شاب للعام 2013. لعب في كأس آسيا للشباب 2012 في الإمارات، وحصل مع منتخب بلاده على القلادة الفضية.
عمه هو علي كاظم أحد أشهر لاعبين كرة القدم لعب مع الفرق الكروية العراقية في عقد السبعينيات من القرن الماضي. علي عدنان (من مواليد 19 ديسمبر 1993 في حي القاهرة في الأعظمية، بغداد، العراق)، لاعب المنتخب العراقي لكرة القدم. يلعب في الظهير الايسر مع نادي فانكوفر وايتكابس الكندي في الدوري الأميركي. كان أحد الفائزين كأفضل لاعب آسيوي شاب للعام 2013. لعب في كأس آسيا للشباب 2012 في الإمارات، وحصل مع منتخب بلاده على القلادة الفضية.
عمه هو علي كاظم أحد أشهر لاعبين كرة القدم لعب مع الفرق الكروية العراقية في عقد السبعينيات من القرن الماضي.  "
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
            color: "#464646"
            wrapMode: TextEdit.WordWrap
            selectedTextColor: "#222"
            selectionColor: "#888"
            selectByMouse: true
            onCursorRectangleChanged: flick_middle.updateContentY()
        }
    }

    Rectangle
    {
        id: rect_bottom
        width: parent.width
        height: 70
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: "#dcdcdc"
    }

    Flickable
    {
        id: flick_bottom
        width: parent.width
        height: rect_bottom.height
        anchors.right: parent.right
        anchors.rightMargin: 1
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        flickableDirection: Flickable.AutoFlickIfNeeded
        contentWidth: (lm_attachment.count * (200/*attachment height*/ + lv_attachment.spacing) +
                       lv_attachment.anchors.rightMargin)
        clip: true

        onContentWidthChanged:
        {
            if( contentWidth<container.width )
            {
                interactive = false
                anchors.leftMargin = container.width - contentWidth
            }
            else
            {
                interactive = true
                anchors.leftMargin = 1
            }
        }

        ListView
        {
            id: lv_attachment
            height: parent.height
            width: parent.width
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 15
            model: ListModel
            {
                id: lm_attachment
            }
            orientation: ListView.Horizontal
            layoutDirection: Qt.RightToLeft
            spacing: 20
            interactive: false

            delegate: HhmAttachmentBtn
            {
                text_filename   : attachFilename
                id_file         : idFile

                onDeleteAttachment:
                {
                    removeAttachFile(idFile)
                }
            }

        }

    }

    function addAttachFile()
    {
        ///FIXME: check duplicate file
        lm_attachment.append({"attachFilename" : container.attach_filename,
                              "idFile" : cnt_id,
                              "sepVisible" : false})
        cnt_id += 1
    }

    function removeAttachFile(fileId)
    {
        for(var i=0; i<lm_attachment.count; i++)
        {
            if( lm_attachment.get(i).idFile===fileId )
            {
                lm_attachment.remove(i)
                break
            }
        }
    }

}
