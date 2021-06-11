import QtQuick 2.0

Item
{

    property int id_NO_SELECTED_ITEM: -1

    property int id_DOC_STATUS_SUCCESS: 1
    property int id_DOC_STATUS_PENDING: 2
    property int id_DOC_STATUS_FAILED:  3

    property int id_EMAIL_MODE_INBOX :  1
    property int id_EMAIL_MODE_OUTBOX:  2

    property int hhm_TABLE_MODE_NEW:         1
    property int hhm_TABLE_MODE_CONTENT:     2

    property string hhm_TEXT_DOC_STATUS_SUCCESS: qsTr("تمت بنجاح")
    property string hhm_TEXT_DOC_STATUS_PENDING: qsTr("غير مقروءة")
    property string hhm_TEXT_DOC_STATUS_FAILED:  qsTr("رفض")

}
