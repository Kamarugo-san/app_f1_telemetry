import 'package:app_f1_telemetry/view/constants.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gear extends StatelessWidget {
  static const String _neutral = 'N';
  static const String _reverse = 'R';
  static const String _pitLimiter = 'P';
  static const double width = 120;
  static const double height = 120;

  final CarTelemetryData _telemetryData;
  final CarStatusData _statusData;

  Gear(this._telemetryData, this._statusData);

  String _getGear() {
    if (_statusData != null) {
      if (_statusData.pitLimiterStatus == 1) {
        return _pitLimiter;
      }
    }

    if (_telemetryData != null) {
      switch (_telemetryData.gear) {
        case 0:
          {
            return _neutral;
          }
          break;
        case 255:
          {
            return _reverse;
          }
          break;
        default:
          {
            return _telemetryData.gear.toString();
          }
      }
    }

    return _neutral;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FittedBox(
              child: Text(
                _getGear(),
                style: TextStyle(
                  color: Constants.primaryTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
