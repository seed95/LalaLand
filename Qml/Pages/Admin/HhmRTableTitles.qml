import QtQuick 2.0

Rectangle
{
    property string ptable_permission1: "اضافة الملف"
    property string ptable_permission2: "تعدیل الملف"
    property string ptable_permission3: "مسح الملف"
    property string ptable_permission4: "مسح بیانات الملف"
    property string ptable_permission5: "عرض ملفات القسم"
    property string ptable_permission6: "عرض ملفات الأقسام"
    property string ptable_permission7: "عرض تقریر الملفات"
    property string ptable_permission8: "عرض تقاریر القسم"
    property string ptable_permission9: "عرض تقاریر الأقسام"

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

            text: ptable_permission1
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

            text: ptable_permission2
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

            text: ptable_permission3
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

            text: ptable_permission4
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

            text: ptable_permission5
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

            text: ptable_permission6
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

            text: ptable_permission7
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

            text: ptable_permission8
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

            text: ptable_permission9
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 17
            color: "#464646"
        }
    }
}
