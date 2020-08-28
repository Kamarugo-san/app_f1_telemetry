import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/data_to_string/temperature_type.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';

class DataToStringConverter {
  TemperatureType temperatureType;
  SpeedType speedType;

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
    List<String> tempList = [];

    for (var t in car.tyresInnerTemperature) {
      if (temperatureType == TemperatureType.fahrenheit) {
        int f = ((t * (9/5)) + 32).toInt();
        tempList.add('$f ºF');
      } else {
        tempList.add('$t ºC');
      }
    }

    return tempList;
  }

  /// Returns the current lap time formatted as mm:ss.SSS with leading zeros
  String getCurrentLapTime(LapData lap) {
    int minutes = (lap.currentLapTime.floor() / 60).floor();
    int seconds = lap.currentLapTime.floor() - (minutes * 60);
    int millis =
        ((lap.currentLapTime - lap.currentLapTime.floor()) * 1000).toInt();

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${millis.toString().padLeft(3, '0')}';
  }
}
