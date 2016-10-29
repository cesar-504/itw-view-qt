#ifndef JSONREQUEST_H
#define JSONREQUEST_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>
#include <QUrl>
#include <QVariant>
#include <QBuffer>
class JsonRequest : public QObject
{
    Q_OBJECT


public:
    explicit JsonRequest(QObject *parent = 0);

    QVariantMap data(){return m_data;}


    void sent();
    void setUrl(const QUrl &url);

    void setMethod(const QString &method);

    void setDataSent(const QVariantMap &dataSent);

signals:
    void jsonReady(QVariantMap data);
    void requestError(QVariantMap data);

public slots:
    void finished();
    void errors(QNetworkReply * reply);
private:

    QNetworkAccessManager * m_manager=new QNetworkAccessManager();


    static QByteArray toQbyteArray(QVariantMap map);
    static QVariantMap toVariantMap(QByteArray bytes);

    QNetworkReply *m_reply;
    QUrl m_url;
    QString m_method="GET";
    QVariantMap m_dataSent;
    QVariantMap m_data;

};

#endif // JSONREQUEST_H
