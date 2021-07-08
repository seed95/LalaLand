import QtQuick 2.0

Rectangle
{
    signal addDepGroup()

    width: 500
    color: "transparent"
    height: 30

    Rectangle
    {
        width: 444
        height: 24
        color: "#E6E6E6"
        radius: 6
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 55
        anchors.left: parent.left
        border.color: "#969696"
    }

    ListView
    {
        id: lv_group
        width: parent.width
        height: 22
        anchors.right: parent.right
        anchors.rightMargin: 5
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
                lm_group.remove(i);
                break;
            }
        }

        if( lm_group.count )
        {
            lm_group.get(lm_group.count-1).sepVisible = false;
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

}
