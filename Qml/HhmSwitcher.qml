import QtQuick 2.0

Rectangle
{
    width: 50
    height: 870
    color: "#2d3139"

    HhmSwitcherBtn
    {
        id: message
        anchors.bottom: document.top
        text_icon: "\uf0e0"
        isActive: root.hhm_mode===con.hhm_MESSAGE_MODE
        onButtonClicked: root.hhm_mode = con.hhm_MESSAGE_MODE
    }

    HhmSwitcherBtn
    {
        id: document
        anchors.bottom: profile.top
        text_icon: "\uf07c"
        isActive: root.hhm_mode===con.hhm_DOCUMENT_MODE
        onButtonClicked: root.hhm_mode = con.hhm_DOCUMENT_MODE
    }

    HhmSwitcherBtn
    {
        id: profile
        anchors.bottom: admin_panel.top
        text_icon: "\uf007"
        isActive: root.hhm_mode===con.hhm_PROFILE_MODE
        onButtonClicked: root.hhm_mode = con.hhm_PROFILE_MODE
    }

    HhmSwitcherBtn
    {
        id: admin_panel
        anchors.bottom: signout.top
        text_icon: "\uf509"
        isActive: root.hhm_mode===con.hhm_ADMINPANEL_MODE
        onButtonClicked: root.hhm_mode = con.hhm_ADMINPANEL_MODE
    }

    HhmSwitcherBtn
    {
        id: signout
        anchors.bottom: parent.bottom
        text_icon: "\uf2f5"
        onButtonClicked: root.signOut()
    }

}
