#ifndef STATISTICSMODEL_H
#define STATISTICSMODEL_H
//Altered copy from previous project
#include <QQmlListProperty>
#include <QList>
#include <QFile>
#include <QDataStream>

class StatisticsElement : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)
    Q_PROPERTY(int typos READ typos WRITE setTypos NOTIFY typosChanged)
    Q_PROPERTY(qreal points READ points WRITE setPoints NOTIFY pointsChanged)

private:
    qreal m_speed;
    QString m_date;
    int m_typos;
    qreal m_points;

public:
    explicit StatisticsElement(QObject *parent = 0);

    qreal speed() const;
    void setSpeed(const qreal& s);
    QString date() const;
    void setDate(const QString& d);
    int typos() const;
    void setTypos(const int& t);
    qreal points() const;
    void setPoints(const qreal& p);

signals:
    void speedChanged();
    void dateChanged();
    void typosChanged();
    void pointsChanged();
};

class StatisticsModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<StatisticsElement> data READ data NOTIFY dataChanged)
    Q_PROPERTY(qreal average READ average NOTIFY averageChanged)
    Q_CLASSINFO("DefaultProperty", "data")

public:
    StatisticsModel(QObject *parent = 0);

    QQmlListProperty<StatisticsElement> data();
    Q_INVOKABLE void add(const qreal& s, const QString& d, const int& t, const qreal& p, bool flag);
    Q_INVOKABLE void flush_stats();
    Q_INVOKABLE int count();

    qreal average() const;
    void recalc_average();
    void read_stats();
    void append_stat_file(const qreal& s, const QString& d, const int& t, const qreal& p);

signals:
    void dataChanged();
    void averageChanged();

private:
    static void appendData(QQmlListProperty<StatisticsElement> *list, StatisticsElement *value);
    static int countData(QQmlListProperty<StatisticsElement> *list);
    static StatisticsElement* atData(QQmlListProperty<StatisticsElement> *list, int i);
    static void clearData(QQmlListProperty<StatisticsElement> *list);

    QList<StatisticsElement* > m_data;
    qreal m_average;
    QFile statistics;
};

//Helper function for file access


#endif // STATISTICSMODEL_H
