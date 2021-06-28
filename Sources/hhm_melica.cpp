#include "hhm_melica.h"
#include "QDebug"

void HhmMelica::myMethod()
{
    qDebug () << "Hello World!";
}

HhmMelica::HhmMelica(QString x, QString y, int z)
{

            brand = x;
            model = y;
            year = z;

}

