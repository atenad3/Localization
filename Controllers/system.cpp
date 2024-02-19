#include "system.h"
#include <QDebug>

System::System(QObject *parent)
    : QObject{parent}
    , m_longlist()
    , m_latlist()
{}


QVector<double> System::longlist() const
{
    return m_longlist;
}

void System::setLonglist(const QVector<double> &newLonglist)
{
    if (m_longlist == newLonglist)
        return;
    m_longlist = newLonglist;
    emit longlistChanged();
}


QVector<double> System::latlist() const
{
    return m_latlist;
}


void System::setLatlist(const QVector<double> &newLatlist)
{
    if (m_latlist == newLatlist)
        return;
    m_latlist = newLatlist;
    emit latlistChanged();
}

void System::callMe()
{

    qDebug() << "I'm being called!";

}
