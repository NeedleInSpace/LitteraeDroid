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

#include "utility.h"
#include <QDebug>
#ifdef Q_OS_ANDROID
#include <QtAndroidExtras>
#endif

Utility::Utility(QObject *parent) : QObject(parent)
{
#ifdef Q_OS_ANDROID
    QScreen* s = qApp->primaryScreen();
    QAndroidJniObject qtActivity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
    QAndroidJniObject resources = qtActivity.callObjectMethod("getResources", "()Landroid/content/res/Resources;");
    QAndroidJniObject displayMetrics = resources.callObjectMethod("getDisplayMetrics", "()Landroid/util/DisplayMetrics;");
    m_dpi = displayMetrics.getField<int>("densityDpi");
    m_pratio = displayMetrics.getField<float>("density");
    qDebug() << m_dpi << " " << m_pratio << " " << s->logicalDotsPerInch();
#else
    m_dpi = 271;
    m_pratio = 1.5;
#endif

}

int Utility::dp(const int& px)
{

    double dp = px / m_pratio;

    return dp;
}
