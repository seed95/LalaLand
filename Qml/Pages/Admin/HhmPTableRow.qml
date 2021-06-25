import QtQuick 2.0

Rectangle
{
    property string id_number: "number"
    property string id_name: "name"
    property bool is_odd: ar2en(id_number)%2
    property int chkContainer_width: 60

    signal chkBoxChanged(int id, int val)

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
        id: pTableContainer1
        width: chkContainer_width
        height: parent.height
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.verticalCenter: parent.verticalCenter
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(1, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer2
        anchors.left: pTableContainer1.right
        anchors.verticalCenter: parent.verticalCenter

        width: chkContainer_width
        height: parent.height
        color: "transparent"
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(2, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer3
        anchors.left: pTableContainer2.right
        anchors.verticalCenter: parent.verticalCenter

        width: chkContainer_width
        height: parent.height
        color: "transparent"
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(3, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer4
        anchors.left: pTableContainer3.right
        anchors.verticalCenter: parent.verticalCenter

        width: chkContainer_width
        height: parent.height
        color: "transparent"
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(4, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer5
        anchors.left: pTableContainer4.right
        anchors.verticalCenter: parent.verticalCenter

        width: chkContainer_width
        height: parent.height
        color: "transparent"
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(5, value);
            }
        }
    }
    Rectangle
    {
        id: pTableContainer6
        anchors.left: pTableContainer5.right
        anchors.verticalCenter: parent.verticalCenter

        width: chkContainer_width
        height: parent.height
        color: "transparent"
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(6, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer7
        anchors.left: pTableContainer6.right
        anchors.verticalCenter: parent.verticalCenter

        width: chkContainer_width
        height: parent.height
        color: "transparent"
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(7, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer8
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: pTableContainer7.right

        width: chkContainer_width
        height: parent.height
        color: "transparent"
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(8, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer9
        anchors.left: pTableContainer8.right
        anchors.verticalCenter: parent.verticalCenter

        width: chkContainer_width
        height: parent.height
        color: "transparent"
        HhmCheckBox
        {
            anchors.centerIn: parent
            onCheckBoxChange:
            {
                chkBoxChanged(9, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer10
        anchors.left: pTableContainer9.right
        anchors.verticalCenter: parent.verticalCenter

        width: 180
        height: parent.height
        color: "transparent"
        Text
        {
             anchors.right: parent.right
             anchors.rightMargin: 28.5
             anchors.verticalCenter: parent.verticalCenter

             text: id_name
             font.family: fontDroidKufiRegular.name
             font.pixelSize: 17
             color: "#464646"
        }
    }

    Rectangle
    {
        id: pTableContainer11
        anchors.left: pTableContainer10.right
        anchors.verticalCenter: parent.verticalCenter

        width: 54
        height: parent.height
        color: "transparent"
        Text
        {
             anchors.centerIn: parent

             text: id_number
             font.family: fontDroidKufiRegular.name
             font.pixelSize: 17
             color: "#464646"
        }
    }
}
