import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id: container

    //Set this variables in cpp
    property int    case_number:    1992//id item
    property int    doc_status:     1
    property string text_subject:   "وقال السيناتور بيرني ساندرز"
    property bool   email_opened:   false
    property int    email_id:       1

    property int    selectedId: con.hhm_NO_SELECTED_ITEM//Email Id

    //Cpp Signals
    signal readEmail(int idEmail)

    //Qml Signals
    signal clickEmail(int idEmail, int idItem)

    ListView
    {
        id: lv_email

        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        model: ListModel
        {
            id: lm_email
        }
        clip: true

        delegate: HhmSideBarElement
        {
            width: container.width
            text_subject: docSubject
            case_number: caseNumber//id Item
            doc_status: docStatus
            isRead: emailOpened
            email_id: emailId
            isActive: container.selectedId===emailId

            onClickItem:
            {
                if( !emailOpened )
                {
                    emailOpened = true
                    readEmail(emailId)
                }
                clickEmail(emailId, caseNumber)
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

    //Add if not exist
    //Update if exist
    function addToList()
    {
        for(var i=0; i<lm_email.count; i++)
        {
            //Document exist
            if( container.case_number===lm_email.get(i).caseNumber )
            {
                lm_email.get(i).docSubject  = container.text_subject
                lm_email.get(i).docStatus   = container.doc_status
                lm_email.get(i).emailOpened = container.email_opened
                lm_email.get(i).emailId     = container.email_id
                return
            }

            if( container.case_number>lm_email.get(i).caseNumber )
            {
                lm_email.insert(i, {"docSubject" : container.text_subject,
                                    "caseNumber" : container.case_number,
                                    "docStatus" : container.doc_status,
                                    "emailOpened" : container.email_opened,
                                    "emailId" : container.email_id})
                return
            }
        }
        lm_email.append({"docSubject" : container.text_subject,
                        "caseNumber" : container.case_number,
                        "docStatus" : container.doc_status,
                        "emailOpened" : container.email_opened,
                        "emailId" : container.email_id})
    }

    //Search with casenumber and subject
    //and return all object that match
    function searchObject(text)
    {
        var objects = []

        for(var i=0; i<lm_email.count; i++)
        {
            //Search on case number
            var slice_case_number = lm_email.get(i).caseNumber.toString().slice(0, text.length)
            if( slice_case_number===text )
            {
                objects.push(lm_email.get(i))
                continue
            }

            //Search on subject
            var slice_subject = lm_email.get(i).docSubject.toString().slice(0, text.length)
            if( slice_subject===text )
            {
                objects.push(lm_email.get(i))
            }
        }

        return objects
    }

    //Clear list model and
    //add all object to list model
    function addObjects(objects)
    {
        lm_email.clear()
        lm_email.append(objects)
    }

    function clickSearchedItem(idEmail)
    {
        for(var i=0; i<lm_email.count; i++)
        {
            if( lm_email.get(i).emailId===idEmail )
            {
                lm_email.get(i).emailOpened = true
                readEmail(lm_email.get(i).emailId)
                break
            }
        }
    }

    function clearList()
    {
        lm_email.clear()
    }
}

