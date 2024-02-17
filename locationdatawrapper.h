#ifndef LOCATIONDATAWRAPPER_H
#define LOCATIONDATAWRAPPER_H

#include <QObject>
#include <QVector>
#include <QDebug>


 // LocationDataWrapper subclasses from Qobject.
class LocationDataWrapper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<double> latitudeList READ latitudeList NOTIFY dataChanged)
    Q_PROPERTY(QVector<double> longitudeList READ longitudeList NOTIFY dataChanged)

public:
    explicit LocationDataWrapper(QObject *parent = nullptr);

    QVector<double> latitudeList() const;
    QVector<double> longitudeList() const;

    void fetchDataFromDatabase();

signals:
    void dataChanged();

private:
    QVector<double> m_latitudeList;
    QVector<double> m_longitudeList;
};

#endif // LOCATIONDATAWRAPPER_H
