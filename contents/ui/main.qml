import QtQuick 2.6
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    property date timestamp

    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground | PlasmaCore.Types.ConfigurableBackground

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: DigitalClock { }
    Plasmoid.fullRepresentation: CalendarView { }

    Plasmoid.toolTipItem: Loader {
        source: "Tooltip.qml"
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
}
