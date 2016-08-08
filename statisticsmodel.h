/****************************************************************************
** This file is part of LitteraeDroid program
** Copyright (C) 2016 The Needle Company
** Contact: needleinspace@gmail.com
**
** This program is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program.  If not, see <http://www.gnu.org/licenses/>.
**
****************************************************************************/

#ifndef STATISTICSMODEL_H
#define STATISTICSMODEL_H
//Statistics tracking system
#include <QAbstractListModel>
#include <QAbstractTableModel>
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

//Data can be accessed by index or by role name in qml
class StatisticsModel : public QAbstractTableModel
{
    Q_OBJECT
    Q_PROPERTY(qreal average READ average NOTIFY averageChanged)
    Q_PROPERTY(int best READ best NOTIFY bestChanged)

public:

    enum Roles {
        SpeedRole = Qt::UserRole + 1,
        DateRole,
        TyposRole,
        PointsRole,
    };

    StatisticsModel(QObject *parent = 0);

    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;

    bool setData(const QModelIndex &index, const QVariant &value, int role);
    Qt::ItemFlags flags(const QModelIndex &index) const;

    Q_INVOKABLE void add(const qreal& s, const QString& d, const int& t, const qreal& p, bool);
    Q_INVOKABLE void flush_stats();
    Q_INVOKABLE QString last();

    qreal average() const;
    void recalc_average();
    int best() const;
    void read_stats();
    void append_stat_file(const qreal& s, const QString& d, const int& t, const qreal& p);

signals:
    void averageChanged();
    void bestChanged();

private:

    QList<StatisticsElement* > m_data;
    qreal m_average;
    int m_best;
    QFile statistics;
};

#endif // STATISTICSMODEL_H
