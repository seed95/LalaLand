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

    property string row_index: "number"
    property string row_user: "username"
    property string row_name: "name"
    property string drop_text: ""
    property int addTagFlag: 0

    property bool is_odd: ar2en(row_index)%2

    signal setUserRole(int user_id, int user_role)
    signal addUserRole()
    signal removeUserRole(string tg_name)
    signal clickedDnBottom(int row_index)

    onAddTagFlagChanged:
                       {
                            if( addTagFlag==1 )
                            {
                                table_new_role.addRole(u_table.next_tag_text);
                            }

                            if( addTagFlag==-1 )
                            {
                                table_new_role.cppRemoveRole(u_table.next_tag_text);
                            }
                       }

    width: 905
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
        width: 75
        height: parent.height
        color: "transparent"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: row_index
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
        width: 140
        height: parent.height
        color: "transparent"
        anchors.right: numberBackRec.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: row_user
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
        width: 140
        height: parent.height
        color: "transparent"
        anchors.right: usernameBackRec.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: row_name
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
        anchors.leftMargin: 15
        anchors.left: table_new_role.right

        text_val: drop_text

        onClickedDownBottom:
                           {
                                var row_index_en = ar2en(row_index);
                                clickedDnBottom(row_index_en);
                                u_table.row_number = row_index_en;
                           }
    }

    HhmUTableNewRole
    {
        id: table_new_role
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter

        onAddUsrRole:
                    {
                        addUserRole();
                    }

        onRemoveUsrRole:
                       {
                            removeUserRole(tg_name);
                       }
    }

    function addTagRole(role_name)
    {
        table_new_role.addRole(role_name);
    }
}
