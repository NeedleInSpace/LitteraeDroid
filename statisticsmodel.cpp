#include "statisticsmodel.h"

StatisticsElement::StatisticsElement(QObject *parent) : QObject(parent)
{

}

qreal StatisticsElement::speed() const
{
    return m_speed;
}

void StatisticsElement::setSpeed(const qreal& s)
{
    if(m_speed == s) {
        return;
    }
    m_speed = s;
    emit speedChanged();
}

QString StatisticsElement::date() const
{
    return m_date;
}

void StatisticsElement::setDate(const QString& d)
{
    if(m_date == d) {
        return;
    }
    m_date = d;
    emit dateChanged();
}

int StatisticsElement::typos() const
{
    return m_typos;
}

void StatisticsElement::setTypos(const int& t)
{
    if(m_typos == t) {
        return;
    }
    m_typos = t;
    emit typosChanged();
}

qreal StatisticsElement::points() const
{
    return m_points;
}

void StatisticsElement::setPoints(const qreal &p)
{
    if(m_points == p) {
        return;
    }
    m_points = p;
    emit pointsChanged();
}

// StatisticsModel DEFINITION STARTS

StatisticsModel::StatisticsModel(QObject *parent) : QAbstractTableModel(parent)
{
    m_best = 0;
    statistics.setFileName("stats.tst");
    read_stats();
}

QHash<int, QByteArray> StatisticsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[SpeedRole] = "speed";
    roles[DateRole] = "date";
    roles[TyposRole] = "typos";
    roles[PointsRole] = "points";

    return roles;
}

int StatisticsModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_data.size();
}

int StatisticsModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 4;
}

QVariant StatisticsModel::data(const QModelIndex &index, int role) const
{
    int pos = index.row();
    int col = index.column();
    switch(role) {

    case SpeedRole:
        return m_data[pos]->speed();
        break;
    case DateRole:
        return m_data[pos]->date();
        break;
    case TyposRole:
        return m_data[pos]->typos();
        break;
    case PointsRole:
        return m_data[pos]->points();
        break;
    default:
        switch (col) {

        case 0:
            return m_data[pos]->speed();
            break;
        case 1:
            return m_data[pos]->date();
            break;
        case 2:
            return m_data[pos]->typos();
            break;
        case 3:
            return m_data[pos]->points();
            break;
        default:
            return QVariant();
        }
    }
}

bool StatisticsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    int pos = index.row();
    int col = index.column();
    if(data(index, role) != value) {
        switch(col) {

        case 1:
            m_data[pos]->setSpeed(value.toDouble());
            break;
        case 2:
            m_data[pos]->setDate(value.toString());
            break;
        case 3:
            m_data[pos]->setTypos(value.toInt());
            break;
        case 4:
            m_data[pos]->setPoints(value.toDouble());
            break;
        default:
            return false;
        }
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

void StatisticsModel::add(const qreal& s, const QString& d, const int& t, const qreal &p, bool flag)
{
    //flag added for write/not write into stats file
    StatisticsElement *st = new StatisticsElement(this);
    st->setProperty("speed", s);
    st->setProperty("date", d);
    st->setProperty("typos", t);
    st->setProperty("points", p);

    beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
    m_data.append(st);
    endInsertRows();

    if(p > m_data[m_best]->points()) {
        m_best = m_data.size() - 1;
        emit bestChanged();
    }

    recalc_average();
    if (flag)
        append_stat_file(s, d, t, p);

}

Qt::ItemFlags StatisticsModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractTableModel::flags(index) | Qt::ItemIsEditable;
}

QString StatisticsModel::last()
{
    QString result;
    int i = m_data.size() - 1;
    result = "\nSpeed: " + QString::number(m_data[i]->speed()) + " cpm\n" +
            "Typos: " + QString::number(m_data[i]->typos()) +
            "\nTotal points: " + QString::number(m_data[i]->points());
    return result;
}

qreal StatisticsModel::average() const
{
    return m_average;
}

void StatisticsModel::recalc_average()
{
    qreal avg = 0;
    for (StatisticsElement* f : m_data){
        avg += f->points();
    }
    m_average = avg/m_data.count();
    emit averageChanged();
}

int StatisticsModel::best() const
{
    return m_best;
}

//FILE FUNCTIONS

void StatisticsModel::append_stat_file(const qreal &s, const QString &d, const int &t, const qreal &p)
{
    if (!statistics.open(QFile::WriteOnly | QFile::Append)) {
        qDebug("Cannot open stats file to append");
        return;
    }
    QDataStream stream(&statistics);
    stream << s << d << t << p;
    statistics.close();
}

void StatisticsModel::read_stats()
{
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
}

void StatisticsModel::flush_stats ()
{
    beginRemoveRows(QModelIndex(), 0, m_data.size());
    m_data.clear();
    endRemoveRows();
    m_average = 0;
    emit averageChanged();
    if (!statistics.open(QFile::WriteOnly | QFile::Truncate)) {
        qDebug("Cannot open stats file to clear");
        return;
    }
    qDebug("Flie clear");
    statistics.write("");
    statistics.close();
}
