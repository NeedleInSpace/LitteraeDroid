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
    Q_INVOKABLE void clockReset();


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
    bool typoFlag;

private slots:

    void updateTimer();
};

#endif // TEXTPROCESSOR_H
