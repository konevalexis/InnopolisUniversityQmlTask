#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QFile>
#include <QFileDialog>
#include <QTextStream>

class FileIO : public QObject
{
    Q_OBJECT
    QString m_fileName;
public:
    FileIO();

    Q_INVOKABLE QString read();
    Q_INVOKABLE void write(QString text);
    Q_PROPERTY(QString fileName READ fileName)
    QString fileName()
    {
        return m_fileName;
    }
};

#endif // FILEIO_H
