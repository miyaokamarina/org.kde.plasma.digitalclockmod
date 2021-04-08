/*
 * Copyright 2013  Heena Mahour <heena393@gmail.com>
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
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
import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kquickcontrolsaddons 2.0

Item {
    // region Configuration
    readonly property string clockFontFamily: 'Noto Sans Light'
    readonly property int    clockFontSize:   13
    readonly property int    clockLineHeight: 20

    readonly property string clockTimeFormat: 'hh:mm'
    readonly property string clockDateFormat: 'dd.MM'

    readonly property int    splitterMarginHorizontal: 6
    readonly property int    splitterMarginTop:        3
    readonly property int    splitterMarginBottom:     3

    readonly property int    calendarFirstDayOfWeek:   0

    readonly property string tooltipDateFormat1:       'dddd'
    readonly property string tooltipDateFormat2:       'd MMMM yyyy'
    // endregion Configuration

    id: root

    width: units.gridUnit * 10
    height: units.gridUnit * 4
    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground | PlasmaCore.Types.ConfigurableBackground

    property date timestamp

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: DigitalClock { }
    Plasmoid.fullRepresentation: CalendarView { }

    Plasmoid.toolTipItem: Loader {
        source: "Tooltip.qml"

        Layout.minimumWidth: item ? item.width : 0
        Layout.maximumWidth: item ? item.width : 0
        Layout.minimumHeight: item ? item.height : 0
        Layout.maximumHeight: item ? item.height : 0
    }

    Timer {
        interval: 1000
        triggeredOnStart: true
        running: true
        repeat: true

        onTriggered: {
            timestamp = new Date();
        }
    }

    function action_clockkcm() {
        KCMShell.openSystemSettings("clock");
    }

    function action_formatskcm() {
        KCMShell.openSystemSettings("formats");
    }

    Component.onCompleted: {
        plasmoid.setAction("clockkcm", i18n("Adjust Date and Time..."), "preferences-system-time");
        plasmoid.setAction("formatskcm", i18n("Set Time Format..."));
    }
}
