import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id: container

    //Set this variables in cpp
    property string messageId:      ""//The Qml does not support int64
    property string sourceId:       ""//The Qml does not support int64
    property string subject:        "النادي تعديل الزوراء كأس العراق"
    property int    numberSources:  7
    property string senderName:     "ابراهيم محمد"
    property string date:           "۷:۱۷"
    property bool   isRead:         false
    property bool   containFile:    true

    property string selectedId: con.hhm_NO_SELECTED_MESSAGE

    //Cpp Signals
    signal readMessage(string idMessage)

    //Qml Signals
    signal clickMessage(string idMessage)

    ListView
    {
        id: lv_message

        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        model: ListModel
        {
            id: lm_message
        }
        clip: true

        delegate: HhmMessageSidebarElement
        {
            width:                  container.width
            message_id:             idMessage
            source_id:              idSource
            text_subject:           textSubject
            text_number_sources:    textNumberSources
            text_name:              textName
            text_date:              textDate
            is_open:                isOpen
            is_attach:              isAttach
            is_active:              container.selectedId===idMessage

            onClickItem:
            {
                if( !isOpen )
                {
                    isOpen = true
                    readMessage(idMessage)
                }
                clickMessage(idMessage)
            }

        }

        ScrollBar.vertical: scrollbar
    }

    ScrollBar
    {
        id: scrollbar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        background: Rectangle
        {
            width: 6
            anchors.left: parent.left
            anchors.top: parent.top
            color: "#b4b4b4"
        }

        contentItem: Rectangle
        {
            anchors.left: parent.left
            radius: 3
            implicitWidth: 6
            implicitHeight: 400
            color: "#646464"
        }

        policy: ScrollBar.AsNeeded
    }

    /*** Call this function from cpp ***/
    //Add if not exist, Update if exist
    function addToList()
    {
        for(var i=0; i<lm_message.count; i++)
        {
            //Message exist
            if( container.messageId===lm_message.get(i).idMessage )
            {
                lm_message.get(i).idSource              = container.sourceId
                lm_message.get(i).textSubject           = container.subject
                lm_message.get(i).textNumberSources     = container.numberSources
                lm_message.get(i).textName              = container.senderName
                lm_message.get(i).textDate              = container.date
                lm_message.get(i).isOpen                = container.isRead
                lm_message.get(i).isAttach              = container.containFile
                return
            }

            //Source Message exist
            if( container.sourceId===lm_message.get(i).idMessage )
            {
                lm_message.get(i).idMessage             = container.messageId
                lm_message.get(i).idSource              = container.sourceId
                lm_message.get(i).textSubject           = container.subject
                lm_message.get(i).textNumberSources     = container.numberSources
                lm_message.get(i).textName              = container.senderName
                lm_message.get(i).textDate              = container.date
                lm_message.get(i).isOpen                = container.isRead
                lm_message.get(i).isAttach              = container.containFile
                return
            }

            if( container.messageId>lm_message.get(i).idMessage )
            {
                lm_message.insert(i, {  "idMessage" : container.messageId,
                                        "idSource" : container.sourceId,
                                        "textSubject" : container.subject,
                                        "textNumberSources" : container.numberSources,
                                        "textName" : container.senderName,
                                        "textDate" : container.date,
                                        "isOpen" : container.isRead,
                                        "isAttach" : container.containFile})
                return
            }
        }
        lm_message.append({ "idMessage" : container.messageId,
                            "idSource" : container.sourceId,
                            "textSubject" : container.subject,
                            "textNumberSources" : container.numberSources,
                            "textName" : container.senderName,
                            "textDate" : container.date,
                            "isOpen" : container.isRead,
                            "isAttach" : container.containFile})
    }

    function clearList()
    {
        lm_message.clear()
    }

    /*** Call this function from qml ***/
    //Search subject and return all object that match
    function searchObject(text)
    {
        var objects = []

        for(var i=0; i<lm_message.count; i++)
        {
            //Search on subject
            var slice_subject = lm_message.get(i).textSubject.toString().slice(0, text.length)
            if( slice_subject===text )
            {
                objects.push(lm_message.get(i))
            }
        }

        return objects
    }

    //Clear list model and
    //add all object to list model
    function addObjects(objects)
    {
        lm_message.clear()
        lm_message.append(objects)
    }

    function clickItemOnSearch(messageId)
    {
        for(var i=0; i<lm_message.count; i++)
        {
            if( lm_message.get(i).idMessage===messageId )
            {
                if( !lm_message.get(i).isOpen )
                {
                    lm_message.get(i).isOpen = true
                    readMessage(lm_message.get(i).idMessage)
                }
                clickMessage(lm_message.get(i).idMessage)
                break
            }
        }
    }

}

