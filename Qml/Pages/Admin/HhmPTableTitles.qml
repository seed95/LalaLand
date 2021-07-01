import QtQuick 2.0

Rectangle
{
    color: "transparent"

    Rectangle
    {
        id: permission_text1
        anchors.left: parent.left
        anchors.top: parent.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "اضافة الملف"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

    Rectangle
    {
        id: permission_text2
        anchors.left: permission_text1.left
        anchors.leftMargin: 60
        anchors.top: permission_text1.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "تعدیل الملف"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

    Rectangle
    {
        id: permission_text3
        anchors.left: permission_text2.left
        anchors.leftMargin: 60
        anchors.top: permission_text1.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "مسح الملف"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

    Rectangle
    {
        id: permission_text4
        anchors.left: permission_text3.left
        anchors.leftMargin: 60
        anchors.top: permission_text1.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "مسح بیانات الملف"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

    Rectangle
    {
        id: permission_text5
        anchors.left: permission_text4.left
        anchors.leftMargin: 60
        anchors.top: permission_text1.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "عرض ملفات القسم"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

    Rectangle
    {
        id: permission_text6
        anchors.left: permission_text5.left
        anchors.leftMargin: 60
        anchors.top: permission_text1.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "عرض ملفات الأقسام"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

    Rectangle
    {
        id: permission_text7
        anchors.left: permission_text6.left
        anchors.leftMargin: 60
        anchors.top: permission_text1.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "عرض تقریر الملفات"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

    Rectangle
    {
        id: permission_text8
        anchors.left: permission_text7.left
        anchors.leftMargin: 60
        anchors.top: permission_text1.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "عرض تقاریر القسم"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

    Rectangle
    {
        id: permission_text9
        anchors.left: permission_text8.left
        anchors.leftMargin: 60
        anchors.top: permission_text1.top

        height: 50
        width:100
        rotation:-90
        color: "transparent"

        Text
        {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            text: "عرض تقاریر الأقسام"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }

}
