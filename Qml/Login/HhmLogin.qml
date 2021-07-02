import QtQuick 2.0

Item
{
    id: container

    signal signInUser(string uname, string pass)

    Component.onCompleted:
    {
        username.focusOnTextInput()
    }

    Image
    {
        anchors.fill: parent
        source: "qrc:/Images/login_bg.jpg"
    }

    Rectangle
    {
        id: rect_login
        width: 400
        height: 250
        anchors.centerIn: parent
        color: "#97aabd"
        radius: 15

        HhmLoginTextInput
        {
            id: username
            width: 360
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 22
            text_placeholder: "Username"
            text_icon: "\uf007"
            Keys.onReturnPressed: signing()
        }

        HhmLoginTextInput
        {
            id: password
            width: 360
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: username.bottom
            anchors.topMargin: 12
            text_placeholder: "Password"
            text_icon: "\uf30d"
            password_type: true
            Keys.onReturnPressed: signing()
        }

        HhmLoginButton
        {
            id: signIn
            width: 360
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: password.bottom
            anchors.topMargin: 20
            onSignInClicked: signing()
        }

        Item
        {
            id: server_status
            width: 400
            height: 50
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            Rectangle
            {
                id: rect1
                width: 400
                height: 15
                anchors.top: parent.top
                anchors.left: parent.left
                color: "#7496b8"
            }

            Rectangle
            {
                id: rect2
                anchors.top: parent.top
                anchors.left: parent.left
                width: 400
                height: 50
                color: "#7496b8"
                radius: 15
            }

            Text
            {
                id: label_status
                text: root.login_status
                anchors.centerIn: parent
                font.family: fontRobotoMedium.name
                font.weight: Font.Medium
                font.pixelSize: 19
                color: "#e1e1e1"
            }

        }

    }

    MouseArea
    {
        anchors.fill: parent
        z: -1

        onClicked:
        {
            container.forceActiveFocus()
        }

    }

    function signing()
    {
        var isComplete = true
        if( username.getText().length===0 )
        {
            username.animateTextInput(30, 0)
            isComplete = false
        }

        if( password.getText().length===0 )
        {
            password.animateTextInput(30, 0)
            isComplete = false
        }

        if(isComplete)
        {
            signInUser(username.getText(), password.getText())
        }

    }

}
