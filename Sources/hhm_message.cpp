#include "hhm_message.h"

HhmMessage::HhmMessage(QObject *root, HhmDatabase *database, QObject *parent) : QObject(parent)
{
    db = database;

    main_ui     = root->findChild<QObject*>("message");
    new_ui      = main_ui->findChild<QObject*>("MessageNew");
    action_ui   = main_ui->findChild<QObject*>("MessageAction");

    new_input_to_ui   = main_ui->findChild<QObject*>("MessageNewTo");
    new_input_cc_ui   = main_ui->findChild<QObject*>("MessageNewCc");

    connect(action_ui, SIGNAL(attachNewFile()), this, SLOT(attachNewFile()));

    connect(new_input_to_ui, SIGNAL(addNewUsername(QString)), this, SLOT(addNewUsernameTo(QString)));
    connect(new_input_cc_ui, SIGNAL(addNewUsername(QString)), this, SLOT(addNewUsernameCc(QString)));
}

void HhmMessage::attachNewFile()
{
    QString file_path = QFileDialog::getOpenFileName(NULL,
                                                     "Choose File",
                                                     hhm_getLastDirectory(),
                                                     "*");
    if( !file_path.isEmpty() )
    {
        hhm_setLastDirectory(QFileInfo(file_path).absolutePath());
        QQmlProperty::write(new_ui, "attach_filename", file_path);
        QMetaObject::invokeMethod(new_ui, "addAttachFile");
    }
}

void HhmMessage::addNewUsernameTo(QString username)
{
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    if( res.next() )
    {
        addUserTag(res, new_input_to_ui);
    }
    else
    {
        QMetaObject::invokeMethod(new_input_to_ui, "usernameNotFound");
    }
}

void HhmMessage::addNewUsernameCc(QString username)
{
    QString condition = "`" + QString(HHM_USER_USERNAME) + "`='" + username + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_USER, condition);
    if( res.next() )
    {
        addUserTag(res, new_input_cc_ui);
    }
    else
    {
        QMetaObject::invokeMethod(new_input_cc_ui, "usernameNotFound");
    }
}

void HhmMessage::addUserTag(QSqlQuery res, QObject *ui)
{
    QVariant data = res.value(HHM_USER_ID);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "user_id", data.toInt());
    }
    else
    {
        hhm_log("add user tag, user id is not valid");
    }

    data = res.value(HHM_USER_FIRSTNAME);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "label_firstname", data.toString());
    }
    else
    {
        hhm_log("add user tag, user firstname is not valid");
    }

    data = res.value(HHM_USER_LASTNAME);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "label_lastname", data.toString());
    }
    else
    {
        hhm_log("add user tag, user lastname is not valid");
    }

    data = res.value(HHM_USER_USERNAME);
    if( data.isValid() )
    {
        QQmlProperty::write(ui, "label_username", data.toString());
    }
    else
    {
        hhm_log("add user tag, username is not valid");
    }

    QMetaObject::invokeMethod(ui, "addUsername");
}
