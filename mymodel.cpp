#include "mymodel.h"
#include <QSqlQuery>
#include <QSqlError>

MyModel::MyModel(QObject *parent)
    : QAbstractTableModel(parent)
{
    fetchData(); // Fetch data when the model is created
}

int MyModel::rowCount(const QModelIndex & /*parent*/) const
{
    return m_data.size();
}

int MyModel::columnCount(const QModelIndex & /*parent*/) const
{
    if (m_data.isEmpty())
        return 0;
    else
        return m_data.first().size();
}

QVariant MyModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole && orientation == Qt::Horizontal) {
        // Fetch headers from the first row
        if (section >= 0 && section < m_data.first().size())
            return m_data.first().at(section);
    }
    return QVariant();
}


QVariant MyModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (role == Qt::DisplayRole) {
        // Fetch data from the corresponding row and column
        if (index.row() >= 0 && index.row() < m_data.size() &&
            index.column() >= 0 && index.column() < m_data.first().size()) {
            return m_data.at(index.row()).at(index.column());
        }
    }

    return QVariant();
}


void MyModel::fetchData()
{
    // Clear existing data
    beginResetModel();
    m_data.clear();
    endResetModel();

    QString queryStr = QString("SELECT `Latitude`, `Longitude`, `Node Id`, `sigPowS`,`sigQualS`, `sigQualSName` FROM Drive_Test");
    QSqlQuery query(queryStr);

    if(!query.exec()){
        qDebug() << "Query Error:" << query.lastError().text();
        return;
    }

    // Fetch column names
    QStringList headers;
    for (int i = 0; i < query.record().count(); ++i) {
        headers << query.record().fieldName(i);
    }
    m_data[0].append(headers);

    // Fetch data rows
    while (query.next()) {
        QList<QVariant> row;
        for (int i = 0; i < query.record().count(); ++i) {
            row.append(query.value(i));
        }
        m_data.append(row);
    }

    // Emit signal to notify views that the model data has changed
    beginResetModel();
    endResetModel();
}
