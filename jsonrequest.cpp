#include "jsonrequest.h"


JsonRequest::JsonRequest(QObject *parent) : QObject(parent)
{
    //connect(m_manager, &QNetworkAccessManager::finished,this, &JsonRequest::finished);
    //connect(m_manager, &QNetworkAccessManager::,this, &JsonRequest::finished);
}

void JsonRequest::sent()
{
    QNetworkRequest req(m_url);

    QByteArray d=QByteArray::fromStdString(m_method.toStdString());

    QByteArray sent= toQbyteArray(m_dataSent);
    QBuffer b(&sent);
    m_reply = m_manager->sendCustomRequest(req,d,&b);
    //connect(m_reply,&QNetworkReply::error,this,&JsonRequest::errors);
    connect(m_reply, &QNetworkReply::finished,this, &JsonRequest::finished);
}

void JsonRequest::finished()
{
    m_data=toVariantMap(m_reply->readAll());
    emit jsonReady(m_data);
}

void JsonRequest::errors(QNetworkReply *reply)
{
    qDebug()<<"errors";
}

QByteArray JsonRequest::toQbyteArray(QVariantMap map)
{
    QJsonObject obj= QJsonObject::fromVariantMap(map);
    QJsonDocument doc;
    doc.setObject(obj);
    return doc.toJson(QJsonDocument::Compact);
}

QVariantMap JsonRequest::toVariantMap(QByteArray bytes)
{
    QJsonParseError error;
    QJsonDocument doc =QJsonDocument::fromJson(bytes);
    //if(error.error==QJsonParseError::NoError){
        return doc.object().toVariantMap();
    //}
}

void JsonRequest::setDataSent(const QVariantMap &dataSent)
{
    m_dataSent = dataSent;
}

void JsonRequest::setMethod(const QString &method)
{
    m_method = method;
}

void JsonRequest::setUrl(const QUrl &url)
{
    m_url = url;
}
