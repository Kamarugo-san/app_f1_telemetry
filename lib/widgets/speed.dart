import 'package:app_f1_telemetry/View/constants.dart';
import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:flutter/material.dart';

class Speed extends StatelessWidget {
  static const double width = 120;
  static const double height = 50;

  final SpeedType speedType;
  final int _speed;

  Speed(this._speed, this.speedType);

  Widget build(BuildContext context) {
    String strSpeed;

    if (speedType == SpeedType.mph) {
      int temp = (_speed / 1.609).round();
      strSpeed = '$_speed MPH';
    } else {
      strSpeed = '$_speed KPH';
    }

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
