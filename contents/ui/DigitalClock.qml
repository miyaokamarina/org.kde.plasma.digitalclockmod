/*
 * Copyright 2013 Heena Mahour <heena393@gmail.com>
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
 * Copyright 2013 Martin Klapetek <mklapetek@kde.org>
 * Copyright 2014 David Edmundson <davidedmundson@kde.org>
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

import QtQuick 2.6
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as Components // Date label height breaks on vertical panel with PC3 version
import org.kde.plasma.private.digitalclock 1.0

Item {
    id: main

    property date currentTime

    Layout.fillHeight: true
    Layout.minimumWidth: clockDisplay.width
    Layout.maximumWidth: Layout.minimumWidth

    MouseArea {
        anchors.fill: parent

        onClicked: plasmoid.expanded = !plasmoid.expanded
    }

    Item {
        id: clockDisplay

        height: 20
        width: splitterBar.width + Math.max(timeLabel.width, dateLabel.width) * 2
        anchors.verticalCenter: main.verticalCenter

        Components.Label  {
            id: timeLabel

            font.family: clockFontFamily
            font.pixelSize: clockFontSize
            height: clockLineHeight
            anchors.right: splitterBar.left

            text: Qt.formatTime(timestamp, clockTimeFormat)
        }

        Item  {
            id: splitterBar

            width: splitterMarginHorizontal * 2 + 1
            height: clockLineHeight
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                color: theme.textColor
                
                anchors.fill: parent
                anchors.leftMargin: splitterMarginHorizontal
                anchors.rightMargin: splitterMarginHorizontal
                anchors.topMargin: splitterMarginTop
                anchors.bottomMargin: splitterMarginBottom
            }
        }

        Components.Label {
            id: dateLabel

            font.family: clockFontFamily
            font.pixelSize: clockFontSize
            height: clockLineHeight
            anchors.left: splitterBar.right

            text: Qt.formatDate(timestamp, clockDateFormat)
        }
    }
}
