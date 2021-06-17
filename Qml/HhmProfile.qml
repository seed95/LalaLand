import QtQuick 2.0

Rectangle
{
    height: 100
    width: 300
    color: "#d2d2d2"

    Canvas
    {
        width: 108
        height: parent.height
        anchors.right: parent.right

        onPaint:
        {
            var ctx = getContext("2d")

            ctx.beginPath()
            ctx.moveTo(width, 0)
            ctx.lineTo(width, height)
            ctx.lineTo(0, height)
            ctx.lineTo(width/2, 0)
            ctx.lineTo(width, 0)
            ctx.closePath()
            ctx.fillStyle = "#535a61"
            ctx.fill()

        }
    }

    Rectangle
    {
        id: image
        width: 80
        height: width
        anchors.right: parent.right
        anchors.rightMargin: 38
        anchors.verticalCenter: parent.verticalCenter
        radius: width/2
        color: "#505050"
        border.width: 1
        border.color: "#505050"

        Image
        {
            width: 78
            height: 78
            anchors.centerIn: parent
            source: "qrc:/user_image.png"
        }

    }

    Item
    {
        height: 70
        anchors.right: image.left
        anchors.rightMargin: 9
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        Text
        {
            id: name
            anchors.right: parent.right
            anchors.top: parent.top
//            text: "ابراهيم محمد"
            text: root.firstname + " " + root.lastname
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 18
            color: "#505050"
        }

        Text
        {
            id: role
            anchors.right: parent.right
            anchors.top: name.bottom
            anchors.topMargin: -6
            text: "مدير الموارد البشرية"
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 10
            color: "#3c598c"
        }

        Text
        {
            id: last_login
            anchors.right: parent.right
            anchors.top: role.bottom
            anchors.topMargin: -2
            text: "شوهد آخر مرة ۷:۱۷ (۲۴ مايو/ أيار ۲۰۲۱)"
//            text: "شوهد آخر مرة " + root.lastlogin
            font.family: fontDroidKufiRegular.name
            font.pixelSize: 7
            color: "#505050"
        }
    }

}
