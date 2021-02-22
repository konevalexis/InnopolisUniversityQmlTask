import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

TextField {
    id: control

    Component.onCompleted: text = value
    onTextChanged: {
        if(jsonListModel.get(index).value !== undefined)
            jsonListModel.get(index).value = text
    }

    width: 150
    height: 40
    rightPadding: 20 + closeButton.width
    background: Rectangle {
        color: parent.activeFocus ? "#444444" : "#333333"
    }
    placeholderTextColor: "#D1D1D1"
    font.pixelSize: 14
    color: "#E1E1E1"

    Image{
        id: closeButton
        source: "../Resources/close_icon.svg"
        width: (parent.text != "" && parent.activeFocus) ? 16 : 0
        height: width
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        sourceSize.width: width
        sourceSize.height: height
        visible: width != 0
    }
    ColorOverlay{
        id: colorOverlay
        anchors.fill: closeButton
        source: closeButton
        color: "#E1E1E1"
        visible: closeButton.visible
        MouseArea{
            anchors.fill: parent
            onClicked: {
                control.text = ""
            }
        }
    }
}
