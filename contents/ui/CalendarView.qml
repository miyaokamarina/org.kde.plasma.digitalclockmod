/*
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
 * Copyright 2015 Martin Klapetek <mklapetek@kde.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQml 2.15

import org.kde.kquickcontrolsaddons 2.0 // For kcmshell
import org.kde.plasma.calendar 2.0 as PlasmaCalendar
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras

PlasmaComponents3.Page {
    id: calendar

    property int _minimumWidth: rootLayout.childrenRect.width + (calendar.paddings * 2)
    property int _minimumHeight: rootLayout.childrenRect.height + (calendar.paddings * 2) + headerArea.height

    Layout.minimumWidth: _minimumWidth
    Layout.minimumHeight: _minimumHeight
    Layout.preferredWidth: _minimumWidth
    Layout.preferredHeight: _minimumHeight
    Layout.maximumWidth: _minimumWidth
    Layout.maximumHeight: _minimumHeight

    readonly property int paddings: units.smallSpacing

    property bool pin: false

    // Header containing date and pin button
    header: PlasmaExtras.PlasmoidHeading {
        id: headerArea

        RowLayout {
            width: parent.width

            PlasmaExtras.Heading {
                Layout.fillWidth: true
                Layout.leftMargin: calendar.paddings // Match calendar title

                level: 1

                text: monthView.currentDate.toLocaleDateString(Qt.locale(), Locale.LongFormat)
            }

            PlasmaComponents3.ToolButton {
                checkable: true
                checked: pin
                onToggled: pin = checked
                icon.name: "window-pin"
                PlasmaComponents3.ToolTip {
                    text: i18n("Keep Open")
                }
            }
        }
    }

    RowLayout {
        id: rootLayout

        anchors {
            top: parent.top
            left: parent.left
            margins: calendar.paddings
        }

        spacing: calendar.paddings

        // TODO KF6: remove the `Item` wrapper, which this is only needed since
        // PlasmaCalendar.MonthView internally has `anchors.fill:parent` set on
        // it, erroneously expecting to never be in a Layout
        Item {
            Layout.fillWidth: true
            Layout.minimumHeight: units.gridUnit * 22
            Layout.minimumWidth: units.gridUnit * 22

            PlasmaCalendar.MonthView {
                id: monthView
                borderOpacity: 0.25
                today: timestamp
                firstDayOfWeek: calendarFirstDayOfWeek
            }
        }
    }

    Binding {
        target: plasmoid
        property: "hideOnWindowDeactivate"
        value: !pin
        restoreMode: Binding.RestoreBinding
    }
}
