#ifndef SYSTEM_H
#define SYSTEM_H

#include <QObject>
#include <QDir>

class System : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<double> latlist READ latlist WRITE setLatlist NOTIFY latlistChanged FINAL)
    Q_PROPERTY(QVector<double> longlist READ longlist WRITE setLonglist NOTIFY longlistChanged FINAL)


public:
    explicit System(QObject *parent = nullptr);
    QVector<double> longlist() const;   
    void setLonglist(const QVector<double> &newLonglist);

    QVector<double> latlist() const;
    void setLatlist(const QVector<double> &newLatlist);


signals:
    void longlistChanged();
    void latlistChanged();

public slots:
    void callMe();


private:
    QVector<double> m_longlist;
    QVector<double> m_latlist;
};

#endif // SYSTEM_H
