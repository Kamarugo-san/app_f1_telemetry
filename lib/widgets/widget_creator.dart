import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_status_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/packet_lap_data.dart';
import 'package:app_f1_telemetry/packet/packet_participant_data.dart';
import 'package:app_f1_telemetry/view/draggable.dart';
import 'package:app_f1_telemetry/widgets/brake.dart';
import 'package:app_f1_telemetry/widgets/ers_storage.dart';
import 'package:app_f1_telemetry/widgets/rev_lights.dart';
import 'package:app_f1_telemetry/widgets/speed.dart';
import 'package:app_f1_telemetry/widgets/throttle.dart';
import 'package:app_f1_telemetry/widgets/widget_types.dart';
import 'package:flutter/material.dart';

import 'cm_dashboard_left.dart';
import 'gear.dart';
import 'status_table.dart';

class WidgetCreator {
  CarTelemetryData _telemetryData;
  CarStatusData _carStatusData;
  LapData _lapData;
  List<LapData> _listLapData;
  PacketParticipantData _listParticipantData;
  List<CarStatusData> _listCarStatus;
  final SpeedType _speedType;

  WidgetCreator(
    PacketCarTelemetryData packetCarTelemetryData,
    PacketCarStatusData packetCarStatusData,
    PacketLapData packetLapData,
    PacketParticipantData packetParticipantData,
    this._speedType,
  ) {
    if (packetLapData != null) {
      _lapData = packetLapData.lapData[packetLapData.header.playerCarIndex];
      _listLapData = packetLapData.lapData;
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
      _listCarStatus = packetCarStatusData.carStatusData;
    } else {
      _carStatusData = null;
    }

    if (packetParticipantData != null) {
      _listParticipantData = packetParticipantData;
    } else {
      _listParticipantData = null;
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
              width: Speed.width,
              height: Speed.height,
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

      case WidgetTypes.statusTable:
        {
          if (isEditing) {
            return DraggableWidget(
              widget: PositionedWidget(
                id: telemetryWidget.id,
                start: telemetryWidget.start,
                top: telemetryWidget.top,
                widget: StatusTable(null, null, null),
              ),
              width: StatusTable.width,
              height: StatusTable.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              child: StatusTable(
                _listLapData,
                _listParticipantData,
                _listCarStatus,
              ),
            );
          }
        }
        break;

      case WidgetTypes.ersStorage:
        {
          if (isEditing) {
            return DraggableWidget(
              widget: PositionedWidget(
                id: telemetryWidget.id,
                start: telemetryWidget.start,
                top: telemetryWidget.top,
                widget: ErsStorage(
                  null,
                ),
              ),
              width: ErsStorage.width,
              height: ErsStorage.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              child: ErsStorage(
                _carStatusData,
              ),
            );
          }
        }
        break;

      case WidgetTypes.throttle:
        {
          if (isEditing) {
            return DraggableWidget(
              widget: PositionedWidget(
                id: telemetryWidget.id,
                start: telemetryWidget.start,
                top: telemetryWidget.top,
                widget: Throttle(
                  null,
                ),
              ),
              width: Throttle.width,
              height: Throttle.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              child: Throttle(
                _telemetryData,
              ),
            );
          }
        }
        break;

      case WidgetTypes.brake:
        {
          if (isEditing) {
            return DraggableWidget(
              widget: PositionedWidget(
                id: telemetryWidget.id,
                start: telemetryWidget.start,
                top: telemetryWidget.top,
                widget: Brake(
                  null,
                ),
              ),
              width: Brake.width,
              height: Brake.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              child: Brake(
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
