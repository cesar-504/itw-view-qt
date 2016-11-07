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


class QAjax : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString data READ data  NOTIFY dataChanged)
    Q_PROPERTY(QVariantMap dataMap READ dataMap  NOTIFY dataMapChanged)

    Q_PROPERTY(QString type  READ type  WRITE setType )
    Q_PROPERTY(QString url READ url WRITE setUrl )
    Q_PROPERTY(QVariantMap dataSent READ dataSent WRITE setDataSent )







public:
    explicit QAjax(QObject *parent = 0);


    //gets
    QString data();
    QVariantMap dataMap();

    QString type ()const{return m_type ;}
    QString url()const{return m_url;}
    QVariantMap dataSent()const{return m_dataSent;}
    //sets
    void setType (QString value);
    void setUrl(QString value);
    void setDataSent(QVariantMap value);
    //fns
    Q_INVOKABLE void ajax(QVariantMap config=QVariantMap());
    Q_INVOKABLE void get(QVariantMap config=QVariantMap());
    Q_INVOKABLE void post(QVariantMap config=QVariantMap());

signals:
    void success(QString data);
    void error(QString data);

    void dataChanged();
    void dataMapChanged();
public slots:
    void finished();
    void error();
protected:
    QJson::Parser m_parser;

    QNetworkAccessManager * m_manager=new QNetworkAccessManager();
    QNetworkReply *m_reply;
    QString  m_data = QString();
    QVariantMap  m_dataMap= QVariantMap();

    bool m_dataMapChanged=true;

    QString m_type="get";
    QString m_url="./";
    QVariantMap m_dataSent=QVariantMap();

};

#endif // QAJAX_H
