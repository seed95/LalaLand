import QtQuick 2.0

Rectangle
{
    id: container

    //Cpp Signals
    signal sendNewMessage(variant toData, variant ccData, string subject,
                          string content, variant attachFiles)

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
        anchors.bottom:
        {
            if( attachbar.visible )
            {
                attachbar.top
            }
            else
            {
                parent.bottom
            }
        }
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

    HhmAttachmentBar
    {
        id: attachbar
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        attachMode: con.hhm_ATTACHMENT_UPLOAD_MODE
        objectName: "MessageAttachbar"
    }

    function sendMessage()
    {
        sendNewMessage(text_input_to.getUsernameIds(),
                       text_input_cc.getUsernameIds(),
                       text_input_subject.getSubject(),
                       input_message.text,
                       attachbar.getAttachFiles())
    }

}
