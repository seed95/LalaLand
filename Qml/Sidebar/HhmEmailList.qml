import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id: container

    //Set this variables in cpp
    property int    case_number:    1992
    property int    doc_status:     1
    property string text_subject:   "وقال السيناتور بيرني ساندرز"
    property bool   email_opened:   false
    property int    email_id:       1

    property int    selectedCasenumber: con.hhm_NO_SELECTED_ITEM

    //Cpp Signals
    signal documentOpened(int emailId, int casenumber)
    signal documentClicked(int casenumber)

//    //Qml Signals
//    signal selectedEmailChanged()

//    onSelectedCasenumberChanged:
//    {

//    }

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
            case_number: caseNumber
            doc_status: docStatus
            isRead: emailOpened
            isActive: container.selectedCasenumber===case_number
            email_id: emailId

            onEmailClicked:
            {
                if( container.selectedCasenumber===caseNumber )
                {
                    container.selectedCasenumber = con.hhm_NO_SELECTED_ITEM
                }
                else
                {
                    container.selectedCasenumber = caseNumber

//                    var obj = email_content
//                    if( root.rtl )
//                    {
//                        obj = email_content_rtl
//                    }

//                    obj.case_number = case_number
//                    obj.text_name = name
//                    obj.text_time = time
//                    obj.doc_status = docStatus
//                    obj.download_filepath = docFilepath
//                    obj.text_subject = docSubject
//                    obj.text_username = senderUsername
//                    obj.text_to = receiverNames
//                    obj.email_id = idEmail
//                    obj.table_content = tableContent

                    if( emailOpened )
                    {
                        documentClicked(caseNumber)
                    }
                    else
                    {
                        emailOpened = true
                        documentOpened(emailId, caseNumber)
                    }

                }

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
        visible: root.rtl
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

    function addToList()
    {
        for(var i=0; i<lm_email.count; i++)
        {
            //Document exist
            if( container.case_number===lm_email.get(i).caseNumber )
            {
                console.log("Update document with case number " + root.case_number)
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

    function clearEmails()
    {
        selectedCasenumber = con.hhm_NO_SELECTED_ITEM
        lm_email.clear()
    }

    //Search with casenumber and subject
    //and return all object that match
    function searchObject(text)
    {
        var objects = []

        //Search on case number
        for(var i=0; i<lm_email.count; i++)
        {
            var slice_case_number = lm_email.get(i).caseNumber.toString().slice(0, text.length)
            if( slice_case_number===text )
            {
                objects.push(lm_email.get(i))
            }
        }

        //Search on subject
        for(var j=0; j<lm_email.count; j++)
        {
            var slice_subject = lm_email.get(j).docSubject.toString().slice(0, text.length)
            if( slice_subject===text )
            {
                objects.push(lm_email.get(j))
            }
        }

        return objects
    }

    //append all object to list model
    function addObjects(objects)
    {
        lm_email.append(objects)
    }

}

