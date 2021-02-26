import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

import konev.io 1.0
import "./UIComponents"

Window {
    width: 400
    height: 480
    minimumHeight: 480
    minimumWidth: 400
    visible: true
    title: qsTr("JSON to model converter")

    color: "#171717"

    FileIO{
        id: fileIO
    }

    Text {
        id: fileName

        anchors{
            left: parent.left
            top: parent.top
            right: parent.right
            leftMargin: 10
            topMargin: 10
            rightMargin: 10
        }
        width: parent.width - anchors.leftMargin - anchors.rightMargin
        wrapMode: Text.WordWrap

        text: "Выбранный файл: "

        color: "#E1E1E1"
        font{
            pixelSize: 14
            bold: true
        }
    }

    JsonListModel{
        id: jsonListModel
    }

    ListView{
        id: jsonList
        anchors{
            left: parent.left
            top: fileName.bottom
            right: parent.right
            bottom: openBtn.top

            margins: 10
        }

        clip: true

        model: jsonListModel

        delegate: Item{
            property alias innerLoader: loader

            width: jsonList.width
            height: 40

            Rectangle{
                id: background

                anchors.fill: parent

                opacity: index % 2 === 0 ? 0.1 : 0.05
            }

            Row{
                anchors.verticalCenter: parent.verticalCenter
                Item{
                    width: jsonList.width / 2
                    height: parent.height
                    Text{
                        text: key
                        anchors{
                            left: parent.left
                            leftMargin: 5
                            verticalCenter: parent.verticalCenter
                        }

                        font.pixelSize: 14

                        color: "#E1E1E1"
                    }
                }

                Loader{
                    id: loader
                    source: type === 'integer' || type === 'string' || type === 'float'?
                                "UIComponents/MyTextField.qml" :
                        type === 'boolean' ? "UIComponents/MyCheckBox.qml" : ""
                }
            }
        }

        ScrollIndicator.vertical: ScrollIndicator{

        }
    }


    MyButton{
        id: openBtn
        anchors{
            left: parent.left
            bottom: parent.bottom
            leftMargin: 10
            bottomMargin: 10
        }
        width: 150

        text: "open"
        onClicked: {
            if(jsonListModel.jsonObject){
                jsonListModel.jsonObject = {}
                jsonListModel.clear()
                fileName.text = "Выбранный файл: "
            }
            jsonListModel.jsonToModel(fileIO.read())
            fileName.text += fileIO.fileName;
        }
    }
    MyButton{
        anchors{
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        width: 150

        text: "save"

        onClicked: {
            var currentValue;

            if(jsonListModel.jsonObject){
                var jsonString = jsonListModel.modelToJson()
                if(jsonString) {
                    fileIO.write(jsonListModel.modelToJson())
                    console.debug("Save completed")
                }
            }
            else console.debug("Json file doesn't opened")
        }
    }
}
