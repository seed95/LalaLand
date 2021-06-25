import QtQuick 2.0

Rectangle
{
    property string id_number: "number"
    property string id_name: "name"
    property bool is_odd: ar2en(id_number)%2

    signal createDepartments(string text_value)

    height: 30
    width: 800
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
        anchors.left: parent.left
        anchors.leftMargin: 500
        anchors.verticalCenter: parent.verticalCenter
        width: 190

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
        anchors.left: rect1.right
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
