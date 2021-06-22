import QtQuick 2.0

Rectangle
{
    property color color_bg:
                           {
                                if( is_active )
                                {
                                    if( is_hovered )
                                    {
                                        "#477FBD"
                                    }
                                    else
                                    {
                                        "#3D628B"
                                    }
                                }
                                else
                                {
                                    if( is_hovered )
                                    {
                                        "#E6E6E6"
                                    }
                                    else
                                    {
                                        "#DCDCDC"
                                    }
                                }
                           }
    property color color_border:
                               {
                                    if( is_active )
                                    {
                                        if( is_hovered )
                                        {
                                            "#477FBD"
                                        }
                                        else
                                        {
                                            "#3D628B"
                                        }
                                    }
                                    else
                                    {
                                        if( is_hovered )
                                        {
                                            "#3D7FC7"
                                        }
                                        else
                                        {
                                            "#3D628B"
                                        }
                                    }
                               }
    property color text_color:
                             {
                                  if( is_active )
                                  {
                                      if( is_hovered )
                                      {
                                          "#FFFFFF"
                                      }
                                      else
                                      {
                                          "#F0F0F0"
                                      }
                                  }
                                  else
                                  {
                                      if( is_hovered )
                                      {
                                          "transparent"
                                      }
                                      else
                                      {
                                          "transparent"
                                      }
                                  }
                             }
    property bool is_active: false
    property bool is_hovered: false

    signal clickedTab()

    radius: 4
    height: 20
    width: 20
    color: color_bg
    border.color: color_border
    border.width: 2

    Text
    {
        anchors.centerIn: parent

        text: "\uf00c"
        font.family: fontAwesomeSolid.name
        font.weight: Font.Bold
        font.pixelSize: 14
        color: text_color
    }

    MouseArea
    {
        anchors.fill: parent
        hoverEnabled: true
        onClicked:
                 {
                    is_active = !is_active
                    clickedTab();
                 }
        onEntered:
                 {
                    is_hovered = true;
                 }
        onExited:
                {
                   is_hovered = false;
                }
    }
}

