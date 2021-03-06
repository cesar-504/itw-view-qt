#include "qajax.h"

QAjax::QAjax(QObject *parent) : QObject(parent)
{
}


//Regresa el texto regresado por la peticion web
QString QAjax::data()
{
    return m_data;
}
//Regresa el texto regresado por la peticion web covertido en un objeto
//Qvariant o un objeto JS en QML
QVariantMap QAjax::dataMap()
{
    if(m_dataMapChanged){
        m_dataMap = jsonToMap(m_data);
        m_dataMapChanged=false;
    }
    return m_dataMap;
}

//sets
void QAjax::setType(QString value)
{
    if(m_type==value)return;
    m_type=value;
    emit requestChanged();
}

void QAjax::setUrl(QString value)
{
    if(m_url==value)return;
    m_url=value;
    emit requestChanged();
}

void QAjax::setDataSent(QVariantMap value)
{
    if(m_dataSent==value)return;
    m_dataSent=value;
    emit requestChanged();
}

void QAjax::setDataMap(QVariantMap value)
{
    if(m_dataMap==value)return;
    m_dataMap=value;
    emit dataChanged();
}

void QAjax::setAuthorization(const QString value)
{
    if(m_authorization==value)return;
    m_authorization = value;
    emit authorizationChanged();
}

//Envia una peticion asincrona con los datos guardados en el objeto
//enlaza a receptores de teminacion y errores en la peticion
void QAjax::send()
{
    m_manager=new QNetworkAccessManager();
    QNetworkRequest req(m_url);
    req.setHeader(QNetworkRequest::ContentTypeHeader,QVariant(m_dataType));

    if(!m_authorization.isEmpty())
        req.setRawHeader("Authorization",m_authorization.toUtf8());
    if(m_type.toLower()=="get") m_reply=m_manager->get(req);

    else if(m_type.toLower()=="post") {
        auto b = MapToJson(m_dataSent);
        m_reply=m_manager->post(req,b);}
        else m_reply=m_manager->sendCustomRequest(req,m_type.toUtf8());

    connect(m_reply, &QNetworkReply::finished,this, &QAjax::finishSlot);
    connect(m_reply,static_cast<void(QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),this,&QAjax::errorSlot);
}

//Convierte de texto json a un objeto QVarianMAp
QVariantMap QAjax::jsonToMap(QString data)
{
    if(data.isEmpty()) return QVariantMap();
    QJsonParseError* error = new QJsonParseError();
    QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8(),error);
    QVariantMap m =doc.object().toVariantMap();
    return m;
}
//Convierte de un objeto QVariantMap a un texto json
QByteArray QAjax::MapToJson(QVariantMap data)
{
    QJsonObject obj = QJsonObject::fromVariantMap(data);
    QJsonDocument doc = QJsonDocument(obj);
    return doc.toJson();
}

// Acciones que realizar al teminar correctamente una peticion
void QAjax::finishSlot()
{
    if((int)m_reply->error()!=0) return;
    m_errorCode=0;
    m_errorString="";
    errorChanged(0,"");
    m_data =  m_reply->readAll();
    m_dataMapChanged=true;
    emit success(m_data);
    emit dataChanged();

    m_reply->deleteLater();
}
// Acciones que realizar al teminar con errores una peticion
void QAjax::errorSlot(QNetworkReply::NetworkError code)
{
    qDebug()<<(int)code;
    qDebug()<<m_reply->errorString();
    m_errorCode=(int)code;
    m_errorString=m_reply->errorString();
    errorChanged(m_errorCode,m_errorString);
    emit error((int)code,m_reply->errorString());

    m_reply->deleteLater();
}
// agrega a data los valores de un json diferente
void QAjax::mergeData(QString data)
{
    QVariantMap olm=dataMap();
    QVariantMap newm= jsonToMap(data);
    auto i= newm.constBegin();
    while (i != newm.constEnd()) {

        ++i;
    }

}


