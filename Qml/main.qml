import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.4

Window
{
    id: root

    property real scale_width: width/1280
    property real scale_height: height/800

    //User properties
    property int    idUser:     101
    property string firstname:  "Cassie"
    property string lastname:   "Hicks"
    property string username:   "Admin"
    property string lastlogin:  "2020/08/19 12:23:43"
    property int    status:     0
    property string bio:        "Bio"
    property string image:      "Image"

    property string app_status: "Updated from server 12:20PM"

    //Document properties for inbox or outbox items
    property int    case_number: 2 //Document id
    property string sender_name: "Cassie Hicks"
    property string subject: "Subject"
    property int    doc_status:  1//Success(1), Pending(2), Failed(3)
    property string r_email_date: "7:17PM" //Received email date
    property int    id_email_in_emails_table: 1 //Save this value for change mode email(open)
    property bool   email_opened: false
    property string filepath: ""

    property bool createNewEmail: false //When click on new button to create new email

    property string selected_file_path: "path/to/file"

    property int email_mode: con.id_EMAIL_MODE_INBOX
    property int case_number_selected_doc: -1

    //Message properties
    property string error_msg:    ""//error message
    property int    d_error_msg:  100//duration error message

    signal loginUser(string username, string pass)
    signal newButtonClicked()
    signal replyButtonClicked()
    signal archiveButtonClicked()
    signal approveButtonClicked(int docId)
    signal rejectButtonClicked(int docId)
    signal scanButtonClicked()
    signal sendButtonClicked(int docId, string subject)
    signal flagButtonClicked(int id)
    signal uploadFileClicked()
    signal downloadFileClicked(string src, int docId)
    signal syncInbox()
    signal syncOutbox()
    signal openEmail(int emailId)

    onEmail_modeChanged:
    {
        syncEmail()
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
        source: "qrc:/Fonts/fa-regular-400.ttf"
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

    //Animations:
    NumberAnimation
    {
        id: animateHideLogin
        target: login
        property: "opacity"
        from: 1
        to: 0
        duration: 500
        onStopped:
        {
            login.visible = false
        }
    }

    //Main UI
    HhmConstants
    {
        id: con
    }

    HhmLogin
    {
        id: login
        anchors.fill: parent
        z: 1
        onSignInUser:
        {
            root.loginUser(uname, pass)
        }
    }

    HhmTopBar
    {
        id: topbar
        anchors.left: sidebar.right
        anchors.top: parent.top
    }

    HhmSideBar
    {
        id: sidebar
        width: 300
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
        visible: !createNewEmail && email_content.isActiveEmail()
    }

    HhmNewEmail
    {
        id: new_email
        anchors.left: sidebar.right
        anchors.top: topbar.bottom
        anchors.right: parent.right
        anchors.bottom: bottombar.top
        visible: createNewEmail
    }

    HhmBottomBar
    {
        id: bottombar
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        text_user: root.username
        text_status: app_status
    }

    HhmMessage
    {
        id: message
        anchors.centerIn: parent
        z: 10
    }
    
    //Functions
    /*** Call this function from cpp ***/

    function addToBox()
    {
        if( email_content.case_number===root.case_number )
        {
            email_content.case_number = root.case_number
            email_content.text_name = root.sender_name
            email_content.text_time = root.r_email_date
            email_content.doc_status = root.doc_status
            email_content.download_filepath = root.filepath
        }

        sidebar.addToBox()
    }

    function finishSync()
    {
        sidebar.finishSync()
        bottombar.text_status = "Updated from server " + (Qt.formatTime(new Date(),"hh:mmAP"))
    }

    function loginSuccessfuly()
    {
        animateHideLogin.start()
    }

    //call this function when have a error and must be
    //set properites `error_msg`, `d_error_msg`.
    function showMessage()
    {
        message.showMessage(error_msg, d_error_msg)
    }

    function sendEmailComplete()
    {
        createNewEmail = false
        syncEmail()
    }

    /*** Call this function from qml ***/

    function showPageNewEmail()
    {
        createNewEmail = true
        new_email.text_from = root.username
        if( root.username==="Admin" )
        {
            new_email.text_to = "User"
        }
        else
        {
            new_email.text_to = "Admin"
        }
    }

    function showSelectedFilePath()
    {
        new_email.showSelectedFile()
    }

    function sendEmail()
    {
        if(new_email.compeleteItems())
        {
            sendButtonClicked(new_email.getCaseNumber(), new_email.getSubject())
        }
    }

    function syncEmail()
    {
        sidebar.clearEmails()
        if( email_mode===con.id_EMAIL_MODE_INBOX )
        {
            syncInbox()
        }
        else if( email_mode===con.id_EMAIL_MODE_OUTBOX )
        {
            syncOutbox()
        }
    }


    function isAdmin()
    {
        return root.username==="Admin"
    }

}
