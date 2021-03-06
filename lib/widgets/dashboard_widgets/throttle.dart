import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:flutter/material.dart';

class Throttle extends StatelessWidget {
  static final _throttleColor = Colors.green[900];
  static const double width = 220;
  static const double height = 30;

  final CarTelemetryData _carTelemetry;
  final double dWidth;
  final double dHeight;

  Throttle(this._carTelemetry, {this.dWidth = width, this.dHeight = height});

  @override
  Widget build(BuildContext context) {
    double throttle = 0.57;

    if (_carTelemetry != null) {
      throttle = _carTelemetry.throttle;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: _throttleColor,
        ),
      ),
      width: dWidth,
      height: dHeight,
      child: LinearProgressIndicator(
        value: throttle,
        backgroundColor: Colors.transparent,
        valueColor: new AlwaysStoppedAnimation<Color>(_throttleColor),
      ),
    );
  }
}
