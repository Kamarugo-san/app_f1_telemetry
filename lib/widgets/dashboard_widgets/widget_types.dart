import 'package:app_f1_telemetry/common/constants.dart';
import 'package:app_f1_telemetry/widgets/dashboard_widgets/brake.dart';
import 'package:app_f1_telemetry/widgets/dashboard_widgets/cm_dashboard_left.dart';
import 'package:app_f1_telemetry/widgets/dashboard_widgets/ers_storage.dart';
import 'package:app_f1_telemetry/widgets/dashboard_widgets/gear.dart';
import 'package:app_f1_telemetry/widgets/dashboard_widgets/rev_lights.dart';
import 'package:app_f1_telemetry/widgets/dashboard_widgets/speed.dart';
import 'package:app_f1_telemetry/widgets/dashboard_widgets/status_table.dart';
import 'package:app_f1_telemetry/widgets/dashboard_widgets/throttle.dart';

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
      case cmDashboardLeft:
        return CmDashboardLeft.width;
        break;
      case cmDashboardRight:
        return Constants.defaultSize;
        break;
      case gear:
        return Gear.width;
        break;
      case lights:
        return RevLights.width;
        break;
      case speed:
        return Speed.width;
        break;
      case statusTable:
        return StatusTable.width;
        break;
      case ersStorage:
        return ErsStorage.width;
        break;
      case throttle:
        return Throttle.width;
        break;
      case brake:
        return Brake.width;
        break;
    }
  }

  static getHeightByType(int type) {
    switch (type) {
      case cmDashboardLeft:
        return CmDashboardLeft.height;
        break;
      case cmDashboardRight:
        return Constants.defaultSize;
        break;
      case gear:
        return Gear.height;
        break;
      case lights:
        return RevLights.height;
        break;
      case speed:
        return Speed.height;
        break;
      case statusTable:
        return StatusTable.height;
        break;
      case ersStorage:
        return ErsStorage.height;
        break;
      case throttle:
        return Throttle.height;
        break;
      case brake:
        return Brake.height;
        break;
    }
  }
}
