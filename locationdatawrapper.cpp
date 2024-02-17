#include "locationdatawrapper.h"
#include <QSqlQuery>
#include <QSqlError>


LocationDataWrapper::LocationDataWrapper(QObject *parent) : QObject(parent)

{

    fetchDataFromDatabase();

}


QVector<double> LocationDataWrapper::latitudeList() const
{

    return m_latitudeList;

}


QVector<double> LocationDataWrapper::longitudeList() const

{

    return m_longitudeList;

}


void LocationDataWrapper::fetchDataFromDatabase()
{

    QSqlQuery query;
    // Assuming db is your QSqlDatabase object and query is your QSqlQuery object
    if (!query.exec("SELECT `Latitude`,`Longitude` FROM Drive_Test")) {

        qDebug() << "Query Error:" << query.lastError().text();

        return;

    }


    while (query.next()) {

        double lat = query.value("Latitude").toDouble();

        m_latitudeList.append(lat);
        double lng = query.value("Longitude").toDouble();
        m_longitudeList.append(lng);

    }

    emit dataChanged();
}
