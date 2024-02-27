#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QQuickItem>
#include <QtSql>
#include <QQmlEngine>
#include <QQmlContext>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>



// #include <QtWebEngineWidgets/QWebEngineView>
// #include <QtWebEngineWidgets/QWebEnginePage>
// #include <QtWebEngineWidgets/QWebEngineSettings>

// QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    ui->quickWidget->engine()->rootContext()->setContextProperty("mapObj", this);
    ui->quickWidget->setSource(QUrl(QStringLiteral("qrc:/map.qml")));

    auto obj = ui->quickWidget->rootObject();
    // connect(this, SIGNAL(setCenter(QVariant,QVariant)),obj, SLOT(setCenter(QVariant, QVariant)));

    // emit setCenter(35.73661,51.29013);
    QObject::connect(obj, SIGNAL(sampleSignal()), this, SLOT(receiveSignal()), Qt::QueuedConnection);
    QObject::connect(obj, SIGNAL(sampleSignal2()), this, SLOT(on_pushButton_clicked()), Qt::QueuedConnection);




    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setDatabaseName("test_cells");
    db.setUserName("atefe");
    db.setPassword("atefe1234");





    if (!db.open()) {
        qDebug() << "Failed to connect to the database:" << db.lastError().text();
    }



    //     connect(this, SIGNAL(setCenter(QVariant,QVariant)),obj, SLOT(setCenter(QVariant, QVariant)));

    ui->quickWidget->show();
    // emit setCenter(35.73661,51.29013);

}

// void MainWindow::sample_Sig()
// {
//     qDebug() << a;

//     emitSig();
// }


void MainWindow::receiveSignal()
{
    qDebug() << "signal received";//be jay in bayad variable ro masalan print konim.

    emitSig();
}



MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{

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
        printf("salam");

    }
    emitSig();

}
