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
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        model: ListModel
               {
                    id: lm_role
               }
        clip: true
        orientation: ListView.Horizontal
        layoutDirection: Qt.RightToLeft

        delegate: HhmTag
        {
            anchors.verticalCenter: parent.verticalCenter
            tag_text:   role_name
            separator_visible:  sep_visible
            height: 22

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

    function addRole(role)
    {
        lm_role.append({role_id: en2ar(lm_role.count+1),role_name: role, sep_visible: false});

        if( lm_role.count>1 )
        {
            lm_role.get(lm_role.count-2).sep_visible = true;
        }
    }

}
