#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QVariant>
#include "jsonrequest.h"
#include <QElapsedTimer>
#include <QQuickStyle>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDebug>
#include <QUrl>
#include <QVariant>

static QByteArray toQbyteArray(QVariantMap map)
{
    QJsonObject obj= QJsonObject::fromVariantMap(map);
    QJsonDocument doc;
    doc.setObject(obj);
    return doc.toJson(QJsonDocument::Compact);
}
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
//    JsonRequest * req=new JsonRequest();
//    req->setUrl(QUrl("http://127.0.0.1:3000/publications"));
//    req->setMethod("GET");
//    QElapsedTimer timer;
//    QObject::connect(req,&JsonRequest::jsonReady,[&timer](QVariantMap data){
//       qDebug()<<"hola";
//       qDebug()<<timer.elapsed();
//    });

//    timer.start();
//    req->sent();
    QNetworkAccessManager * manager= new QNetworkAccessManager();
    //QNetworkRequest req(QUrl("https://www.google.com"));
   // QNetworkRequest req(QUrl("http://localhost:3000/authenticate"));
    QNetworkRequest req(QUrl("http://localhost:3000/publications"));

    req.setHeader(QNetworkRequest::ContentTypeHeader,QVariant("application/vnd.api+json"));
    req.setRawHeader("Authorization","eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3MDMsImV4cCI6MTQ3NDkyNDA4MX0.NEQS3CgVwAMX7v3s1R2qfVIT9maRE96vL7ZQhoosXJA");
    QVariantMap send;
    send.insert("email",QVariant("mail@mail.com"));
    send.insert("password",QVariant("123123123"));

    QByteArray a = toQbyteArray(send);



   QNetworkReply * reply = manager->sendCustomRequest(req,"GET",new QBuffer(&a));
    //QNetworkReply * reply = manager->get(req);
   // QNetworkReply * reply = manager->post(req,a);
    QObject::connect(reply,&QNetworkReply::finished,[reply](){
       qDebug()<<reply->readAll();
    });




    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
