import QtQuick 2.0

Rectangle
{
    signal addUsrRole()

    width:350
    color: "transparent"
    height: 30
    Rectangle
    {
        id: userTableRowPosition
        width: 296
        height: 24
        color: "#e6e6e6"
        radius: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 47
        anchors.left: parent.left
        border.color: "#969696"
    }

    ListView
    {
        id: lv_role
        width: parent.width
        height: 22
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter

        model: ListModel
               {
                    id: lm_role

                    ListElement
                    {
                        role_id: 1
                        role_name: "goozoo"
                        sep_visible: false
                    }

                    ListElement
                    {
                        role_id: 2
                        role_name: "shashoo"
                        sep_visible: true
                    }

                    ListElement
                    {
                        role_id: 3
                        role_name: "shiri"
                        sep_visible: true
                    }
               }
        clip: true
        orientation: ListView.Horizontal
        layoutDirection: Qt.RightToLeft

        delegate: HhmTag
        {
            tag_text:   role_name
            separator_visible:  sep_visible

            onClickTag:
            {
                removeRole(role_id)
            }
        }

    }

    HhmAddBtn
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30

        onClickedBtn:
                    {
                       addUsrRole();
                    }

//        onSetUserRole:
//        {
//            stUserRole (int user_id, int user_role);
//        }
    }

    function removeRole(role_id)
    {
        for(var i=0; i<lm_role.count; i++)
        {
            if( lm_role.get(i).role_id===role_id )
            {
                lm_role.remove(i);
                break
            }
        }

        if( lm_role.count )
        {
            lm_role.get(lm_role.count-1).sepVisible = false
        }
    }

}
