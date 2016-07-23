#include "statisticsmodel.h"

StatisticsModel::StatisticsModel(QObject *parent)
    : QAbstractListModel(parent)
{
    insertRow(12,"Today",3);

}


int StatisticsModel::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    return m_data.size();
}

QVariant StatisticsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role) {

    case SpeedRole:
        return m_data.at(index.row())->speed();
    case DateRole:
        return m_data.at(index.row())->date();
    case TyposRole:
        return m_data.at(index.row())->typo();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> StatisticsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[SpeedRole] = "speed";
    roles[DateRole] = "date";
    roles[TyposRole] = "typos";


    return roles;
}



bool StatisticsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {

        switch (role) {

        case SpeedRole:
            m_data[index.row()]->speedSet(value.toDouble());
            break;
        case DateRole:
            m_data[index.row()]->dateSet(value.toString());
            break;
        case TyposRole:
            m_data[index.row()]->typoSet(value.toInt());
            break;
        default:
            return false;
        }
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}


void StatisticsModel::insertRow(const qreal &spd,
                                const QString &date,
                                const int &t)
{
    StatisticsElement* se = new StatisticsElement(spd,date,t);
    beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
    m_data.append(se);
    endInsertRows();
    qDebug("Row added");

}

//Flag to make Qt know whenever data can be edited or not (not essential)
Qt::ItemFlags StatisticsModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}
