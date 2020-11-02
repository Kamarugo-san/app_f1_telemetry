import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:flutter/material.dart';

class ErsStorage extends StatelessWidget {
  static const double maxErsStorage = 4000000.0;
  static const double maxErsDeploy = 4000000.0;
  static const double maxErsHarvest = 3300000.0;
  static const double width = 300;
  static const double height = 26;
  static final _ersColor = Colors.yellow[700];

  final CarStatusData carStatus;
  final double dWidth;
  final double dHeight;

  ErsStorage(this.carStatus, {this.dWidth = width, this.dHeight = height});

  @override
  Widget build(BuildContext context) {
    double storagePercentage = 1;
    String deploy = '1';

    if (carStatus != null) {
      storagePercentage = ((carStatus.ersStoreEnergy) / maxErsStorage);

      switch (carStatus.ersDeployMode) {
        case 2:
          {
            deploy = '3';
          }
          break;
        case 3:
          {
            deploy = '2';
          }
          break;
        default:
          {
            deploy = carStatus.ersDeployMode.toString();
          }
      }
    }

    return Container(
      color: Colors.transparent,
      width: dWidth,
      height: dHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: FittedBox(
              child: Text(
                deploy,
                style: TextStyle(
                  color: _ersColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _ersColor,
                ),
              ),
              child: LinearProgressIndicator(
                value: storagePercentage.toDouble(),
                backgroundColor: Colors.transparent,
                valueColor: new AlwaysStoppedAnimation<Color>(_ersColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              child: Text(
                '${(storagePercentage * 100).floor()}%',
                style: TextStyle(
                  color: _ersColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
