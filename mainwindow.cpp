#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QQuickItem>
#include <QtSql>
#include <QQmlEngine>
#include <QQmlContext>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <stdio.h>
#include <typeinfo>
#include <iostream>


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    //establishes a communication bridge between C++ and QML.'setContextProperty' allows
    //C++ variables to be exposed to QML.
    //Here, mapObj is a variable in QML that is bound to this (the current object) in C++
    ui->quickWidget->engine()->rootContext()->setContextProperty("mapObj", this);
    //This line sets the source QML file to be loaded into the QuickWidget
    ui->quickWidget->setSource(QUrl(QStringLiteral("qrc:/map.qml")));

    auto obj = ui->quickWidget->rootObject();
    // connect(this, SIGNAL(setCenter(QVariant,QVariant)),obj, SLOT(setCenter(QVariant, QVariant)));

    // emit setCenter(35.73661,51.29013);
    QObject::connect(obj, SIGNAL(sampleSignal(QString)), this, SLOT(receiveSignal(QString)), Qt::QueuedConnection);


    //connect to database
    // qDebug() << "signal received";//be jay in bayad variable ro masalan print konim.

    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("test_cells");
    db.setUserName("atefe");
    db.setPassword("atefe1234");


    if (!db.open()) {
        qDebug() << "Failed to connect to the database:" << db.lastError().text();
    }
    else {
        qDebug() << "connected to db";
    }

    ui->quickWidget->show();
    // emit setCenter(35.73661,51.29013);
}


void MainWindow::receiveSignal(const QString &id)
{
    emitMySignal(id);
}


MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::emitMySignal(const QString &id){


    // QString nodeId = "2926";
    // QString s = QString::number(id);
    QString nodeId = id;
    std::cout << typeid(id).name() << std::endl;
    QString queryStr = QString("SELECT `Latitude`, `Longitude`, `Node Id` FROM Drive_Test WHERE `Node Id` = %1").arg(nodeId);
    QSqlQuery query(queryStr);

    if(!query.exec()){
        qDebug() << "Query Error:" << query.lastError().text();
    }


    QVector<double> latList;
    QVector<double> longList;

    while (query.next()) {

        double lat = query.value("Latitude").toDouble();
        latList.append(lat);

        double lng = query.value("Longitude").toDouble();
        longList.append(lng);
        // putc(longList, stdout);

        QString nodeId = query.value("Node Id").toString();

        // qDebug()<< "Node Id:" << nodeId;

    }

    emit mySignal(latList, longList);
}

