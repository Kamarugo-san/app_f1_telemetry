import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/view/constants.dart';
import 'package:flutter/material.dart';

class Brake extends StatelessWidget {
  static final _brakeColor = Colors.red[900];
  static const double width = 220;
  static const double height = 30;

  final CarTelemetryData _carTelemetry;
  final double dWidth;
  final double dHeight;

  Brake(this._carTelemetry, {this.dWidth = width, this.dHeight = height});

  @override
  Widget build(BuildContext context) {
    double brake = 0.43;

    if (_carTelemetry != null) {
      brake = 1 - _carTelemetry.brake;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: _brakeColor,
        ),
      ),
      width: dWidth,
      height: dHeight,
      child: LinearProgressIndicator(
        value: brake,
        backgroundColor: _brakeColor,
        valueColor:
            new AlwaysStoppedAnimation<Color>(Constants.backgroundColor),
      ),
    );
  }
}
