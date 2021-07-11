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
    property string id_username: "name"
    property bool is_odd: ar2en(id_number)%2
    property int addTagFlag: 0

    signal addDepartmentGroup()
    signal removeDepartmentGroup(string tg_name)
    signal clkedBtn()

    onAddTagFlagChanged:
                       {
                            if( addTagFlag==1 )
                            {
                                table_new_group.addGroup(d_table.next_tag_text);
                            }

                            if( addTagFlag==-1 )
                            {
                                table_new_group.cppRemoveGroup(d_table.next_tag_text);
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

    HhmDeleteBtn
    {
        id: deleteRect
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.verticalCenter: parent.verticalCenter

        onClickedBtn: clkedBtn();
    }

    Rectangle
    {
        id: numberRect
        width: 60
        height: parent.height
        color: "transparent"
        anchors.right: deleteRect.left
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
        id: usernameRect
        width: 280
        height: parent.height
        color: "transparent"
        anchors.right: numberRect.left
        anchors.verticalCenter: parent.verticalCenter
        Text
        {
            text: id_username
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#464646"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 15
        }
    }

    HhmDTableNewGroup
    {
        id: table_new_group
        anchors.right: usernameRect.left
        anchors.verticalCenter: parent.verticalCenter

        onAddDepGroup:
                     {
                       addDepartmentGroup();
                     }

        onRemoveDepGroup:
                       {
                            removeDepartmentGroup(tg_name);
                       }
    }

    function addTagGroup(group_name)
    {
        table_new_group.addGroup(group_name);
    }
}
