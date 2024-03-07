#ifndef POINT_H
#define POINT_H

#include <QObject>

class point : public QObject
{
    Q_OBJECT
public:
    explicit point(QObject *parent = nullptr);

signals:
};

#endif // POINT_H
