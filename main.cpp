#include "mainwindow.h"

#include <QApplication>

#include <QCoreApplication>
#include <QtSql>
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QMessageBox>
#include <QVector>



int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("test_cells");
    db.setUserName("atefe");
    db.setPassword("atefe1234");

    // Check if the connection is successful
    if (!db.open()) {
        qDebug() << "Failed to connect to the database:" << db.lastError().text();
        return -1;
    }

    qDebug() << "Connected to the database";

    // Use the connection for database operations
    QSqlQuery query;

    // Execute the SELECT query
    if (!query.exec("SELECT `Latitude`,`Longitude` FROM Drive_Test")) {
        qDebug() << "Query Error:" << query.lastError().text();
        db.close();
        return -1;
    }
    //

    QVector<double> LatList;
    QVector<double> LongList;

    // Process the result set
    while (query.next()) {
        // Retrieve and store the Node Id in the QVector
        double lat = query.value("Latitude").toDouble();
        LatList.append(lat);

        double lng = query.value("Longitude").toDouble();
        LongList.append(lng);

        // Print the contents of the list
        qDebug() << "lng values:";
        // for (double lng : LongList) {
        //     qDebug() << lng;
        // }



        // // Retrieve and print the Node Id from the result set
        // qDebug() << "Latitude: " << query.value("Latitude").toString();
        // qDebug() << "Longitude: " << query.value("Longitude").toString();
    }

    // Close the database connection when done with database operations
    db.close();

    MainWindow w;
    w.show();
    return a.exec();
}
