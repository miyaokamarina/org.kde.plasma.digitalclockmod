import QtQuick 2.6
import QtQuick.Layouts 1.15

import org.kde.plasma.calendar 2.0
import org.kde.plasma.components 3.0 as PC3
import org.kde.plasma.extras 2.0 as PEX

PC3.Page {
    id: calendar

    readonly property int paddings: units.smallSpacing

    width: units.gridUnit * 16 + (calendar.paddings * 2)
    height: units.gridUnit * 12 + (calendar.paddings * 2) + header.height

    // Header containing date and pin button
    header: PEX.PlasmoidHeading {
        id: header

        RowLayout {
            width: parent.width

            PEX.Heading {
                Layout.fillWidth: true
                Layout.leftMargin: calendar.paddings
                level: 2
                text: Qt.formatDate(month.currentDate, 'dddd, d MMMM yyyy')
            }

            PC3.ToolButton {
                Layout.rightMargin: calendar.paddings
                checkable: true
                onToggled: plasmoid.hideOnWindowDeactivate = !checked
                icon.name: "window-pin"
            }
        }
    }

    MonthView {
        anchors {
            top: parent.top
            left: parent.left
            margins: calendar.paddings
        }

        id: month
        borderWidth: 0
        borderOpacity: 0
        today: timestamp
        firstDayOfWeek: 0
    }
}
