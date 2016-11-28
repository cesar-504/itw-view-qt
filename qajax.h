#ifndef QAJAX_H
#define QAJAX_H

#include <QObject>
#include <QDebug>
#include <QVariant>
#include <QVariantList>
#include <QVariantMap>
#include <QByteArray>

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QStringList>
#include <QJsonDocument>
#include <QJsonObject>

class QAjax : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString data READ data  NOTIFY dataChanged)
    Q_PROPERTY(QVariantMap dataMap READ dataMap WRITE setDataMap  NOTIFY dataChanged)

    Q_PROPERTY(QString type  READ type  WRITE setType NOTIFY requestChanged)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY requestChanged )
    Q_PROPERTY(QVariantMap dataSent READ dataSent WRITE setDataSent NOTIFY requestChanged)
    Q_PROPERTY(QString errorString READ errorString NOTIFY errorChanged)
    Q_PROPERTY(int errorCode READ errorCode NOTIFY errorChanged)
    Q_PROPERTY(QString authorization READ authorization WRITE setAuthorization NOTIFY authorizationChanged)
public:
    explicit QAjax(QObject *parent = 0);

    //gets
    QString data();
    QVariantMap dataMap();

    QString type ()const{return m_type ;}
    QString url()const{return m_url;}
    QVariantMap dataSent()const{return m_dataSent;}
    QString errorString()const{return m_errorString;}
    QString authorization()const{return m_authorization;}
    int errorCode()const{return m_errorCode;}
    //sets
    void setType (QString value);
    void setUrl(QString value);
    void setDataSent(QVariantMap value);
    void setDataMap(QVariantMap value);

    //fns
    Q_INVOKABLE void send();


    void setAuthorization(const QString value);

signals:
    void success(QString data);
    void error(int code,QString data);

    void dataChanged();
    void requestChanged();
    void errorChanged(int code,QString data);
    void authorizationChanged();
public slots:
    void finishSlot();
    void errorSlot(QNetworkReply::NetworkError code);
    void mergeData(QString data);
protected:
    QVariantMap jsonToMap(QString data);
    QByteArray MapToJson(QVariantMap data);
    QNetworkAccessManager * m_manager=new QNetworkAccessManager();
    QNetworkReply *m_reply;
    QString  m_data = QString();
    QVariantMap  m_dataMap= QVariantMap();
    QString m_authorization="";
    bool m_dataMapChanged=true;

    QString m_type="get";
    QString m_url="";
    QString m_dataType="application/json";
    QVariantMap m_dataSent=QVariantMap();
    QString m_errorString="";
    int m_errorCode=0;



};


#endif // QAJAX_H
