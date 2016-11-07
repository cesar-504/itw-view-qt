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
#include "lib/qjson/parser.h"
#include "qajax.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<QAjax>("my.qajax", 0, 5, "QAjax");


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
