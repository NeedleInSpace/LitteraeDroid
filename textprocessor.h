#ifndef TEXTPROCESSOR_H
#define TEXTPROCESSOR_H
//Object that handles all the text operations within the text areas in qml
#include <random>

#include <QObject>
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
    void setText(QString s);
    qreal timer() const;
    void setTimer(qreal t);

    Q_INVOKABLE void randomiseText(const bool &);
    Q_INVOKABLE int checkState(const QString &);
    Q_INVOKABLE void startClock() { clock->start(); }

signals:

    void textChanged();
    void timerChanged();

private:

    QString m_text;
    QStringList textList;
    qreal m_timer;
    QTimer* clock;

private slots:

    void updateTimer();
};

#endif // TEXTPROCESSOR_H
