#ifndef HHMMELICA_H
#define HHMMELICA_H

#include <QString>

class HhmMelica
{

public:
    QString brand;  // Attribute
    QString model;  // Attribute
    int year;      // Attribute
    HhmMelica (QString x, QString y, int z);
    void myMethod();

private:

};

#endif // HHMMELICA_H
