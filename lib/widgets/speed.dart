import 'package:app_f1_telemetry/View/constants.dart';
import 'package:app_f1_telemetry/data_to_string/data_to_string_converter.dart';
import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:flutter/material.dart';

class Speed extends StatelessWidget {
  static const double width = 120;
  static const double height = 50;

  final SpeedType _speedType;
  final CarTelemetryData _telemetryData;

  Speed(this._speedType, this._telemetryData);

  Widget build(BuildContext context) {
    String strSpeed = DataToStringConverter.getSpeed(_telemetryData, _speedType);

    return Container(
      color: Colors.transparent,
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FittedBox(
                child: Text(
                  strSpeed,
                  style: TextStyle(
                    color: Constants.primaryTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
