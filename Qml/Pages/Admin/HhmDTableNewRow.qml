import QtQuick 2.0

Rectangle
{
    property string id_number: "number"
    property string id_name: "name"
    property bool is_odd: ar2en(id_number)%2

    signal createDepartments(string text_value)

    height: 30
    width: 905
    color:
         {
            if( is_odd )
            {
                "#BEBEBE"
            }
            else
            {
                "#D2D2D2"
            }
         }

    HhmInput
    {
        id: rect1
        subject_placeholder: "القسم"
        anchors.right: rect2.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 220

        onEnterPressed:
        {
            createDepartments(text_val);
            setInput("");
        }
    }

    Rectangle
    {
        id: rect2
        width: 100
        height: parent.height
        color: "transparent"
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.verticalCenter: parent.verticalCenter
        HhmAddBtn
        {
            anchors.centerIn: parent
            onClickedBtn:
            {
                if( rect1.getInput()==="" )
                {
                    rect1.isError = true;
                }
                else
                {
                    createDepartments(rect1.text_val);
                    rect1.setInput("");
                }
            }
        }
    }
}
