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
                  dWidth: telemetryWidget.width,
                  dHeight: telemetryWidget.height,
                ),
              ),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
              child: CmDashboardLeft(
                speedType: SpeedType.kph,
                lapData: _lapData,
                telemetryData: _telemetryData,
                carStatusData: _carStatusData,
                dWidth: telemetryWidget.width,
                dHeight: telemetryWidget.height,
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
                  dWidth: telemetryWidget.width,
                  dHeight: telemetryWidget.height,
                ),
              ),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
              child: Gear(
                _telemetryData,
                _carStatusData,
                dWidth: telemetryWidget.width,
                dHeight: telemetryWidget.height,
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
                widget: RevLights(
                  null,
                  dWidth: telemetryWidget.width,
                  dHeight: telemetryWidget.height,
                ),
              ),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
              child: RevLights(
                _telemetryData,
                dWidth: telemetryWidget.width,
                dHeight: telemetryWidget.height,
              ),
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
                  dWidth: telemetryWidget.width,
                  dHeight: telemetryWidget.height,
                ),
              ),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
              child: Speed(
                SpeedType.kph,
                _telemetryData,
                dWidth: telemetryWidget.width,
                dHeight: telemetryWidget.height,
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
                widget: StatusTable(
                  null,
                  null,
                  null,
                  dWidth: telemetryWidget.width,
                  dHeight: telemetryWidget.height,
                ),
              ),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
              child: StatusTable(
                _listLapData,
                _listParticipantData,
                _listCarStatus,
                dWidth: telemetryWidget.width,
                dHeight: telemetryWidget.height,
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
                  dWidth: telemetryWidget.width,
                  dHeight: telemetryWidget.height,
                ),
              ),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
              child: ErsStorage(
                _carStatusData,
                dWidth: telemetryWidget.width,
                dHeight: telemetryWidget.height,
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
                  dWidth: telemetryWidget.width,
                  dHeight: telemetryWidget.height,
                ),
              ),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
              child: Throttle(
                _telemetryData,
                dWidth: telemetryWidget.width,
                dHeight: telemetryWidget.height,
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
                  dWidth: telemetryWidget.width,
                  dHeight: telemetryWidget.height,
                ),
              ),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
            );
          } else {
            return Positioned(
              top: telemetryWidget.top.toDouble(),
              left: telemetryWidget.start.toDouble(),
              width: telemetryWidget.width,
              height: telemetryWidget.height,
              child: Brake(
                _telemetryData,
                dWidth: telemetryWidget.width,
                dHeight: telemetryWidget.height,
              ),
            );
          }
        }
        break;
    }

    return null;
  }
}
