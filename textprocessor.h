#ifndef TEXTPROCESSOR_H
#define TEXTPROCESSOR_H
//Object that handles all the text operations within the text areas in qml
#include <random>

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QTime>
#include <QTimer>

class TextProcessor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(int timer READ timer WRITE setTimer NOTIFY timerChanged)

public:
    explicit TextProcessor(QObject *parent = 0);

    QString text() const;
    void setText(const QString& s);
    int timer() const;
    void setTimer(const int &t);

    Q_INVOKABLE void randomiseText(const bool &);
    Q_INVOKABLE int checkState(const QString &);
    Q_INVOKABLE void startClock() { clock->start(); }
    Q_INVOKABLE void clockReset();


signals:

    void textChanged();
    void timerChanged();

private:

    void readFile();

    QString m_text;
    QStringList textList;
    int m_timer;
    QTimer* clock;
    QFile file;
    bool typoFlag;

private slots:

    void updateTimer();
};

#endif // TEXTPROCESSOR_H
