#include "textprocessor.h"

TextProcessor::TextProcessor(QObject *parent) : QObject(parent)
{
    clock = new QTimer;
    connect(clock, SIGNAL(timeout()),this,SLOT(updateTimer()));
    m_timer = 0;
    clock->setSingleShot(false);
    clock->setInterval(50);
}

QString TextProcessor::text() const {

    return m_text;
}

void TextProcessor::setText(QString s) {

    if(m_text == s) {
        return;
    }
    m_text = s;

    emit textChanged();
}

qreal TextProcessor::timer() const {

    return m_timer;
}

void TextProcessor::setTimer(qreal t) {

    if(m_timer == t) {
        return;
    }
    m_timer = t;

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
            //Stop and reset timer, return code 0  - complete
            clock->stop();
            m_timer = 0;
            emit timerChanged();
            return 0;
        }
        else
            return 1; // code 1 - text OK, not complete
    }
    else
        return 2; // code 2 - text TYPO, not complete
}

void TextProcessor::updateTimer() {

    m_timer += clock->interval();

    emit timerChanged();
}

