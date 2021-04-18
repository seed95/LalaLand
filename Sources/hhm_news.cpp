#include "hhm_news.h"

HhmNews::HhmNews(QObject *item, HhmDatabase *database, int interval, QObject *parent) : QObject(parent)
{
    ui = item;
    db = database;
    news_ids = QList<int>();
    last_news_index = -1;

    //Instance timer
    hhm_log("Interval for news timer: " + QString::number(interval));
    timer = new QTimer();
    connect(timer, SIGNAL(timeout()), this, SLOT(updateNews()));
    timer->start(interval);
}

void HhmNews::updateNews()
{
    updateNewsIds();
    showNews();
}

void HhmNews::showNews()
{
    //Show first news
    last_news_index++;
    if( news_ids.size()<=last_news_index )
    {
        last_news_index = 0;
    }
    int id = news_ids[last_news_index];
    QString condition = "`" + QString(HHM_NEWS_ID) + "`='" + QString::number(id) + "'";
    QSqlQuery res = db->select("*", HHM_TABLE_NEWS, condition);

    if( res.next() )
    {
        QVariant data = res.value(HHM_NEWS_TITLE);
        if( data.isValid() )
        {
            QQmlProperty::write(ui, "news_title1", data.toString());
        }
        else
        {
            hhm_log("News title for id " + QString::number(news_ids[last_news_index]) + " is not valid");
        }

        data = res.value(HHM_NEWS_CONTENT);
        if(data.isValid())
        {
            QQmlProperty::write(ui, "news_content1", data.toString());
        }
        else
        {
            hhm_log("News content for id " + QString::number(news_ids[last_news_index]) + " is not valid");
        }

        data = res.value(HHM_NEWS_DATE);
        if(data.isValid())
        {
            QQmlProperty::write(ui, "news_date1", data.toString());
        }
        else
        {
            hhm_log("News time for id " + QString::number(news_ids[last_news_index]) + " is not valid");
        }

    }
    else
    {
        hhm_log("Cannot find news for id " + QString::number(news_ids[last_news_index]));
    }

    //Show second news
    last_news_index++;
    if( news_ids.size()<=last_news_index )
    {
        last_news_index = 0;
    }
    id = news_ids[last_news_index];
    condition = "`" + QString(HHM_NEWS_ID) + "`='" + QString::number(id) + "'";
    res = db->select("*", HHM_TABLE_NEWS, condition);

    if( res.next() )
    {
        QVariant data = res.value(HHM_NEWS_TITLE);
        if( data.isValid() )
        {
            QQmlProperty::write(ui, "news_title2", data.toString());
        }
        else
        {
            hhm_log("News title for id " + QString::number(news_ids[last_news_index]) + " is not valid");
        }

        data = res.value(HHM_NEWS_CONTENT);
        if(data.isValid())
        {
            QQmlProperty::write(ui, "news_content2", data.toString());
        }
        else
        {
            hhm_log("News content for id " + QString::number(news_ids[last_news_index]) + " is not valid");
        }

        data = res.value(HHM_NEWS_DATE);
        if(data.isValid())
        {
            QQmlProperty::write(ui, "news_date2", data.toString());
        }
        else
        {
            hhm_log("News time for id " + QString::number(news_ids[last_news_index]) + " is not valid");
        }

    }
    else
    {
        hhm_log("Cannot find news for id " + QString::number(news_ids[last_news_index]));
    }

}

void HhmNews::updateNewsIds()
{
    news_ids.clear();
    QString query = "SELECT `" + QString(HHM_EMAIL_ID) + "` FROM `";
    query += QString(DATABASE_NAME) + "`.`" + QString(HHM_TABLE_NEWS) + "`";
    QSqlQuery res = db->sendQuery(query);

    while( res.next() )
    {
        news_ids.append(res.value(0).toInt());
    }
}
