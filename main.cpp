#include "mainwindow.h"
#include <QApplication>
#include <QCoreApplication>
#include <QtSql>
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QMessageBox>
#include <QVector>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "locationdatawrapper.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("test_cells");
    db.setUserName("atefe");
    db.setPassword("atefe1234");

    QQmlApplicationEngine engine;

    // Check if the connection is successful
    if (!db.open()) {
        qDebug() << "Failed to connect to the database:" << db.lastError().text();
        return -1;
    }

    qDebug() << "Connected to the database";

    // Create and populate the location data wrapper
    LocationDataWrapper locationDataWrapper;
    locationDataWrapper.fetchDataFromDatabase();


    // Register LocationDataWrapper as a QML type
    qmlRegisterType<LocationDataWrapper>("MyTypes", 1, 0, "LocationDataWrapper");

    // QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("locationData", &locationDataWrapper);
    engine.load(QUrl(QStringLiteral("qrc:/map.qml")));

    // Use the connection for database operations
    // QSqlQuery query;
    // QVector<double> latList;
    // QVector<double> longList;

    // Close the database connection when done with database operations
    db.close();

    // Expose LatList and LongList to QML
    // QQmlApplicationEngine engine;
    // engine.rootContext()->setContextProperty("latList", latList);
    // engine.rootContext()->setContextProperty("longList", longList);
    // engine.load(QUrl(QStringLiteral("qrc:/map.qml")));

    // if (engine.rootObjects().isEmpty())
    //     return -1;



    if (engine.rootObjects().isEmpty())
        return -1;

    MainWindow w;
    w.show();
    return a.exec();
}
