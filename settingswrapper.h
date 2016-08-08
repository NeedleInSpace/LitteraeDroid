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

#ifndef SETTINGSWRAPPER_H
#define SETTINGSWRAPPER_H
//Wrapper for qt settings class for use in qml
#include <QObject>
#include <QSettings>

class SettingsWrapper : public QSettings
{
    Q_OBJECT

public:
    explicit SettingsWrapper(QObject *parent = 0) : QSettings("config.ini", QSettings::IniFormat, parent)
    {

    }
    Q_INVOKABLE inline void setValue(const QString &key
                                    ,const QVariant &value)
    {
        QSettings::setValue(key, value);
    }
    Q_INVOKABLE inline QVariant value(const QString &key
                                     ,const QVariant &defaultValue = QVariant()) const
    {
        return QSettings::value(key, defaultValue);
    }
};

Q_DECLARE_METATYPE(SettingsWrapper*)

#endif // SETTINGSWRAPPER_H
