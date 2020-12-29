import QtQuick 2.10
import QtQuick.Window 2.10

Window
{
    id: root

    property real scale_width: width/1280
    property real scale_height: height/800

    //Document properties
    property int    case_number: 2 //Document id
    property string sender_name: "Cassie Hicks"
    property string subject: "Subject"
    property int    doc_status:  1//Success(1), Pending(2), Failed(3)
    property string r_email_date: "7:17PM" //Received email date
    property int    id_email_in_emails_table: 1 //Save this value for change mode email(open)
    property bool   email_opened: false

    property string s_new_email_username: "Admin"//Sender email username
    property string r_new_email_username: "Admin"//Received email username

    property string selected_file_path: "path/to/file"//Sender email username

    property int email_mode: con.id_EMAIL_MODE_INBOX
    property int id_active_email: -1

    property string error_msg:    ""//error message
    property int    d_error_msg:  100//duration error message

    signal newButtonClicked()
    signal replyButtonClicked()
    signal archiveButtonClicked()
    signal approveButtonClicked(int docId)
    signal rejectButtonClicked(int docId)
    signal scanButtonClicked()
    signal sendButtonClicked(int docId, string subject)
    signal syncButtonClicked()
    signal flagButtonClicked(int id)
    signal uploadFileClicked()
    signal inboxClicked()
    signal outboxClicked()
    signal openEmail(int emailId)

    onEmail_modeChanged:
    {
        sidebar.clearEmails()
        if( email_mode===con.id_EMAIL_MODE_INBOX )
        {
            inboxClicked()
        }
        else if( email_mode===con.id_EMAIL_MODE_OUTBOX)
        {
            outboxClicked()
        }
    }

    visible: true
    width: 1280
    height: 800
    minimumHeight: height
    maximumHeight: height
    minimumWidth: width
    maximumWidth: width
    title: "Document Manager"
    color: "#e6e6e6"

    //Fonts:
    FontLoader
    {
        id: fontAwesomeSolid
        source: "qrc:/Fonts/fa-solid.ttf"
    }
//    FontLoader
//    {
//        id: fontAwesomeSolid
//        source: "qrc:/Fonts/fasolid.ttf"
//    }
    FontLoader
    {
        id: fontAwesomeBrand
        source: "qrc:/Fonts/fa-brands-400.ttf"
    }
    FontLoader
    {
        id: fontAwesomeRegular
        source: "qrc:/Fonts/fa-regular-brand.ttf"
    }


    FontLoader
    {
        id: fontRobotoBold
        source: "qrc:/Fonts/Roboto-Bold.ttf"
    }
    FontLoader
    {
        id: fontRobotoMedium
        source: "qrc:/Fonts/Roboto-Medium.ttf"
    }
    FontLoader
    {
        id: fontRobotoRegular
        source: "qrc:/Fonts/Roboto-Regular.ttf"
    }
    FontLoader
    {
        id: fontRobotoLight
        source: "qrc:/Fonts/Roboto-Light.ttf"
    }

    HhmConstants
    {
        id: con
    }

    HhmNews
    {
        id: news
        anchors.right: parent.right
        anchors.top: parent.top
    }

    HhmTopBar
    {
        id: topbar
        anchors.right: parent.right
        anchors.top: news.bottom
    }

    HhmSideBar
    {
        id: sidebar
        width: 300 * scale_width
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: bottombar.top
    }

    HhmEmailContent
    {
        id: email_content
        anchors.left: sidebar.right
        anchors.top: topbar.bottom
        anchors.right: parent.right
        anchors.bottom: bottombar.top
        visible: false
    }

    HhmNewEmail
    {
        id: new_email
        anchors.left: sidebar.right
        anchors.top: topbar.bottom
        anchors.right: parent.right
        anchors.bottom: bottombar.top
        visible: false
        text_from: s_new_email_username
        text_to: r_new_email_username
    }

    HhmBottomBar
    {
        id: bottombar
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    HhmMessage
    {
        id: message
        anchors.centerIn: parent
        z: 10
    }
    
    function addToInbox()
    {
        sidebar.addToInbox()
    }

    function showPageNewEmail()
    {
        email_content.visible = false
        new_email.visible = true
        newButtonClicked()
    }

    function showPageContentEmail()
    {
        if( root.id_active_email!==-1 )
        {
            email_content.visible = true
        }
        new_email.visible = false
    }

    function showEmailContent(name, time, status)
    {
        showPageContentEmail()
        email_content.text_name = name
        email_content.text_time = time
        email_content.doc_status = status
    }

    function showSelectedFilePath()
    {
        new_email.showSelectedFile()
    }

    function finishSync()
    {
        sidebar.finishSync()
    }

    function sendEmail()
    {
        if(new_email.compeleteItems())
        {
            showPageContentEmail()
            sendButtonClicked(new_email.getCaseNumber(), new_email.getSubject())
            if( email_mode===con.id_EMAIL_MODE_INBOX )
            {
                inboxClicked()
            }
            else if( email_mode===con.id_EMAIL_MODE_OUTBOX )
            {
                outboxClicked()
            }
        }
    }

    //call this function when have a error and must be
    //set properites `error_msg`, `d_error_msg`.
    function showMessage()
    {
        message.showMessage(error_msg, d_error_msg)
    }

}
