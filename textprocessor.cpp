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

#include "textprocessor.h"

TextProcessor::TextProcessor(QObject *parent) : QObject(parent)
{
    file.setFileName(":/texts.tst");
    readFile();
    clock = new QTimer;
    clock->setTimerType(Qt::PreciseTimer);
    connect(clock, SIGNAL(timeout()),this,SLOT(updateTimer()));
    m_timer = 0;
    clock->setSingleShot(false);
    clock->setInterval(20);
    m_text = "The quick brown fox jumps over the lazy dog";
}

QString TextProcessor::text() const {

    return m_text;
}

void TextProcessor::setText(const QString &s) {

    if(m_text == s) {
        return;
    }
    m_text = s;

    emit textChanged();
}

qreal TextProcessor::timer() const {

    return m_timer;
}

void TextProcessor::setTimer(const qreal &t) {

    if(m_timer == t) {
        return;
    }
    m_timer = t;

    emit timerChanged();
}

void TextProcessor::clockReset() {
    clock->stop();
    m_timer = 0;
    emit timerChanged();
}

void TextProcessor::randomiseText(const bool& flag) {

    if (flag) {
        QTime ct(QTime::currentTime());
        std::default_random_engine eng(ct.msecsSinceStartOfDay());
        std::uniform_int_distribution<int> dist(0,textList.length() - 1);

        m_text = textList.at(dist(eng));
    }
    else
        m_text = "The quick brown fox jumps over the lazy dog";

    emit textChanged();
}

int TextProcessor::checkState(const QString& input) {

    if (m_text.contains(input)) {
        if (m_text.length() == input.length()){
            //Stop timer, return code 0  - complete
            typoFlag = false;
            clock->stop();
            return 0;
        }
        else {
            typoFlag = false;
            return 1;
        } // code 1 - text OK, not complete
    }
    else if (!typoFlag) {
        typoFlag = true;
        return 2;
    } // code 2 - text ADDTYPO, not complete
    else {
        return 3;
    } // code 3 - text ERR, not complete

}

void TextProcessor::updateTimer() {

    m_timer += 0.02;
    emit timerChanged();
}

void TextProcessor::readFile()
{

    if(!file.open(QFile::ReadOnly | QFile::Text)) {

        return;
    }
    QTextStream stream(&file);
    while (!stream.atEnd()) {
        textList.push_back(stream.readLine());
    }
    file.close();

}




