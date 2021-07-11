import QtQuick 2.0

Rectangle
{
    signal addDepGroup()
    signal removeDepGroup(string tg_name)

    width: 520
    color: "transparent"
    height: 30

    Rectangle
    {
        width: parent.width-60
        height: 24
        color: "#E6E6E6"
        radius: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 55
        anchors.right: parent.right
        border.color: "#969696"
        ListView
        {
            id: lv_group
            width: parent.width-6
            height: 22
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.verticalCenter: parent.verticalCenter

            model: ListModel
                   {
                        id: lm_group
                   }
            clip: true
            orientation: ListView.Horizontal
            layoutDirection: Qt.RightToLeft

            delegate: HhmTag
            {
                anchors.verticalCenter: parent.verticalCenter
                tag_text:   group_name
                separator_visible:  sep_visible
                height: 22

                onClickTag:
                {
                    removeGroup(group_id)
                }
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
                        addDepartmentGroup();
                    }
    }

    function removeGroup(group_id)
    {
        for(var i=0; i<lm_group.count; i++)
        {
            if( lm_group.get(i).group_id===group_id )
            {
                var group_name= lm_group.get(i).group_name
                removeDepGroup(group_name)
                lm_group.remove(i);
                break;
            }
        }

        if( lm_group.count>1 )
        {
            lm_group.get(lm_group.count-1).sep_visible = false;
        }
    }

    function addGroup(group)
    {
        lm_group.append({group_id: en2ar(lm_group.count+1),group_name: group, sep_visible: false});

        if( lm_group.count>1 )
        {
            lm_group.get(lm_group.count-2).sep_visible = true;
        }
    }

    // Called from c++
    function cppRemoveGroup(group_name)
    {
        for(var i=0; i<lm_group.count; i++)
        {
            if( lm_group.get(i).group_name===group_name )
            {
                lm_group.remove(i);
                break;
            }
        }

        if( lm_group.count>1 )
        {
            lm_group.get(lm_group.count-1).sep_visible = false;
        }
    }
}
