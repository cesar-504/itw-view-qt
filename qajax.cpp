#include "qajax.h"

QAjax::QAjax(QObject *parent) : QObject(parent)
{

}



QString QAjax::data()
{
    return m_data;
}

QVariantMap QAjax::dataMap()
{
    if(m_dataMapChanged){
        bool ok;
        // json is a QString containing the data to convert
        m_dataMap = m_parser.parse(m_data.toUtf8(), &ok).toMap();
        m_dataMapChanged=false;
    }
    return m_dataMap;
}

void QAjax::setType(QString value)
{
    m_type=value;
}

void QAjax::setUrl(QString value)
{
    m_url=value;
}

void QAjax::setDataSent(QVariantMap value)
{
    m_dataSent=value;
}


void QAjax::ajax(QVariantMap config)
{
     m_type= (config.contains("type"))?config["type"].toString():m_type;
     m_url= (config.contains("url"))?config["url"].toString():m_url;

       qDebug()<<m_url;
     m_manager=new QNetworkAccessManager();
     QNetworkRequest req(m_url);
     //req.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("json"));
     if(m_type.toLower()=="get") m_reply=m_manager->get(req);
     else if(m_type.toLower()=="post") m_reply=m_manager->post(req,"");
     else m_reply=m_manager->sendCustomRequest(req,m_type.toUtf8());

    connect(m_reply, &QNetworkReply::finished,this, &QAjax::finished);


}

void QAjax::get(QVariantMap config)
{


}

void QAjax::post(QVariantMap config)
{

}

void QAjax::finished()
{
    m_data =  m_reply->readAll();
    m_dataMapChanged=true;
    emit success(m_data);
    emit dataChanged();
    emit dataMapChanged();
}

void QAjax::error()
{

}

