#include "utility.h"

Utility::Utility(QObject *parent) : QObject(parent)
{
    QScreen* s = QGuiApplication::primaryScreen();
    m_dpi = s->logicalDotsPerInch();
    m_pratio = s->devicePixelRatio();
}

int Utility::dp(const int& px)
{

    double dp = round( (px * m_dpi / 160) * m_pratio );

    return QSysInfo::productType() == "windows" ? px : dp;
}
