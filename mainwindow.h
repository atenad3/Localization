#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QVariant>

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
    void emitSig() { emit sample_Sig("sample signal"); }
    void emitMySignal();
     // { emit sample_Sig2(latList); }

public slots:
    void receiveSignal();
    // void on_pushButton_clicked();


private:
    Ui::MainWindow *ui;


signals:
    void setCenter(QVariant, QVariant);
    void sample_Sig(QString);
    void mySignal(QVector<double> ltList, QVector<double> lgList);
};
#endif // MAINWINDOW_H
