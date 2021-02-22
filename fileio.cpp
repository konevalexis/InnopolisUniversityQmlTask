#include "fileio.h"

FileIO::FileIO()
{

}

QString FileIO::read(){
    QString url = QFileDialog::getOpenFileName();
    m_fileName = url;

    QFile file;
    file.setFileName(url);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
           return "Error! File is read only!";
    return file.readAll();

}

void FileIO::write(QString text){
    QFile file;
    file.setFileName(m_fileName);
    if(file.open(QIODevice::WriteOnly | QIODevice::Text)){
        QTextStream writeStream(&file);
        writeStream << text;
        file.close();
    }

}
