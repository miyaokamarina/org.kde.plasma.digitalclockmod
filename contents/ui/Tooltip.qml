import QtQuick 2.6
import QtQuick.Controls 2.15

Label {
    width: implicitWidth
    height: implicitHeight

    text: Qt.formatDate(timestamp, 'dddd, d MMMM yyyy')
    opacity: 0.6
}
