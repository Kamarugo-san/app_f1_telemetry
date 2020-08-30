import 'dart:math';

import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/data_to_string/temperature_type.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';

class DataToStringConverter {
  TemperatureType temperatureType;
  SpeedType speedType;

  final List<String> defaultTempsListC = ['0ºC', '0ºC', '0ºC', '0ºC'];
  final List<String> defaultTempsListF = ['0ºF', '0ºF', '0ºF', '0ºF'];
  final double maxErsStorage = 4000000.0;
  final double maxErsDeploy = 4000000.0;
  final double maxErsHarvest = 3300000.0;

  DataToStringConverter(TemperatureType temperatureType, SpeedType speedType) {
    this.temperatureType = temperatureType;
    this.speedType = speedType;
  }

  String getRpm(CarTelemetryData car) {
    return car.engineRPM.toString();
  }

  String getGear(CarTelemetryData car) {
    return car.gear == 255 ? 'R' : car.gear == 0 ? 'N' : car.gear.toString();
  }

  String getSpeed(CarTelemetryData car) {
    int speed = car.speed;

    if (speedType == SpeedType.mph) {
      speed = (speed / 1.609).round();
      return '$speed MPH';
    } else {
      return '$speed KPH';
    }
  }

  List<String> getTyreInnerTemperature(CarTelemetryData car) {
    List<String> tempList = List(4);

    for (int i = 0; i < 4; i++) {
      var t = car.tyresInnerTemperature[i];

      if (temperatureType == TemperatureType.fahrenheit) {
        int f = ((t * (9 / 5)) + 32).toInt();
        tempList[i] = '$fºF';
      } else {
        tempList[i] = '$tºC';
      }
    }

    return tempList;
  }

  List<String> getDefaultTempsList() {
    if (temperatureType == TemperatureType.fahrenheit) {
      return defaultTempsListF;
    } else {
      return defaultTempsListC;
    }
  }

  /// Returns the current lap time formatted as mm:ss.SSS with leading zeros
  String getCurrentLapTime(LapData lap) {
    int minutes = (lap.currentLapTime.floor() / 60).floor();
    int seconds = lap.currentLapTime.floor() - (minutes * 60);
    int millis =
        ((lap.currentLapTime - lap.currentLapTime.floor()) * 1000).toInt();

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${millis.toString().padLeft(3, '0')}';
  }

  String getFuelRemainingLaps(CarStatusData car) {
    var fuelRemainingLaps = dp(car.fuelRemainingLaps, 2);

    if (fuelRemainingLaps >= 0) {
      return '+(${fuelRemainingLaps.toString()})';
    } else {
      return '-(${fuelRemainingLaps.toString()})';
    }
  }

  int getErsStoragePercentage(CarStatusData car) {
    return ((car.ersStoreEnergy * 100) / maxErsStorage).floor();
  }

  int getErsDeployPercentage(CarStatusData car) {
    return ((car.ersDeployedThisLap * 100) / maxErsDeploy).floor();
  }

  double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
}
