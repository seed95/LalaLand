import QtQuick 2.0

Rectangle
{
    id: container

    property color color_text: "#c8c8c8"

    color: "#274579"

    Text
    {
        id: office1
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 6
        text: "Health Care Fraud: "
        font.family: fontRobotoRegular.name
        font.pixelSize: 13
        color: color_text
    }

    Text
    {
        id: news_office1
        anchors.left: office1.right
        anchors.top: parent.top
        anchors.topMargin: 8
        text: "Pain Clinic Medical Providers Sentenced for Their Roles in Operating Pill Mills in Tennessee  (Thursday, December 10, 2020)"
        font.family: fontRobotoLight.name
        font.weight: Font.Light
        font.pixelSize: 12
        color: color_text
    }

    Text
    {
        id: office2
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: office1.bottom
        text: "Office of Public Affairs: "
        font.family: fontRobotoRegular.name
        font.pixelSize: 13
        color: color_text
    }

    Text
    {
        id: news_office2
        anchors.left: office2.right
        anchors.top: office1.bottom
        anchors.topMargin: 3
        text: "Justice Department Announces Additional Distribution of more than $488 Million to Victims of Madoff Ponzi Scheme (Thursday, December 3, 2020)"
        font.family: fontRobotoLight.name
        font.weight: Font.Light
        font.pixelSize: 12
        color: color_text
    }

}
