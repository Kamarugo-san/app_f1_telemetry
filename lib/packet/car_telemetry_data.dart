import 'dart:typed_data';

class CarTelemetryData {
  /// Speed of car in kilometres per hour
  int speed;

  /// Amount of throttle applied (0.0 to 1.0)
  double throttle;

  /// Steering (-1.0 (full lock left) to 1.0 (full lock right))
  double steer;

  /// Amount of brake applied (0.0 to 1.0)
  double brake;

  /// Amount of clutch applied (0 to 100)
  int clutch;

  /// Gear selected (1-8, N=0, R=-1)
  int gear;

  /// Engine RPM
  int engineRPM;

  /// 0 = off, 1 = on
  int drs;

  /// Rev lights indicator (percentage)
  int revLightsPercent;

  /// Brakes temperature (celsius)
  List<int> brakesTemperature = List(4); // [4]
  /// Tyres surface temperature (celsius)
  List<int> tyresSurfaceTemperature = List(4); // [4]
  /// Tyres inner temperature (celsius)
  List<int> tyresInnerTemperature = List(4); // [4]
  /// Engine temperature (celsius)
  int engineTemperature;

  /// Tyres pressure (PSI)
  List<double> tyresPressure = List(4); // [4]
  /// Driving surface, see appendices
  List<int> surfaceType = List(4); // [4]

  CarTelemetryData(Uint8List list) {
    int refIndex = 0;
    int listIndex = 0;

    while (refIndex < telemetryData.length) {
      if (telemetryData[refIndex] == 1) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + telemetryData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getUint8(0));
      }
      if (telemetryData[refIndex] == 2) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + telemetryData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getUint16(0));
      }
      if (telemetryData[refIndex] == 4) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + telemetryData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getFloat32(0));
      }

      listIndex += telemetryData[refIndex];
      refIndex++;
    }
  }

  void setValue(int position, var val) {
    switch (position) {
      case 0:
        {
          speed = val;
        }
        break;
      case 1:
        {
          throttle = val;
        }
        break;
      case 2:
        {
          steer = val;
        }
        break;
      case 3:
        {
          brake = val;
        }
        break;
      case 4:
        {
          clutch = val;
        }
        break;
      case 5:
        {
          gear = val;
        }
        break;
      case 6:
        {
          engineRPM = val;
        }
        break;
      case 7:
        {
          drs = val;
        }
        break;
      case 8:
        {
          revLightsPercent = val;
        }
        break;
      case 9:
        {
          brakesTemperature[0] = val;
        }
        break;
      case 10:
        {
          brakesTemperature[1] = val;
        }
        break;
      case 11:
        {
          brakesTemperature[2] = val;
        }
        break;
      case 12:
        {
          brakesTemperature[3] = val;
        }
        break;
      case 13:
        {
          tyresSurfaceTemperature[0] = val;
        }
        break;
      case 14:
        {
          tyresSurfaceTemperature[1] = val;
        }
        break;
      case 15:
        {
          tyresSurfaceTemperature[2] = val;
        }
        break;
      case 16:
        {
          tyresSurfaceTemperature[3] = val;
        }
        break;
      case 17:
        {
          tyresInnerTemperature[0] = val;
        }
        break;
      case 18:
        {
          tyresInnerTemperature[1] = val;
        }
        break;
      case 19:
        {
          tyresInnerTemperature[2] = val;
        }
        break;
      case 20:
        {
          tyresInnerTemperature[3] = val;
        }
        break;
      case 21:
        {
          engineTemperature = val;
        }
        break;
      case 22:
        {
          tyresPressure[0] = val;
        }
        break;
      case 23:
        {
          tyresPressure[1] = val;
        }
        break;
      case 24:
        {
          tyresPressure[2] = val;
        }
        break;
      case 25:
        {
          tyresPressure[3] = val;
        }
        break;
      case 26:
        {
          surfaceType[0] = val;
        }
        break;
      case 27:
        {
          surfaceType[1] = val;
        }
        break;
      case 28:
        {
          surfaceType[2] = val;
        }
        break;
      case 29:
        {
          surfaceType[3] = val;
        }
        break;
    }
  }

  static final telemetryData = [
    2,
    4,
    4,
    4,
    1,
    1,
    2,
    1,
    1,
    2,
    2,
    2,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    4,
    4,
    4,
    4,
    1,
    1,
    1,
    1
  ];
}
