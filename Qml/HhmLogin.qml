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
        source: "qrc:/login_bg.jpg"
    }

    Rectangle
    {
        id: rect_login
        width: 400
        height: childrenRect.height
        anchors.centerIn: parent
        color: "transparent"

        HhmLoginTextInput
        {
            id: username
            width: 360
            height: 40
            x: 0
            anchors.top: parent.top
            text_placeholder: "Username"
            text_icon: "\uf007"
            Keys.onReturnPressed: signing()
        }

        HhmLoginTextInput
        {
            id: password
            width: 360
            height: 40
            x: 0
            anchors.top: username.bottom
            anchors.topMargin: 10
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
            anchors.left: parent.left
            anchors.top: password.bottom
            anchors.topMargin: 10
            onSignInClicked: signing()
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
