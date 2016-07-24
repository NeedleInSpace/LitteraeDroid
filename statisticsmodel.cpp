#include "statisticsmodel.h"

StatisticsElement::StatisticsElement(QObject *parent) : QObject(parent)
{

}

qreal StatisticsElement::speed() const {

    return m_speed;
}

void StatisticsElement::setSpeed(const qreal& s) {

    if(m_speed == s) {

        return;
    }
    m_speed = s;
    emit speedChanged();
}

QString StatisticsElement::date() const {

    return m_date;
}

void StatisticsElement::setDate(const QString& d) {

    if(m_date == d) {

        return;
    }
    m_date = d;
    emit dateChanged();
}

int StatisticsElement::typos() const {

    return m_typos;
}

void StatisticsElement::setTypos(const int& t) {

    if(m_typos == t) {

        return;
    }
    m_typos = t;
    emit typosChanged();
}

qreal StatisticsElement::points() const {

    return m_points;
}

void StatisticsElement::setPoints(const qreal &p) {

    if(m_points == p) {

        return;
    }
    m_points = p;
    emit pointsChanged();
}

// StatisticsElement DEFINITION STARTS

StatisticsModel::StatisticsModel(QObject *parent) : QObject(parent)
{
    statistics.setFileName("stats.tst");
    read_stats();
    add((qreal)12, "Today", 3, 2000, false);
}

// MUST-BE-DEFINED FUNCTIONS (CREATES ELEMENTS IN STATIC MODE)

QQmlListProperty<StatisticsElement> StatisticsModel::data() {

    return QQmlListProperty<StatisticsElement>(static_cast<QObject *>(this), static_cast<void *>(&m_data),
                                       &StatisticsModel::appendData, &StatisticsModel::countData,
                                       &StatisticsModel::atData, &StatisticsModel::clearData);
}

void StatisticsModel::appendData(QQmlListProperty<StatisticsElement> *list, StatisticsElement *value) {

    QList<StatisticsElement*> *data = static_cast<QList<StatisticsElement*> *>(list->data);
    data->append(value);
}

int StatisticsModel::countData(QQmlListProperty<StatisticsElement> *list) {

    QList<StatisticsElement*> *data = static_cast<QList<StatisticsElement*> *>(list->data);
    return data->size();
}

StatisticsElement* StatisticsModel::atData(QQmlListProperty<StatisticsElement> *list, int i) {

    QList<StatisticsElement*> *data = static_cast<QList<StatisticsElement*> *>(list->data);
    return data->at(i);
}

void StatisticsModel::clearData(QQmlListProperty<StatisticsElement> *list) {

    QList<StatisticsElement*> *data = static_cast<QList<StatisticsElement*> *>(list->data);
    qDeleteAll(data->begin(), data->end());
    data->clear();
}

// CUSTOM ACCESS FUNCTIONS (CREATES ELEMENTS IN ACTIVE MODE)

int StatisticsModel::count() {

    return m_data.length();
}

void StatisticsModel::add(const qreal& s, const QString& d, const int& t, const qreal &p, bool flag) {
    //flag added for write/not write into stats file
    StatisticsElement *st = new StatisticsElement(this);
    st->setProperty("speed", s);
    st->setProperty("date", d);
    st->setProperty("typos", t);
    m_data.append(st);
    recalc_average();
    if (flag)
        append_stat_file(s, d, t, p);

    emit dataChanged();
}

qreal StatisticsModel::average() const{

    return m_average;
}

void StatisticsModel::recalc_average() {

    qreal avg = 0;
    for (StatisticsElement* f : m_data){
        avg += f->speed();
    }
    m_average = avg/m_data.count();
    emit averageChanged();
}

//FILE FUNCTIONS

void StatisticsModel::append_stat_file(const qreal &s, const QString &d, const int &t, const qreal &p) {

    if (!statistics.open(QFile::WriteOnly | QFile::Append)) {
        qDebug("Cannot open stats file to append");
        return;
    }
    QDataStream stream(&statistics);
    stream << s << d << t << p;
    statistics.close();
}

void StatisticsModel::read_stats() {

    QString date;
    qreal speed;
    int typos;
    qreal points;
    if (!statistics.open(QFile::ReadOnly)) {
        qDebug("Cannot open stats file to read");
        return;
    }
    QDataStream stream(&statistics);
    while (!stream.atEnd()){
        stream >> speed >> date >> typos >> points;
        add(speed, date, typos, points, false);
    }
    statistics.close();
    emit dataChanged();
}

void StatisticsModel::flush_stats () {

    m_data.clear();
    if (!statistics.open(QFile::WriteOnly | QFile::Truncate)) {
        qDebug("Cannot open stats file to clear");
        return;
    }
    qDebug("Flie clear");
    statistics.write("");
    statistics.close();
    emit dataChanged();
}
