#ifndef STATISTICSMODEL_H
#define STATISTICSMODEL_H

#include <QAbstractListModel>
#include <QList>

class StatisticsElement : public QObject
{
    Q_OBJECT

public:

    StatisticsElement(const qreal& spd, const QString& dt, const int& t):
        m_speed(spd), m_date(dt), m_typo(t) {}

    qreal speed() const { return m_speed; }
    QString date() const { return m_date; }
    int typo() const { return m_typo; }

    void speedSet(const qreal& s) { m_speed = s; }
    void dateSet(const QString& str) { m_date = str; }
    void typoSet(const int& i) { m_typo = i; }

private:

    qreal m_speed;
    QString m_date;
    int m_typo;
};



class StatisticsModel : public QAbstractListModel
{
    Q_OBJECT

public:

    enum Roles {

        SpeedRole = Qt::UserRole + 1,
        DateRole,
        TyposRole
    };

    explicit StatisticsModel(QObject *parent = 0);

    // Basic functionality:
    QHash<int, QByteArray> StatisticsModel::roleNames() const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    Q_INVOKABLE void insertRow(const qreal &spd = 0,
                   const QString &date = "",
                   const int &t = 0);

private:

    QList<StatisticsElement *> m_data;
};

#endif // STATISTICSMODEL_H
