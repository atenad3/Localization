#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QQuickItem>
#include <QtSql>

// #include <QtWebEngineWidgets/QWebEngineView>
// #include <QtWebEngineWidgets/QWebEnginePage>
// #include <QtWebEngineWidgets/QWebEngineSettings>

// QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    ui->quickWidget->setSource(QUrl(QStringLiteral("qrc:/map.qml")));
    ui->quickWidget->show();

    auto obj = ui->quickWidget->rootObject();
    // connect(this, SIGNAL(setCenter(QVariant,QVariant)),obj, SLOT(setCenter(QVariant, QVariant)));

    // emit setCenter(35.73661,51.29013);

}

MainWindow::~MainWindow()
{
    delete ui;
}
