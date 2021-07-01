import QtQuick 2.0

Rectangle
{
    property bool is_hovered: false
    property color bordercolor_Plus:
                                  {
                                        if( is_hovered )
                                        {
                                            "#71a4e3"
                                        }
                                        else
                                        {
                                            "#5790d5"
                                        }
                                  }
    property color backcolor_Plus:
                                  {
                                        if( is_hovered )
                                        {
                                            "#eef0f2"
                                        }
                                        else
                                        {
                                            "#e5e6e7"
                                        }
                                  }
    property string id_number: "number"
    property string id_username: "username"
    property string id_name: "name"

    property bool is_odd: ar2en(id_number)%2

    signal setUserRole(int user_id, int user_role)
    signal addUserRole()


    width: 850
    height: 30
    color:
         {
               if( is_odd )
               {
                   "#d2d2d2"
               }
               else
               {
                   "#bebebe"
               }
         }

    Rectangle
    {
        id: numberBackRec
        width: 74
        height: parent.height
        color: "transparent"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: id_number
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#464646"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }


    Rectangle
    {
        id: usernameBackRec
        width: 134
        height: parent.height
        color: "transparent"
        anchors.right: numberBackRec.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: id_username
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#464646"
            font.family: fontRobotoRegular.name
            font.pixelSize: 15
        }
    }


    Rectangle
    {
        id: nameBackRec
        width: 133
        height: parent.height
        color: "transparent"
        anchors.right: usernameBackRec.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: id_name
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#464646"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }


    HhmDropDown
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        onClickedDownBottom:
                           {
                                console.log("lolo");
                           }
    }

    HhmUTableNewRole
    {
        id: table_new_role
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        onAddUsrRole:
                    {
                        addUserRole();
                    }
    }

    function addRle(role)
    {
        table_new_role.addRole(role);
    }
}
