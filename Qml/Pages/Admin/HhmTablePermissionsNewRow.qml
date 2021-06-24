import QtQuick 2.0

Rectangle
{
    property string id_number: "number"
    property string id_name: "name"
    property bool is_odd: ar2en(id_number)%2

    signal createPermission(string text_value)

    height: 30
    width: 800
    color:
         {
            if( is_odd )
            {
                "#BEBEBE"
            }
            else
            {
                "#D2D2D2"
            }
         }

    Rectangle
    {
        id: rect1
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    Rectangle
    {
        id: rect2
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect1.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    Rectangle
    {
        id: rect3
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect2.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    Rectangle
    {
        id: rect4
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect3.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    Rectangle
    {
        id: rect5
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect4.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    Rectangle
    {
        id: rect6
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect5.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    Rectangle
    {
        id: rect7
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect6.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    Rectangle
    {
        id: rect8
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect7.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    Rectangle
    {
        id: rect9
        width: 60
        height: parent.height
        color: "transparent"
        anchors.left: rect8.right
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
        }
    }

    HhmInput
    {
        id: rect10
        anchors.left: rect9.right
        anchors.verticalCenter: parent.verticalCenter
        width: 180

        onEnterPressed:
        {
            createPermission(rect10.text_val);
            rect10.setInput("");
        }
    }

    Rectangle
    {
        id: rect11
        width: 54
        height: parent.height
        color: "transparent"
        anchors.left: rect10.right
        anchors.verticalCenter: parent.verticalCenter
        HhmAddBtn
        {
             anchors.centerIn: parent
             onClickedBtn:
             {
                 createPermission(rect10.text_val);
                 rect10.setInput("");
             }

        }
    }
}
