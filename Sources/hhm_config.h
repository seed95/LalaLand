#ifndef HHM_CONFIG_H
#define HHM_CONFIG_H

#define HHM_START_YEAR 2020

#ifdef HHM_USER_ADMIN
#define USER_NAME "Admin"
#else
#define USER_NAME "User"
#endif


/*****              DataBase Configs            *****/

#define SERVER_ADDRESS "localhost"
#define SERVER_PORT     3306
#define SERVER_USER     "root"
#define SERVER_PASS     "1233"
#define DATABASE_NAME   "hhm_db"

//Tables
#define HHM_TABLE_USERS         "users"
#define HHM_TABLE_EMAILS        "emails"
#define HHM_TABLE_DOCUMENTS     "documents"
#define HHM_TABLE_USER_EMAILS   "user_emails"

//Columns in Table 'HHM_TABLE_DOCUMENTS'
#define HHM_DOCUMENTS_SENDER_ID "s_id"
#define HHM_DOCUMENTS_RECEIVER_IDS "r_ids"
#define HHM_DOCUMENTS_DATE "date"
#define HHM_DOCUMENTS_SENDER_NAME "s_name"
#define HHM_DOCUMENTS_FILEPATH "filepath"

//Columns in Table `HHM_TABLE_USER_EMAILS`
#define HHM_UE_USER_ID "user_id"
#define HHM_UE_DATE "date"
#define HHM_UE_SENT_EMAILS "sent_emails"
#define HHM_UE_RECEIVED_EMAILS "received_emails"

//Columns in Table `HHM_TABLE_USER_EMAILS`
#define HHM_USER_ID "id"
#define HHM_USER_FIRSTNAME "firstname"
#define HHM_USER_LASTNAME "lastname"
#define HHM_USER_USERNAME "username"

#endif // HHM_CONFIG_H
