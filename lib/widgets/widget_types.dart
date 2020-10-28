import 'package:app_f1_telemetry/view/constants.dart';
import 'package:app_f1_telemetry/widgets/brake.dart';
import 'package:app_f1_telemetry/widgets/cm_dashboard_left.dart';
import 'package:app_f1_telemetry/widgets/ers_storage.dart';
import 'package:app_f1_telemetry/widgets/gear.dart';
import 'package:app_f1_telemetry/widgets/rev_lights.dart';
import 'package:app_f1_telemetry/widgets/speed.dart';
import 'package:app_f1_telemetry/widgets/status_table.dart';
import 'package:app_f1_telemetry/widgets/throttle.dart';

class WidgetTypes {
  static const int cmDashboardLeft = 0;
  static const int cmDashboardRight = 1;
  static const int gear = 2;
  static const int lights = 3;
  static const int speed = 4;
  static const int statusTable = 5;
  static const int ersStorage = 6;
  static const int throttle = 7;
  static const int brake = 8;

  static getWidthByType(int type) {
    switch (type) {
      case 0:
        return CmDashboardLeft.width;
        break;
      case 1:
        return Constants.defaultSize;
        break;
      case 2:
        return Gear.width;
        break;
      case 3:
        return RevLights.width;
        break;
      case 4:
        return Speed.width;
        break;
      case 5:
        return StatusTable.width;
        break;
      case 6:
        return ErsStorage.width;
        break;
      case 7:
        return Throttle.width;
        break;
      case 8:
        return Brake.width;
        break;
    }
  }

  static getHeightByType(int type) {
    switch (type) {
      case 0:
        return CmDashboardLeft.height;
        break;
      case 1:
        return Constants.defaultSize;
        break;
      case 2:
        return Gear.height;
        break;
      case 3:
        return RevLights.height;
        break;
      case 4:
        return Speed.height;
        break;
      case 5:
        return StatusTable.height;
        break;
      case 6:
        return ErsStorage.height;
        break;
      case 7:
        return Throttle.height;
        break;
      case 8:
        return Brake.height;
        break;
    }
  }
}
