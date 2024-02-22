#include "mymodel.h"
#include <QSqlQuery>
#include <QSqlError>

MyModel::MyModel(QObject *parent)
    : QAbstractTableModel(parent)
{
}

int MyModel::rowCount(const QModelIndex & /*parent*/) const
{
    return 20;
}

int MyModel::columnCount(const QModelIndex & /*parent*/) const
{
    return 3;
}

QVariant MyModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole && orientation == Qt::Horizontal) {
        switch (section) {
        case 0:
            return QString("first");
        case 1:
            return QString("second");
        case 2:
            return QString("third");
        }
    }
    return QVariant();
}


QVariant MyModel::data(const QModelIndex &index, int role) const
{
    if (role == Qt::DisplayRole)
        return QString("Row%1, Column%2")
            .arg(index.row() + 1)
            .arg(index.column() +1);

    // // QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    // QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    // db.setHostName("localhost");
    // db.setDatabaseName("test_cells");
    // db.setUserName("atefe");
    // db.setPassword("atefe1234");


    // QSqlQuery query;
    // // Assuming db is your QSqlDatabase object and query is your QSqlQuery object
    // if (!query.exec("SELECT `Latitude`,`Longitude` FROM Drive_Test")) {

    //     qDebug() << "Query Error:" << query.lastError().text();

    //     // return;

    // }

    // QVector<double> latList;
    // QVector<double> longList;


    // while (query.next()) {

    //     double lat = query.value("Latitude").toDouble();

    //     latList.append(lat);
    //     double lng = query.value("Longitude").toDouble();
    //     longList.append(lng);

    // }


    return QVariant();
}
