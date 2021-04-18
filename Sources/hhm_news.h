#ifndef HHM_NEWS_H
#define HHM_NEWS_H

#include <QObject>
#include <QTimer>
#include <QQmlProperty>

#include "backend.h"
#include "hhm_database.h"

class HhmNews : public QObject
{
    Q_OBJECT
public:
    explicit HhmNews(QObject *item, HhmDatabase *database, int interval, QObject *parent = nullptr);

private slots:
    void updateNews();

private:
    void showNextNews();
    void updateNewsIds();
    void showNews();//response

private:
    QObject *ui;
    HhmDatabase *db;
    QTimer *timer;

    QList<int> news_ids;//id news in table
    int last_news_index;//last index from news_ids in database for news that shows in ui

};

#endif // HHM_NEWS_H
