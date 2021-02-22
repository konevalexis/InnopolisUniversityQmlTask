import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2

Button{
    id: control

    height: 40
    width: implicitWidth

    focusPolicy: Qt.StrongFocus

    contentItem: Text{
        id: contentItem
        text: control.text
        color: "#E1E1E1"

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle{
        id: background

        color: ma.containsMouse ? "#444444" : "#333333"

        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            onClicked: control.clicked()
        }
    }
}
