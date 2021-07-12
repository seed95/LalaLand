import QtQuick 2.0

Rectangle
{
    property string row_index: "number"
    property string row_rname: "name"
    property bool is_odd: ar2en(row_index)%2
    property int chkContainer_width: 60
    property bool permission_1: false
    property bool permission_2: false
    property bool permission_3: false
    property bool permission_4: false
    property bool permission_5: false
    property bool permission_6: false
    property bool permission_7: false
    property bool permission_8: false
    property bool permission_9: false

    signal chkBoxChanged(int id, int val)
    signal clkedBtn()

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


    HhmDeleteBtn
    {
        id: deleteRect
        anchors.left: parent.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        onClickedBtn: clkedBtn();
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

            is_active: permission_1

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

            is_active: permission_2

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

            is_active: permission_3

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

            is_active: permission_4

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

            is_active: permission_5

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

            is_active: permission_6

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

            is_active: permission_7

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

            is_active: permission_8

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

            is_active: permission_9

            onCheckBoxChange:
            {
                chkBoxChanged(9, value);
            }
        }
    }

    Rectangle
    {
        id: pTableContainer10
        anchors.right: pTableContainer11.left
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter

        width: 180
        height: parent.height
        color: "transparent"
        Text
        {
             anchors.right: parent.right
             anchors.verticalCenter: parent.verticalCenter

             text: row_rname
             font.family: fontDroidKufiRegular.name
             font.pixelSize: 17
             color: "#464646"
        }
    }

    Rectangle
    {
        id: pTableContainer11
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        width: 54
        height: parent.height
        color: "transparent"
        Text
        {
             anchors.centerIn: parent

             text: row_index
             font.family: fontDroidKufiRegular.name
             font.pixelSize: 17
             color: "#464646"
        }
    }
}
