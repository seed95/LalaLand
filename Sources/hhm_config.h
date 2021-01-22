#ifndef HHM_CONFIG_H
#define HHM_CONFIG_H

#define HHM_USERNAME_ADMIN  "Admin"
#define HHM_USERNAME_USER   "User"

#define HHM_START_YEAR 2020

#define HHM_MODE_INBOX  1
#define HHM_MODE_OUTBOX 2

#define FTP_SERVER      "ftp://192.168.1.122/../../srv/ftp/hhm/"
#define FTP_USERNAME    "bijan"
#define FTP_PASSWORD    "betoche"

/*****              DataBase Configs            *****/

#define SERVER_ADDRESS "localhost"
#define SERVER_PORT     3306
#define SERVER_USER     "root"
#define SERVER_PASS     "betoche"
#define DATABASE_NAME   "hhm_db"

#define HHM_DOC_STATUS_SUCCESS 1
#define HHM_DOC_STATUS_PENDING 2
#define HHM_DOC_STATUS_REJECT  3

//Tables
#define HHM_TABLE_USER         "user"
#define HHM_TABLE_EMAIL        "email"
#define HHM_TABLE_DOCUMENT     "document"
#define HHM_TABLE_USER_EMAIL   "user_email"

//Columns in Table 'HHM_TABLE_DOCUMENT'
#define HHM_DOCUMENTS_ID                "id"
#define HHM_DOCUMENTS_SENDER_ID         "s_id"
#define HHM_DOCUMENTS_RECEIVER_IDS      "r_ids"
#define HHM_DOCUMENTS_DATE              "date"
#define HHM_DOCUMENTS_SENDER_NAME       "s_name"
#define HHM_DOCUMENTS_FILEPATH          "filepath"
#define HHM_DOCUMENTS_STATUS            "status"
#define HHM_DOCUMENTS_DOCID             "case_num"
#define HHM_DOCUMENTS_SUBJECT           "subject"

//Columns in Table `HHM_TABLE_USER_EMAIL`
#define HHM_UE_ID                   "id"
#define HHM_UE_USER_ID              "user_id"
#define HHM_UE_DATE                 "date"
#define HHM_UE_SENT_EMAILS          "sent_emails"
#define HHM_UE_RECEIVED_EMAILS      "received_emails"

//Columns in Table `HHM_TABLE_USER_EMAIL`
#define HHM_USER_ID             "id"
#define HHM_USER_FIRSTNAME      "firstname"
#define HHM_USER_LASTNAME       "lastname"
#define HHM_USER_USERNAME       "username"
#define HHM_USER_LASTLOGIN      "lastlogin"
#define HHM_USER_STATUS         "status"
#define HHM_USER_BIO            "bio"
#define HHM_USER_IMAGE          "image"
#define HHM_USER_PASSWORD       "password"

//Columns in Table `HHM_TABLE_EMAIL`
#define HHM_EMAILS_ID                   "id"
#define HHM_EMAILS_DOCID                "d_id"
#define HHM_EMAILS_FLAG                 "flag"
#define HHM_EMAILS_OPENED               "opened"
#define HHM_EMAILS_OPEN_TIME            "open_time"
#define HHM_EMAILS_SEND_REFERENCE       "s_email"
#define HHM_EMAILS_RECEIVE_REFERENCE    "r_email"

#endif // HHM_CONFIG_H
