import QtQuick 2.0
import QtQuick.Controls 2.10

Rectangle
{
    signal clicked(int val ,string sel_text)

    height: flickable_role.height
    color: "transparent"

    ListModel
    {
        id: lm_select
    }

    Component
    {
           id: hoverSelectDelegate

           HhmSelectBtn
           {
               b_text: s_text
               width: parent.parent.width
               onClcked:
                       {
                           clicked(s_number , b_text);
                       }
           }
    }

    Flickable
    {
        id: flickable_role
        anchors.left: parent.left
        anchors.top: parent.top

        width: parent.width
        height:
              {
                 if( lm_select.count>12 )
                 {
                     480
                 }
                 else
                 {
                     lm_select.count*40
                 }
              }

        clip: true
        contentHeight: hoverSelectListView.height
        ScrollBar.vertical: users_scrollbar

        ListView
        {
            id: hoverSelectListView

            width: parent.width
            height: childrenRect.height

            model: lm_select
            delegate: hoverSelectDelegate
        }
    }

    ScrollBar
    {
        id: users_scrollbar
        anchors.left: parent.left
        anchors.leftMargin: -10
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        background: Rectangle
        {
            width: 6
            anchors.left: parent.left
            anchors.top: parent.top
            color: "#b4b4b4"
        }

        contentItem: Rectangle
        {
            anchors.left: parent.left
            radius: 3
            implicitWidth: 6
            implicitHeight: 50
            color: "#646464"
        }

        policy: ScrollBar.AsNeeded
    }

    function addItem(item_text)
    {
        lm_select.append({s_number: (lm_select.count+1),s_text: item_text})
    }

    function removeItem(item_index)
    {
        lm_select.remove(item_index-1);
    }
}
