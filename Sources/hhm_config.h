#ifndef HHM_CONFIG_H
#define HHM_CONFIG_H

#define HHM_DEV_MODE

#define HHM_CONFIG_FILE "db.conf"
#define HHM_LOG_FILE    "dm.log"

#define HHM_START_YEAR          2020
#define HHM_DEFAULT_NEWS_TIMER  10000//ms

#define HHM_INBOX_STATE     1
#define HHM_OUTBOX_STATE    2

#define HHM_TAG_USER          1
#define HHM_TAG_DEPARTMENT    2

#define PERMISSION_MY_MESSAGE           1
#define PERMISSION_DEPARTMENT_MESSAGE   4
#define PERMISSION_ALL_MESSAGE          7

/*****              DataBase Configs            *****/

#define SERVER_PORT     3306
#define SERVER_USER     "root"
#define SERVER_PASS     "betoche"
#define DATABASE_NAME   "hhm_db"

#define HHM_DOC_STATUS_SUCCESS 1
#define HHM_DOC_STATUS_PENDING 2
#define HHM_DOC_STATUS_REJECT  3

//Tables
#define HHM_TABLE_CONFIG                            "config"
#define HHM_TABLE_USER                              "user"
#define HHM_TABLE_EMAIL                             "email"
#define HHM_TABLE_DOCUMENT                          "document"
#define HHM_TABLE_USER_EMAIL                        "user_email"
#define HHM_TABLE_DOCUMENT_FILES                    "document_files"
#define HHM_TABLE_NEWS                              "news"
#define HHM_TABLE_FILES                             "files"
#define HHM_TABLE_MESSAGE                           "message"
#define HHM_TABLE_DEPARTMENT                        "department"
#define HHM_TABLE_ROLE                              "role"
#define HHM_TABLE_JOIN_USER_MESSAGE                 "join_user_message"
#define HHM_TABLE_JOIN_DEPARTMENT_MESSAGE           "join_department_message"
#define HHM_TABLE_JOIN_DEPARTMENT_USER_MESSAGE      "join_department_user_message"
#define HHM_TABLE_DEPARTMENT_GROUP                  "department_group"
#define HHM_TABLE_JOIN_USER_ROLE                    "join_user_role"

//Columns in Table `HHM_TABLE_CONFIG`
#define HHM_CONFIG_KEY          "config_key"
#define HHM_CONFIG_VALUE        "config_value"

//Keys for column `HHM_CONFIG_KEY` in Table `HHM_TABLE_CONFIG`
#define HHM_CONFIG_FTP_SERVER          "ftp_server"
#define HHM_CONFIG_FTP_USERNAME        "ftp_username"
#define HHM_CONFIG_FTP_PASSWORD        "ftp_password"
#define HHM_CONFIG_DOMAIN              "domain"
#define HHM_CONFIG_DOCUMENT_BASE_ID    "doc_base_id"
#define HHM_CONFIG_NEWS_TIMER          "news_timer"

//Columns in Table `HHM_TABLE_USER`
#define HHM_USER_ID             "id"
#define HHM_USER_FIRSTNAME      "firstname"
#define HHM_USER_LASTNAME       "lastname"
#define HHM_USER_USERNAME       "username"
#define HHM_USER_LASTLOGIN      "lastlogin"
#define HHM_USER_STATUS         "status"
#define HHM_USER_BIO            "bio"
#define HHM_USER_IMAGE          "image"
#define HHM_USER_PASSWORD       "password"
#define HHM_USER_DEPARTMENT_ID  "department_id"

//Columns in Table `HHM_TABLE_EMAIL`
#define HHM_EMAIL_ID                   "id"
#define HHM_EMAIL_DOC_CASENUMBER       "d_case_number"
#define HHM_EMAIL_FLAG                 "flag"
#define HHM_EMAIL_OPENED               "opened"
#define HHM_EMAIL_OPEN_TIME            "open_time"
#define HHM_EMAIL_SEND_REFERENCE       "s_email"
#define HHM_EMAIL_RECEIVE_REFERENCE    "r_email"

//Columns in Table 'HHM_TABLE_DOCUMENT'
#define HHM_DOCUMENT_CASENUMBER         "case_num"
#define HHM_DOCUMENT_SENDER_ID          "s_id"
#define HHM_DOCUMENT_RECEIVER_IDS       "r_ids"
#define HHM_DOCUMENT_DATE               "date"
#define HHM_DOCUMENT_SENDER_NAME        "s_name"
#define HHM_DOCUMENT_FILEPATH           "filepath"
#define HHM_DOCUMENT_STATUS             "status"
#define HHM_DOCUMENT_SUBJECT            "subject"
#define HHM_DOCUMENT_DATA1              "table_data1"
#define HHM_DOCUMENT_DATA2              "table_data2"
#define HHM_DOCUMENT_DATA3              "table_data3"
#define HHM_DOCUMENT_DATA4              "table_data4"
#define HHM_DOCUMENT_DATA5              "table_data5"
#define HHM_DOCUMENT_DATA6              "table_data6"
#define HHM_DOCUMENT_FILE_IDS           "file_ids"

