#ifndef MAP_H
#define MAP_H

#include <QMainWindow>

class map: public QMainWindow
{
    Q_OBJECT
public:
    map();

private:
    QWidget *window = nullptr;


};

#endif // MAP_H
