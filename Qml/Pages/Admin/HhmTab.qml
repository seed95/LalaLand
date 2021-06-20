import QtQuick 2.0

Rectangle
{
    property int active_tab: 1
    color: "#C8C8C8"
    width: 980
    height: 40

    HhmTabBtn
    {
        id: tab_users
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.bottom: tab_backg.bottom
        z: 1
        width: 140
        text_tab: "المستخدمين"
        is_active: active_tab===1
        onClickedTab:
                    {
                        console.log("a");
                        active_tab = 1;
                        tab_users.updateCanvas();
                        tab_permissions.updateCanvas();
                        tab_departments.updateCanvas();
                    }
    }

    HhmTabBtn
    {
        id: tab_permissions
        anchors.right: tab_users.left
        anchors.rightMargin: 4
        anchors.bottom: tab_backg.bottom
        z: 1
        width: 120
        text_tab: "أذونات"
        is_active: active_tab===2
        onClickedTab:
                    {
                        console.log("b");
                        active_tab = 2;
                        tab_users.updateCanvas();
                        tab_permissions.updateCanvas();
                        tab_departments.updateCanvas();
                    }
    }

    HhmTabBtn
    {
        id: tab_departments
        anchors.right: tab_permissions.left
        anchors.rightMargin: 4
        anchors.bottom: tab_backg.bottom
        z: 1
        width: 120
        text_tab: "وزارة"
        is_active: active_tab===3
        onClickedTab:
                    {
                        console.log("c");
                        active_tab = 3;
                        tab_users.updateCanvas();
                        tab_permissions.updateCanvas();
                        tab_departments.updateCanvas();
                    }
    }

    Rectangle
    {
        id: tab_backg
        x: 0
        y: 39
        z: 0
        width: 980
        height: 1
        color: "#969696"
    }
}
