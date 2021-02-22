import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import "../convert.js" as Convert

CheckBox {
    id: control

    Component.onCompleted: checked = Convert.stringToBoolean(jsonListModel.get(index).value)

    onClicked: {
        jsonListModel.get(index).value = String(checked)
    }
    height: indicator.height
    width: indicator.implicitWidth + contentItem.implicitWidth

    indicator: Rectangle{
        id: outer
        implicitWidth: 24
        implicitHeight: 24
        y: parent.height / 2 - height / 2
        color: checked ? "#444444" : "#333333"

        Image{
            id: inner

            source: "./../Resources/checkmark.svg"
            visible: control.checked
            anchors.horizontalCenter: outer.horizontalCenter
            anchors.verticalCenter: outer.verticalCenter
        }
        ColorOverlay{
            source: inner
            anchors.fill: inner
            visible: inner.visible
            color: "#E1E1E1"
        }
    }

    contentItem: Text {
        id:textItemOuter
        text: control.text
        verticalAlignment: Text.AlignVCenter
    }
}
