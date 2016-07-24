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
    Q_PROPERTY(qreal timer READ timer WRITE setTimer NOTIFY timerChanged)

public:
    explicit TextProcessor(QObject *parent = 0);

    QString text() const;
    void setText(const QString& s);
    qreal timer() const;
    void setTimer(const qreal& t);

    Q_INVOKABLE void randomiseText(const bool &);
    Q_INVOKABLE int checkState(const QString &);
    Q_INVOKABLE void startClock() { clock->start(); }


signals:

    void textChanged();
    void timerChanged();

private:

    void readFile();

    QString m_text;
    QStringList textList;
    qreal m_timer;
    QTimer* clock;
    QFile file;

private slots:

    void updateTimer();
};

#endif // TEXTPROCESSOR_H
