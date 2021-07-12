import QtQuick 2.0

Rectangle
{
    property string id_number: "number"
    property string id_name: "name"
    property bool is_odd: ar2en(id_number)%2

    signal createPermission(string text_value)

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

     Rectangle
     {
        id: pTableNewContainer1
        anchors.right: pTableNewContainer2.left
        anchors.verticalCenter: parent.verticalCenter
        width: 180
        color: "transparent"

        HhmInput
        {
            id: pTableInput
            anchors.centerIn: parent
            width: 180

            onEnterPressed:
            {
                newBtnPressed();
            }
        }
    }

    Rectangle
    {
        id: pTableNewContainer2
        width: 54
        height: parent.height
        color: "transparent"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        HhmAddBtn
        {
             anchors.centerIn: parent
             onClickedBtn:
             {
                 newBtnPressed();
             }
        }
    }

    function newBtnPressed()
    {
        var input = pTableInput.getInput();
        if( input==="" )
        {
            pTableInput.isError = true;
        }
        else if( p_table.isPermissionExist(input) )
        {
            pTableInput.isError = true;
        }
        else
        {
            createPermission(input);
            pTableInput.setInput("");
        }
    }
}
