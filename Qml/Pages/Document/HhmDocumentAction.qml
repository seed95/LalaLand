import QtQuick 2.0

Rectangle
{
    //Cpp Signals
    signal newDocumentClicked()

    //Qml Signals
    signal sendDocumentClicked()
    signal viewBackClicked()
    signal approveClicked()
    signal rejectClicked()

    width: 980
    height: 50
    color: "#c8c8c8"

    //Acttion Box for None State
    HhmActionBtn
    {
        id: action_new
        height: parent.height
        width: 100
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: documentState===con.hhm_DOCUMENT_NONE_STATE
        icon_text: "\uf067"
        action_text: qsTr("انشاء")
        icon_left_margin: 6
        action_vertical_offset: -2
        action_left_margin: 2
        onButtonClicked:
        {
            newDocumentClicked()
            documentState = con.hhm_DOCUMENT_NEW_STATE
        }
    }

    //Acttion Box for View State
    HhmActionBtn
    {
        id: action_back2
        height: parent.height
        width: 100
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: documentState===con.hhm_MESSAGE_VIEW_STATE
        icon_text: "\uf061"
        action_text: qsTr("رجوع")
        icon_left_margin: 3
        action_vertical_offset: -4
        action_left_margin: 0
        onButtonClicked:
        {
            viewBackClicked()
        }
    }

    HhmActionBtn
    {
        id: action_approve
        height: parent.height
        width: 140
        anchors.right: action_back2.left
        anchors.verticalCenter: parent.verticalCenter
        visible: documentState===con.hhm_MESSAGE_VIEW_STATE
        icon_text: "\uf00c"
        action_text: qsTr("تأیید المستند")
        icon_left_margin: 8
        action_vertical_offset: -2
        action_left_margin: 0

        onButtonClicked:
        {
            approveClicked()
        }

    }

    HhmActionBtn
    {
        id: action_reject
        height: parent.height
        width: 80
        anchors.right: action_approve.left
        anchors.verticalCenter: parent.verticalCenter
        visible: documentState===con.hhm_MESSAGE_VIEW_STATE
        icon_text: "\uf00d"
        action_text: qsTr("رفض")
        icon_left_margin: 8
        action_vertical_offset: -2
        action_left_margin: 0

        onButtonClicked:
        {
            rejectClicked()
        }
    }

    //Acttion Box for New State
    HhmActionBtn
    {
        id: action_back
        height: parent.height
        width: 100
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: documentState===con.hhm_MESSAGE_NEW_STATE
        icon_text: "\uf061"
        action_text: qsTr("رجوع")
        icon_left_margin: 3
        action_vertical_offset: -4
        action_left_margin: 0
        onButtonClicked:
        {
            documentState = con.hhm_DOCUMENT_NONE_STATE
        }
    }

    HhmActionBtn
    {
        id: action_scan
        height: parent.height
        width: 150
        anchors.right: action_back.left
        anchors.verticalCenter: parent.verticalCenter
        visible: documentState===con.hhm_MESSAGE_NEW_STATE
        icon_text: "\uf574"
        action_text: qsTr("المسح الضوئي")
        action_left_margin: -2
        action_vertical_offset: -2
        icon_left_margin: 10
    }

    HhmActionBtn
    {
        id: action_send
        height: parent.height
        width: 100
        anchors.right: action_scan.left
        anchors.verticalCenter: parent.verticalCenter
        visible: documentState===con.hhm_MESSAGE_NEW_STATE
        icon_text: "\uf1d8"
        action_text: qsTr("رسال")
        action_left_margin: 0
        action_vertical_offset: -1
        icon_left_margin: 5
        onButtonClicked: sendDocumentClicked()
    }

}
