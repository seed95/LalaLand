import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.4

Window
{
    id: root

    property bool rtl: true //Right to Left

    //User properties
    property int    idUser:     101
    property string firstname:  "Cassie"
    property string lastname:   "Hicks"
    property string username:   "Admin"
    property string lastlogin:  "2020/08/19 12:23:43"
    property int    status:     0
    property string bio:        "Bio"
    property string image:      "Image"

    //Document properties for inbox or outbox items
    property int    case_number: 2 //Document id
    property string sender_name: "Cassie Hicks"
    property string subject: "Subject"
    property int    doc_status:  1//Success(1), Pending(2), Failed(3)
    property string r_email_date: "7:17PM" //Received email date
    property int    id_email_in_emails_table: 1 //Save this value for change mode email(open)
    property bool   email_opened: false
    property string filepath: ""

    property bool   createNewEmail: false //When click on new button to create new email
    property string app_status:     "Updated from server 12:20PM"

    //Selected file path for upload file
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
    signal sendButtonClicked(string docId, string subject, string filepath)
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


//    FontLoader
//    {
//        id: fontSansBold
//        source: "qrc:/Fonts/IranSans-Bold.ttf"
//    }
    FontLoader
    {
        id: fontSansRegular
        source: "qrc:/Fonts/IranSans-Regular.ttf"
    }
    FontLoader
    {
        id: fontSansLight
        source: "qrc:/Fonts/IranSans-Light.ttf"
    }
    FontLoader
    {
        id: fontSansUltraLight
        source: "qrc:/Fonts/IranSans-UltraLight.ttf"
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

    Item
    {
        id: main_rtl
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: bottombar.top
        visible: root.rtl

        HhmTopBar
        {
            id: topbar_rtl
            anchors.left: parent.left
            anchors.right: sidebar_rtl.left
            anchors.top: parent.top
        }

        HhmSideBar
        {
            id: sidebar_rtl
            width: 300
            height: parent.height
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        HhmEmailContent
        {
            id: email_content_rtl
            anchors.left: parent.left
            anchors.right: sidebar_rtl.left
            anchors.top: topbar_rtl.bottom
            anchors.bottom: parent.bottom
            visible: !createNewEmail && email_content_rtl.isActiveEmail()
        }

        HhmNewEmail
        {
            id: new_email_rtl
            anchors.left: parent.left
            anchors.right: sidebar_rtl.left
            anchors.top: topbar_rtl.bottom
            anchors.bottom: parent.bottom
            visible: createNewEmail
        }

    }

    Item
    {
        id: main_ltr
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: bottombar.top
        visible: !root.rtl

        HhmTopBar
        {
            id: topbar
            anchors.left: sidebar.right
            anchors.right: parent.right
            anchors.top: parent.top
        }

        HhmSideBar
        {
            id: sidebar
            width: 300
            height: parent.height
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }

        HhmEmailContent
        {
            id: email_content
            anchors.left: sidebar.right
            anchors.right: parent.right
            anchors.top: topbar.bottom
            anchors.bottom: parent.bottom
            visible: !createNewEmail && email_content.isActiveEmail()
        }

        HhmNewEmail
        {
            id: new_email
            anchors.left: sidebar.right
            anchors.top: topbar.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            visible: createNewEmail
        }

    }

    HhmBottomBar
    {
        id: bottombar
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        text_user: root.username
        text_status: root.app_status
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
        var obj = email_content
        if( root.rtl )
        {
            obj = email_content_rtl
        }

        if( obj.case_number===root.case_number )
        {
            obj.case_number = root.case_number
            obj.text_name = root.sender_name
            obj.text_time = root.r_email_date
            obj.doc_status = root.doc_status
            obj.download_filepath = root.filepath
        }

        obj = sidebar
        if( root.rtl )
        {
            obj = sidebar_rtl
        }
        obj.addToBox()
    }

    function finishSync()
    {
        var obj = sidebar
        if( root.rtl )
        {
            obj = sidebar_rtl
        }

        obj.finishSync()
        root.app_status = "Updated from server " + (Qt.formatTime(new Date(),"hh:mmAP"))
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
        var obj = new_email
        if( root.rtl )
        {
            obj = new_email_rtl
        }

        obj.text_from = root.username
        if( isAdmin() )
        {
            obj.text_to = "User"
        }
        else
        {
            obj.text_to = "Admin"
        }
    }

    function showSelectedFilePath()
    {
        var obj = new_email
        if( root.rtl )
        {
            obj = new_email_rtl
        }

        obj.showSelectedFile()
    }

    function sendEmail()
    {
        var obj = new_email
        if( root.rtl )
        {
            obj = new_email_rtl
        }

        if( obj.compeleteItems() )
        {
            sendButtonClicked(obj.getCaseNumber(), obj.getSubject(), selected_file_path)
        }
    }

    function syncEmail()
    {
        var obj = sidebar
        if( root.rtl )
        {
            obj = sidebar_rtl
        }

        obj.clearEmails()
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
        return root.username==="Admin" || root.username==="Ad"
    }


    //Convert english number to arabic number
    function en2ar(number)
    {
        number = number.toString()
        //FIXME: change persian number to arabic
        var arabic_numbers  = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹']
        var english_numbers  = [/0/g, /1/g, /2/g, /3/g, /4/g, /5/g, /6/g, /7/g, /8/g, /9/g]
        for(var i=0; i<10; i++)
        {
            var ar_number = number.replace(i, arabic_numbers[i])
        }
        return ar_number
    }

    //Convert arabic(persian) number to english number
    function ar2en(number)
    {
        var persian_numbers = [/۰/g, /۱/g, /۲/g, /۳/g, /۴/g, /۵/g, /۶/g, /۷/g, /۸/g, /۹/g]
        var arabic_numbers  = [/٠/g, /١/g, /٢/g, /٣/g, /٤/g, /٥/g, /٦/g, /٧/g, /٨/g, /٩/g]
        for(var i=0; i<10; i++)
        {
            var en_number = number.replace(persian_numbers[i], i).replace(arabic_numbers[i], i)
        }
        return en_number
    }
}
