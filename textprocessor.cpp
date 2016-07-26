#include "textprocessor.h"

TextProcessor::TextProcessor(QObject *parent) : QObject(parent)
{
    file.setFileName(":/texts.tst");
    readFile();
    clock = new QTimer;
    connect(clock, SIGNAL(timeout()),this,SLOT(updateTimer()));
    m_timer = 0;
    clock->setSingleShot(false);
    clock->setInterval(50);
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

    m_timer += (double)clock->interval()/1000;
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




