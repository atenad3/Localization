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
#include <Controllers/system.h>
#include <QQmlContext>
#include <QGuiApplication>
#include <QApplication>
#include <QTableView>
#include "mymodel.h"



int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication a(argc, argv);
    QQmlApplicationEngine engine;
    System m_systemHandler;

    QTableView tableView;
    // gridLayout = new QGridLayout(window);
    MyModel myModel;
    // to pass a pointer of it to tableView.
    tableView.setModel(&myModel);
    tableView.show();






    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("test_cells");
    db.setUserName("atefe");
    db.setPassword("atefe1234");



    const QUrl url(QStringLiteral("qrc:/map.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &a, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);



    // Expose the instance to QML
    // engine.rootContext()->setContextProperty("systemHandler", &m_systemHandler);


    // QQmlContext * context(engine.rootContext());
    QQmlContext * context = engine.rootContext();

    qmlRegisterType<System>("system", 1, 0, "System2");
    context->setContextProperty("systemHandler", &m_systemHandler); //appropriate name to expose your C++ object,You've provided a valid pointer to your C++ object when calling setContextProperty
    context->setContextProperty("appdir", QApplication::applicationDirPath());

    engine.load(url);

    // Check if the connection is successful
    if (!db.open()) {
        qDebug() << "Failed to connect to the database:" << db.lastError().text();
        return -1;
    }

    qDebug() << "Connected to the database";

    QSqlQuery query;
    // Assuming db is your QSqlDatabase object and query is your QSqlQuery object
    if (!query.exec("SELECT `Latitude`,`Longitude` FROM Drive_Test")) {

        qDebug() << "Query Error:" << query.lastError().text();

        // return;

    }

    QVector<double> latList;
    QVector<double> longList;


    while (query.next()) {

        double lat = query.value("Latitude").toDouble();

        latList.append(lat);
        double lng = query.value("Longitude").toDouble();
        longList.append(lng);

    }
























    // Create and populate the location data wrapper





    // LocationDataWrapper locationDataWrapper;
    // locationDataWrapper.fetchDataFromDatabase();


    // // Register LocationDataWrapper as a QML type
    // qmlRegisterType<LocationDataWrapper>("MyTypes", 1, 0, "LocationDataWrapper");

    // // QQmlApplicationEngine engine;
    // engine.rootContext()->setContextProperty("locationData", &locationDataWrapper);
    // engine.load(QUrl(QStringLiteral("qrc:/map.qml")));








    // Use the connection for database operations
    // QSqlQuery query;
    // QVector<double> latList;
    // QVector<double> longList;

    // Close the database connection when done with database operations

    // Expose LatList and LongList to QML
    // QQmlApplicationEngine engine;
    // engine.rootContext()->setContextProperty("latList", latList);
    // engine.rootContext()->setContextProperty("longList", longList);
    // engine.load(QUrl(QStringLiteral("qrc:/map.qml")));

    // if (engine.rootObjects().isEmpty())
    //     return -1;





    if (engine.rootObjects().isEmpty()){
        qDebug() << "no";
        return -1;
    }

    db.close();


    MainWindow w;
    w.show();
    return a.exec();
}
