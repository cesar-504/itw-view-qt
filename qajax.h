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
#include "lib/qjson/parser.h"
#include <QStringList>

class QAjax : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString data READ data  NOTIFY dataChanged)
    Q_PROPERTY(QVariantMap dataMap READ dataMap  NOTIFY dataChanged)

    Q_PROPERTY(QString type  READ type  WRITE setType NOTIFY requestChanged)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY requestChanged )
    Q_PROPERTY(QVariantMap dataSent READ dataSent WRITE setDataSent NOTIFY requestChanged)

public:
    explicit QAjax(QObject *parent = 0);


    //gets
    QString data();
    QVariantMap dataMap();

    QString type ()const{return m_type ;}
    QString url()const{return m_url;}
    QVariantMap dataSent()const{return m_dataSent;}
    QStringList urls()const{return m_urls;}
    //sets
    void setType (QString value);
    void setUrl(QString value);
    void setDataSent(QVariantMap value);
    //fns
    Q_INVOKABLE void send();


signals:
    void success(QString data);
    void error(int code,QString data);

    void dataChanged();
    void requestChanged();

public slots:
    void finishSlot();
    void errorSlot(QNetworkReply::NetworkError code);
    void mergeData(QString data);
protected:
    QVariantMap jsonToMap(QString data);


    QJson::Parser m_parser;
    QNetworkAccessManager * m_manager=new QNetworkAccessManager();
    QNetworkReply *m_reply;
    QString  m_data = QString();
    QVariantMap  m_dataMap= QVariantMap();

    bool m_dataMapChanged=true;

    QString m_type="get";
    QString m_url="";
    QStringList m_urls=QStringList();
    QVariantMap m_dataSent=QVariantMap();


};

#endif // QAJAX_H
