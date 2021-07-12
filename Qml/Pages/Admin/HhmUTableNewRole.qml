import QtQuick 2.0

Rectangle
{
    signal addUsrRole()
    signal removeUsrRole(string tg_name)

    width:350
    color: "transparent"
    height: 30

    Rectangle
    {
        width: 296
        height: 24
        color:"#e6e6e6"
        radius: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 40
        anchors.left: parent.left
        border.color: "#969696"
        ListView
        {
            id: lv_role
            width: parent.width-6
            height: 22
            anchors.right: parent.right
            anchors.rightMargin: 3
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
    }

    HhmAddBtn
    {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10

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
                var role_name = lm_role.get(i).role_name;
                removeUsrRole(role_name);
                lm_role.remove(i);
                break;
            }
        }

        if( lm_role.count>1 )
        {
            lm_role.get(lm_role.count-1).sep_visible = false;
        }
    }

    function addRole(r_name)
    {
        for( var i=0; i<lm_role.count; i++ )
        {
            if( lm_role.get(i).role_name===r_name )
            {
                return;
            }
        }

        lm_role.append({role_id: en2ar(lm_role.count+1),
                        role_name: r_name, sep_visible: false});

        if( lm_role.count>1 )
        {
            lm_role.get(lm_role.count-2).sep_visible = true;
        }
    }

    // Called from c++
    function cppRemoveRole(role_name)
    {
        for( var i=0; i<lm_role.count; i++ )
        {
            if( lm_role.get(i).role_name===role_name )
            {
                lm_role.remove(i);
                i = i-1;
            }
        }

        if( lm_role.count )
        {
            lm_role.get(lm_role.count-1).sep_visible = false;
        }
    }
}