//Columns in Table `HHM_TABLE_USER_EMAIL`
#define HHM_UE_ID                   "id"
#define HHM_UE_USER_ID              "user_id"
#define HHM_UE_DATE                 "date"
#define HHM_UE_SENT_EMAILS          "sent_emails"
#define HHM_UE_RECEIVED_EMAILS      "received_emails"

//Columns in Table `HHM_TABLE_NEWS`
#define HHM_NEWS_ID                 "id"
#define HHM_NEWS_TITLE              "title"
#define HHM_NEWS_CONTENT            "content"
#define HHM_NEWS_DATE               "date"

//Columns in Table `HHM_TABLE_DOCUMENT_FILES`
#define HHM_DOCUMENT_FILES_ID               "id"
#define HHM_DOCUMENT_FILES_FILENAME         "filename"
#define HHM_DOCUMENT_FILES_SENDER_ID        "sender_id"
#define HHM_DOCUMENT_FILES_TO_IDS           "to_ids"
#define HHM_DOCUMENT_FILES_CC_IDS           "cc_ids"

//Columns in Table `HHM_TABLE_FILES`
#define HHM_FILES_ID                 "id"
#define HHM_FILES_FILENAME           "filename"
#define HHM_FILES_MESSAGE_ID         "message_id"

//Columns in Table `HHM_TABLE_MESSAGE`
#define HHM_MESSAGE_ID                 "id"
#define HHM_MESSAGE_SUBJECT            "subject"
#define HHM_MESSAGE_CONTENT            "content"
#define HHM_MESSAGE_SEND_DATE          "send_date"
#define HHM_MESSAGE_NUMBER_SOURCES     "number_sources"
#define HHM_MESSAGE_SOURCE_ID          "source_message_id"
#define HHM_MESSAGE_SOURCE_FLAG        "source_flag"

//Columns in Table `HHM_TABLE_DEPARTMENT`
#define HHM_DEPARTMENT_ID               "id"
#define HHM_DEPARTMENT_NAME             "name"

//Columns in Table `HHM_TABLE_ROLE`
#define HHM_ROLE_ID                     "id"
#define HHM_ROLE_NAME                   "name"
#define HHM_ROLE_PERMISSION1            "permission_1"
#define HHM_ROLE_PERMISSION2            "permission_2"
#define HHM_ROLE_PERMISSION3            "permission_3"
#define HHM_ROLE_PERMISSION4            "permission_4"
#define HHM_ROLE_PERMISSION5            "permission_5"
#define HHM_ROLE_PERMISSION6            "permission_6"
#define HHM_ROLE_PERMISSION7            "permission_7"
#define HHM_ROLE_PERMISSION8            "permission_8"
#define HHM_ROLE_PERMISSION9            "permission_9"

//Columns in Table `HHM_TABLE_JOIN_USER_MESSAGE`
#define HHM_JUM_USER_ID                 "user_id"
#define HHM_JUM_MESSAGE_ID              "message_id"
#define HHM_JUM_SENDER_FLAG             "sender_flag"
#define HHM_JUM_TO_FLAG                 "to_flag"
#define HHM_JUM_CC_FLAG                 "cc_flag"
#define HHM_JUM_READ_FLAG               "read_flag"

//Columns in Table `HHM_TABLE_JOIN_DEPARTMENT_MESSAGE`
#define HHM_JDM_DEPARTMENT_ID           "department_id"
#define HHM_JDM_MESSAGE_ID              "message_id"
#define HHM_JDM_TO_FLAG                 "to_flag"
#define HHM_JDM_CC_FLAG                 "cc_flag"

//Columns in Table `HHM_TABLE_JOIN_DEPARTMENT_USER_MESSAGE`
#define HHM_JDUM_DEPARTMENT_ID           "department_id"
#define HHM_JDUM_USER_ID                 "user_id"
#define HHM_JDUM_MESSAGE_ID              "message_id"
#define HHM_JDUM_READ_FLAG               "read_flag"

//Columns in Table `HHM_TABLE_DEPARTMENT_GROUP`
#define HHM_JDG_DEPARTMENT_ID           "department_id"
#define HHM_JDG_GROUP_ID                "group_id"

//Columns in Table `HHM_TABLE_JOIN_USER_ROLE`
#define HHM_JUR_USER_ID                 "user_id"
#define HHM_JUR_ROLE_ID                 "role_id"


#endif // HHM_CONFIG_H
