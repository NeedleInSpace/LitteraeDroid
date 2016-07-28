#include "textprocessor.h"

TextProcessor::TextProcessor(QObject *parent) : QObject(parent)
{
    file.setFileName(":/texts.tst");
    readFile();
    clock = new QTimer;
    connect(clock, SIGNAL(timeout()),this,SLOT(updateTimer()));
    m_timer = 0;
    clock->setSingleShot(false);
    clock->setInterval(1000);
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

int TextProcessor::timer() const {

    return m_timer;
}

void TextProcessor::setTimer(const int &t) {

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

    m_timer += 1;
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




