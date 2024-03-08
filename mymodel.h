#ifndef MYMODEL_H
#define MYMODEL_H

#include <QWidget>
#include <QAbstractTableModel>
#include <QSqlQuery>
#include <QSqlRecord>


class MyModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit MyModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;
    void fetchData(); // Function to fetch data from MySQL database

private:
    QList<QList<QVariant>> m_data; // Data storage
};
#endif // MYMODEL_H
