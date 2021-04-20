import QtQuick 2.6
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {
    id: main

    MouseArea {
        anchors.fill: parent
        onClicked: plasmoid.expanded = !plasmoid.expanded
    }

    Label  {
        text: Qt.formatTime(timestamp, 'hh:mm')
    }

    Label {
        text: Qt.formatDate(timestamp, 'dd.MM')
    }
}
