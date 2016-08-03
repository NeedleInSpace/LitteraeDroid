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
