import QtQuick 2.0

Rectangle
{
    id: container

    property color color_text: "#c8c8c8"

    color: "#274579"

    Item
    {
        id: news_rtl
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 15
        visible: root.rtl

        Text
        {
            id: title1_rtl
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin:
            {
                if( root.fontOffset )
                {
                    6
                }
                else
                {
                    10
                }
            }
            text: root.news_title1 + ": "
            font.family: fontArialBold.name
            font.pixelSize: 13
            color: color_text
        }

        Text
        {
            id: content1_rtl
            anchors.right: title1_rtl.left
            anchors.top: parent.top
            anchors.topMargin: 6
            text: root.news_content1
            font.family: fontArialRegular.name
            font.pixelSize: 13
            color: color_text
        }

        Text
        {
            id: date1_rtl
            anchors.right: content1_rtl.left
            anchors.top: content1_rtl.top
            text: " (" + root.news_date1 + ")"
            font.family: fontArialRegular.name
            font.pixelSize: 13
            color: color_text
        }

        Text
        {
            id: title2_rtl
            anchors.right: parent.right
            anchors.top: title1_rtl.bottom
            anchors.topMargin:
            {
                if( root.fontOffset )
                {
                    2
                }
                else
                {
                    6
                }
            }
            text: root.news_title2 + ": "
            font.family: fontArialBold.name
            font.pixelSize: 13
            color: color_text
        }

        Text
        {
            id: content2_rtl
            anchors.right: title2_rtl.left
            anchors.top: title1_rtl.bottom
            anchors.topMargin: 2
            text: root.news_content2
            font.family: fontArialRegular.name
            font.weight: Font.Normal
            font.pixelSize: 13
            color: color_text
        }

        Text
        {
            id: date2_rtl
            anchors.right: content2_rtl.left
            anchors.top: title1_rtl.bottom
            anchors.topMargin: 2
            text: " (" + root.news_date2 + ")"
            font.family: fontArialRegular.name
            font.weight: Font.Normal
            font.pixelSize: 13
            color: color_text
        }

    }

    Item
    {
        anchors.fill: parent
        visible: !root.rtl

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

}
