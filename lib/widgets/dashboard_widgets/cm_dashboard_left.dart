import 'package:app_f1_telemetry/common/constants.dart';
import 'package:app_f1_telemetry/data_to_string/data_to_string_converter.dart';
import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';
import 'package:flutter/material.dart';

import 'data_box.dart';

class CmDashboardLeft extends StatelessWidget {
  final SpeedType speedType;
  final LapData lapData;
  final CarTelemetryData telemetryData;
  final CarStatusData carStatusData;
  final double dWidth;
  final double dHeight;

  static const double width = 170;
  static const double height = 120;

  CmDashboardLeft({
    this.speedType,
    this.lapData,
    this.telemetryData,
    this.carStatusData,
    this.dWidth,
    this.dHeight,
  });

  @override
  Widget build(BuildContext context) {
    String speed = DataToStringConverter.getSpeed(telemetryData, speedType);
    String currentLap = 'L1';
    String currentPos = 'P0';
    String totalFuel = '0.0';
    String remainingFuel = '+(0.00)';

    if (lapData != null) {
      currentLap = 'L${lapData.currentLapNum}';
      currentPos = 'P${lapData.carPosition}';
    }

    if (telemetryData != null) {
      int temp = telemetryData.speed;

      if (speedType == SpeedType.mph) {
        temp = (temp / 1.609).round();
        speed = '$temp MPH';
      } else {
        speed = '$temp KPH';
      }
    }

    if (carStatusData != null) {
      var fuelRemainingLaps =
          DataToStringConverter.dp(carStatusData.fuelRemainingLaps, 2);

      if (fuelRemainingLaps >= 0) {
        remainingFuel = '(+${fuelRemainingLaps.toString()})';
      } else {
        remainingFuel = '(${fuelRemainingLaps.toString()})';
      }

      totalFuel =
          DataToStringConverter.dp(carStatusData.fuelInTank, 2).toString();
    }

    return DataBox(
      header: Text(speed),
      t0_0: Text(
        currentLap,
        style: TextStyle(color: Constants.primaryTextColor),
      ),
      t0_1: Text(
        currentPos,
        style: TextStyle(color: Constants.primaryTextColor),
      ),
      t1_0: Text(
        totalFuel,
        style: TextStyle(color: Constants.primaryTextColor),
      ),
      t1_1: Text(
        remainingFuel,
        style: TextStyle(color: Constants.primaryTextColor),
      ),
      dWidth: dWidth,
      dHeight: dHeight,
    );
  }
}
