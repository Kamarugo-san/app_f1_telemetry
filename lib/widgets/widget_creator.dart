import 'package:app_f1_telemetry/View/draggable.dart';
import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_status_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/packet_lap_data.dart';
import 'package:app_f1_telemetry/widgets/lights.dart';
import 'package:app_f1_telemetry/widgets/speed.dart';
import 'package:app_f1_telemetry/widgets/widget_types.dart';
import 'package:flutter/material.dart';

import 'cm_dashboard_left.dart';
import 'gear.dart';

class WidgetCreator {
  CarTelemetryData _telemetryData;
  CarStatusData _carStatusData;
  LapData _lapData;
  final SpeedType _speedType;

  WidgetCreator(
    PacketCarTelemetryData packetCarTelemetryData,
    PacketCarStatusData packetCarStatusData,
    PacketLapData packetLapData,
    this._speedType,
  ) {
    if (packetLapData != null) {
      _lapData = packetLapData.lapData[packetLapData.header.playerCarIndex];
    } else {
      _lapData = null;
    }

    if (packetCarTelemetryData != null) {
      _telemetryData = packetCarTelemetryData
          .carTelemetryData[packetCarTelemetryData.header.playerCarIndex];
    } else {
      _telemetryData = null;
    }

    if (packetCarStatusData != null) {
      _carStatusData = packetCarStatusData
          .carStatusData[packetCarStatusData.header.playerCarIndex];
    } else {
      _carStatusData = null;
    }
  }

  Widget create(TelemetryWidget telemetryWidget, bool isEditing) {
    switch (telemetryWidget.widgetType) {
      case WidgetTypes.cmDashboardLeft:
        {
          if (isEditing) {
            return DraggableWidget(
              widget: PositionedWidget(
                id: telemetryWidget.id,
                start: telemetryWidget.start,
                top: telemetryWidget.top,
                widget: CmDashboardLeft(
                  speedType: _speedType,
                  lapData: null,
                  telemetryData: null,
                  carStatusData: null,
                ),
              ),
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              child: CmDashboardLeft(
                speedType: SpeedType.kph,
                lapData: _lapData,
                telemetryData: _telemetryData,
                carStatusData: _carStatusData,
              ),
            );
          }
        }
        break;
      case WidgetTypes.gear:
        {
          if (isEditing) {
            return DraggableWidget(
              widget: PositionedWidget(
                id: telemetryWidget.id,
                start: telemetryWidget.start,
                top: telemetryWidget.top,
                widget: Gear(
                  null,
                  null,
                ),
              ),
              width: Gear.width,
              height: Gear.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              child: Gear(
                _telemetryData,
                _carStatusData,
              ),
            );
          }
        }
        break;

      case WidgetTypes.lights:
        {
          if (isEditing) {
            return DraggableWidget(
              widget: PositionedWidget(
                id: telemetryWidget.id,
                start: telemetryWidget.start,
                top: telemetryWidget.top,
                widget: RevLights(null),
              ),
              width: RevLights.width,
              height: RevLights.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              child: RevLights(_telemetryData),
            );
          }
        }
        break;

      case WidgetTypes.speed:
        {
          if (isEditing) {
            return DraggableWidget(
              widget: PositionedWidget(
                id: telemetryWidget.id,
                start: telemetryWidget.start,
                top: telemetryWidget.top,
                widget: Speed(
                  SpeedType.kph,
                  null,
                ),
              ),
              width: RevLights.width,
              height: RevLights.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              child: Speed(
                SpeedType.kph,
                _telemetryData,
              ),
            );
          }
        }
        break;
    }

    return null;
  }
}
