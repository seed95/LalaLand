import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.4

Window
{
    id: root

    property bool rtl:          true //Right to Left
    property bool fontOffset:   true

    property string app_status:     "Updated from server 12:20PM"
    property string login_status:   "Server connected"

    property int hhm_mode:                  con.hhm_MESSAGE_MODE
    property int email_mode:                con.id_EMAIL_MODE_INBOX
    property int selected_doc_case_number:  con.id_NO_SELECTED_ITEM

    //Message properties
    property string error_msg:    ""//error message
    property int    d_error_msg:  100//duration error message

    //User properties
    property int    idUser:     101
    property string firstname:  "Cassie"
    property string lastname:   "Hicks"
    property string username:   "Admin"
    property string lastlogin:  "2020/08/19 12:23:43"
    property int    status:     0
    property string bio:        "Bio"
    property string image:      "Image"

    property string domain: "lolo.com"
    property string base_id: "lolo.com"

    //Document properties for inbox or outbox items
    property int    case_number:                2 //Document id
    property string sender_name:                "Cassie Hicks"
    property string subject:                    "Subject"
    property int    doc_status:                 1//Success(1), Pending(2), Failed(3)
    property string r_email_date:               "7:17PM" //Received email date
    property int    id_email_in_emails_table:   1 //Save this value for change mode email(open)
    property bool   email_opened:               false
    property string filepath:                   ""
    property string sender_username:            ""
    property string receiver_names:             ""
    property string table_content:              ""

    //Properties for new email
    property bool   createNewEmail:     false           //When click on new button to create new email
    property int    new_case_number:    0               //When click on new button to create new email get new case number from data base
    property int    receiver_id:        1               //id user for received email
    property string selected_file_path: "path/to/file"  //Selected file path for upload file

    //Properties for news
    property string news_title1:     ""
    property string news_content1:   ""
    property string news_date1:      ""
    property string news_title2:     ""
    property string news_content2:   ""
    property string news_date2:      ""

    signal loginUser(string username, string pass)
    signal newButtonClicked()
    signal replyButtonClicked()
    signal archiveButtonClicked()
    signal approveButtonClicked(int docId, string tableContent, int emailId)
    signal rejectButtonClicked(int docId)
    signal scanButtonClicked()
    signal sendButtonClicked(int receiverId, int caseNumber, string subject, string filepath, string tableContent)
    signal flagButtonClicked(int id)
    signal uploadFileClicked()
    signal downloadFileClicked(string src, int docId)
    signal syncInbox()
    signal syncOutbox()
    signal openEmail(int emailId)
    signal checkUsername(string username)

    onEmail_modeChanged:
    {
        syncEmail()
    }

    visible: true
    width: 1330
    height: 870
    minimumHeight: height
    maximumHeight: height
    minimumWidth: width
    maximumWidth: width
    title: "Document Manager"
    color: "#dcdcdc"

    //Fonts:
    FontLoader
    {
        id: fontAwesomeSolid
        source: "qrc:/Fonts/fasolid.ttf"
    }
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

    FontLoader
    {
        id: fontArialBlack
        source: "qrc:/Fonts/Arial-Bold.ttf"
    }
    FontLoader
    {
        id: fontArialRegular
        source: "qrc:/Fonts/Arial-Regular.ttf"
    }
    FontLoader
    {
        id: fontArialLight
        source: "qrc:/Fonts/Arial-Light.ttf"
    }
    FontLoader
    {
        id: fontArialBold
        source: "qrc:/Fonts/Arial-Black.ttf"
    }
    FontLoader
    {
        id: fontArialBoldItalic
        source: "qrc:/Fonts/Arial-BoldItalic.ttf"
    }

    FontLoader
    {
        id: fontDroidKufiRegular
        source: "qrc:/Fonts/DroidKufi-Regular.ttf"
    }
    FontLoader
    {
        id: fontDroidKufiBold
        source: "qrc:/Fonts/DroidKufi-Bold.ttf"
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

    NumberAnimation
    {
        id: animateShowLogin
        target: login
        property: "opacity"
        from: 0
        to: 1
        duration: 500
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
        visible: false
        onSignInUser:
        {
            root.loginUser(uname, pass)
        }
    }

    HhmTopBar
    {
        id: topbar
        anchors.left: parent.left
        anchors.top: parent.top
    }

    HhmSwitcher
    {
        id: switcher
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: bottombar.top
    }

    HhmNews
    {
        id: news
        anchors.left: parent.left
        anchors.top: topbar.bottom
    }

//    HhmActionBox
//    {
//        id: actions
//        anchors.left: parent.left
//        anchors.top: news.bottom
//        anchors.topMargin: -25
//        visible: root.hhm_mode===con.hhm_DOCUMENT_MODE ||
//                 root.hhm_mode===con.hhm_MESSAGE_MODE
//    }

    HhmProfile
    {
        id: profile
        anchors.left: news.right
        anchors.top: topbar.bottom
    }

    HhmSideBar
    {
        id: sidebar
        anchors.top: profile.bottom
        anchors.right: switcher.left
        anchors.bottom: bottombar.top
    }

    HhmPage
    {
        id: page
        anchors.left: parent.left
        anchors.top: news.bottom
        anchors.bottom: bottombar.top
        anchors.right: sidebar.left
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
            id: topbar_ltr
            anchors.left: sidebar_ltr.right
            anchors.right: parent.right
            anchors.top: parent.top
        }

        HhmSideBar
        {
            id: sidebar_ltr
            width: 300
            height: parent.height
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }

//        HhmEmailContent
//        {
//            id: email_content_ltr
//            anchors.left: sidebar_ltr.right
//            anchors.right: parent.right
//            anchors.top: topbar_ltr.bottom
//            anchors.bottom: parent.bottom
//            visible: !createNewEmail && root.isDocSelected()
//        }

//        HhmNewEmail
//        {
//            id: new_email_ltr
//            anchors.left: sidebar_ltr.right
//            anchors.top: topbar_ltr.bottom
//            anchors.right: parent.right
//            anchors.bottom: parent.bottom
//            visible: createNewEmail
//        }

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

    HhmError
    {
        id: error_messae
        anchors.centerIn: parent
        z: 10
    }
    
    //Functions
    /*** Call this function from cpp ***/

    function addToBox()
    {
        var obj = email_content_ltr
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

        obj = sidebar_ltr
        if( root.rtl )
        {
            obj = sidebar
        }
        obj.addToBox()
    }

    function finishSync()
    {
        var obj = sidebar_ltr
        if( root.rtl )
        {
            obj = sidebar
        }

        obj.finishSync()
    }

    function loginSuccessfuly()
    {
        animateHideLogin.start()
        syncEmail()
    }

    //call this function when have a error and must be
    //set properites `error_msg`, `d_error_msg`.
    function showMessage()
    {
        error_messae.showMessage(error_msg, d_error_msg)
    }

    function sendEmailComplete()
    {
        createNewEmail = false
        syncEmail()
    }

    function usernameNotFound()
    {
        var obj = new_email_ltr
        if( root.rtl )
        {
            obj = new_email_rtl
        }

        obj.receiverUsernameNotFound()
    }

    /*** Call this function from qml ***/

    function showPageNewEmail()
    {
        createNewEmail = true
        newButtonClicked()
    }

    function showSelectedFilePath()
    {
        var obj = new_email_ltr
        if( root.rtl )
        {
            obj = new_email_rtl
        }

        obj.showSelectedFile()
    }

    function sendEmail()
    {
        var obj = new_email_ltr
        if( root.rtl )
        {
            obj = new_email_rtl
        }
        sendButtonClicked(root.receiver_id, root.new_case_number, obj.getSubject(),
                          root.selected_file_path, obj.getTableContent())
    }

    function syncEmail()
    {
        var obj = sidebar_ltr
        if( root.rtl )
        {
            obj = sidebar
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

    function isDocSelected()
    {
        return root.selected_doc_case_number!==con.id_NO_SELECTED_ITEM
    }

    function signOut()
    {
        login.visible = true
        animateShowLogin.start()
        root.selected_doc_case_number = con.id_NO_SELECTED_ITEM
        root.email_mode = con.id_EMAIL_MODE_INBOX
        root.createNewEmail = false
        root.selected_file_path = ""
    }

    /*** Utilities functions ***/

    //Slice string from 0 with amount len
    //and add '...' to end text
    function sliceString(text, len)
    {
        if( text.length>len )
        {
            return text.slice(0, len) + "..."
        }
        return text
    }

    //Convert english number to arabic number
    function en2ar(number)
    {
        number = number.toString()
        var arabic_numbers  = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩']//arabic_numbers[0] = 0, arabic_numbers[9] = 9
//        console.log('0:', arabic_numbers[0], ",1:", arabic_numbers[1], ",9:", arabic_numbers[9])
        var english_numbers  = [/0/g, /1/g, /2/g, /3/g, /4/g, /5/g, /6/g, /7/g, /8/g, /9/g]
        for(var i=0; i<10; i++)
        {
            number = number.replace(english_numbers[i], arabic_numbers[i])
        }
        return number
    }

    //Convert arabic number to english number
    function ar2en(number)
    {
        number = number.toString()
        var w_numbers = [/۰/g, /۱/g, /۲/g, /۳/g, /۴/g, /۵/g, /۶/g, /۷/g, /۸/g, /۹/g]
        var arabic_numbers  = [/٠/g, /١/g, /٢/g, /٣/g, /٤/g, /٥/g, /٦/g, /٧/g, /٨/g, /٩/g]
        var en_number
        for(var i=0; i<10; i++)
        {
            number = number.replace(w_numbers[i], i).replace(arabic_numbers[i], i)
        }
        return number
    }
}
