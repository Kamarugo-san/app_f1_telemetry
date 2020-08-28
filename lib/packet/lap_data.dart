import 'dart:typed_data';

class LapData {
  /// Last lap time in seconds
  double lastLapTime;

  /// Current time around the lap in seconds
  double currentLapTime;

  /// UPDATED in Beta 3:
  /// Sector 1 time in milliseconds
  int sector1TimeInMS;

  /// Sector 2 time in milliseconds
  int sector2TimeInMS;

  /// Best lap time of the session in seconds
  double bestLapTime;

  /// Lap number best time achieved on
  int bestLapNum;

  /// Sector 1 time of best lap in the session in milliseconds
  int bestLapSector1TimeInMS;

  /// Sector 2 time of best lap in the session in milliseconds
  int bestLapSector2TimeInMS;

  /// Sector 3 time of best lap in the session in milliseconds
  int bestLapSector3TimeInMS;

  /// Best overall sector 1 time of the session in milliseconds
  int bestOverallSector1TimeInMS;

  /// Lap number best overall sector 1 time achieved on
  int bestOverallSector1LapNum;

  /// Best overall sector 2 time of the session in milliseconds
  int bestOverallSector2TimeInMS;

  /// Lap number best overall sector 2 time achieved on
  int bestOverallSector2LapNum;

  /// Best overall sector 3 time of the session in milliseconds
  int bestOverallSector3TimeInMS;

  /// Lap number best overall sector 3 time achieved on
  int bestOverallSector3LapNum;

  /// Distance vehicle is around current lap in metres – could
  double lapDistance;

  /// Total distance travelled in session in metres – could
  /// be negative if line hasn't been crossed yet
  double totalDistance;

  /// Delta in seconds for safety car
  /// be negative if line hasn't been crossed yet
  double safetyCarDelta;

  /// Car race position
  int carPosition;

  /// Current lap number
  int currentLapNum;

  /// 0 = none, 1 = pitting, 2 = in pit area
  int pitStatus;

  /// 0 = sector1, 1 = sector2, 2 = sector3
  int sector;

  /// Current lap invalid - 0 = valid, 1 = invalid
  int currentLapInvalid;

  /// Accumulated time penalties in seconds to be added
  int penalties;

  /// Grid position the vehicle started the race in
  int gridPosition;

  /// Status of driver - 0 = in garage, 1 = flying lap
  /// 2 = in lap, 3 = out lap, 4 = on track
  int driverStatus;

  /// Result status - 0 = invalid, 1 = inactive, 2 = active
  /// 3 = finished, 4 = disqualified, 5 = not classified
  /// 6 = retired
  int resultStatus;

  LapData(Uint8List list) {
    int refIndex = 0;
    int listIndex = 0;

    while (refIndex < lapData.length) {
      if (lapData[refIndex] == 1) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + lapData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getUint8(0));
      }
      if (lapData[refIndex] == 2) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + lapData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getUint16(0));
      }
      if (lapData[refIndex] == 4) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + lapData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getFloat32(0));
      }
      listIndex += lapData[refIndex];
      refIndex++;
    }
  }

  @override
  String toString() {
    return 'LapData{lastLapTime: $lastLapTime, currentLapTime: $currentLapTime, sector1TimeInMS: $sector1TimeInMS, sector2TimeInMS: $sector2TimeInMS, bestLapTime: $bestLapTime, bestLapNum: $bestLapNum, bestLapSector1TimeInMS: $bestLapSector1TimeInMS, bestLapSector2TimeInMS: $bestLapSector2TimeInMS, bestLapSector3TimeInMS: $bestLapSector3TimeInMS, bestOverallSector1TimeInMS: $bestOverallSector1TimeInMS, bestOverallSector1LapNum: $bestOverallSector1LapNum, bestOverallSector2TimeInMS: $bestOverallSector2TimeInMS, bestOverallSector2LapNum: $bestOverallSector2LapNum, bestOverallSector3TimeInMS: $bestOverallSector3TimeInMS, bestOverallSector3LapNum: $bestOverallSector3LapNum, lapDistance: $lapDistance, totalDistance: $totalDistance, safetyCarDelta: $safetyCarDelta, carPosition: $carPosition, currentLapNum: $currentLapNum, pitStatus: $pitStatus, sector: $sector, currentLapInvalid: $currentLapInvalid, penalties: $penalties, gridPosition: $gridPosition, driverStatus: $driverStatus, resultStatus: $resultStatus}';
  }

  void setValue(int position, var val) {
    switch (position) {
      case 0:
        {
          lastLapTime = val;
        }
        break;
      case 1:
        {
          currentLapTime = val;
        }
        break;
      case 2:
        {
          sector1TimeInMS = val;
        }
        break;
      case 3:
        {
          sector2TimeInMS = val;
        }
        break;
      case 4:
        {
          bestLapTime = val;
        }
        break;
      case 5:
        {
          bestLapNum = val;
        }
        break;
      case 6:
        {
          bestLapSector1TimeInMS = val;
        }
        break;
      case 7:
        {
          bestLapSector2TimeInMS = val;
        }
        break;
      case 8:
        {
          bestLapSector3TimeInMS = val;
        }
        break;
      case 9:
        {
          bestOverallSector1TimeInMS = val;
        }
        break;
      case 10:
        {
          bestOverallSector1LapNum = val;
        }
        break;
      case 11:
        {
          bestOverallSector2TimeInMS = val;
        }
        break;
      case 12:
        {
          bestOverallSector2LapNum = val;
        }
        break;
      case 13:
        {
          bestOverallSector3TimeInMS = val;
        }
        break;
      case 14:
        {
          bestOverallSector3LapNum = val;
        }
        break;
      case 15:
        {
          lapDistance = val;
        }
        break;
      case 16:
        {
          totalDistance = val;
        }
        break;
      case 17:
        {
          safetyCarDelta = val;
        }
        break;
      case 18:
        {
          carPosition = val;
        }
        break;
      case 19:
        {
          currentLapNum = val;
        }
        break;
      case 20:
        {
          pitStatus = val;
        }
        break;
      case 21:
        {
          sector = val;
        }
        break;
      case 22:
        {
          currentLapInvalid = val;
        }
        break;
      case 23:
        {
          penalties = val;
        }
        break;
      case 24:
        {
          gridPosition = val;
        }
        break;
      case 25:
        {
          driverStatus = val;
        }
        break;
      case 26:
        {
          resultStatus = val;
        }
        break;
    }
  }

  static final lapData = [
    4,
    4,
    2,
    2,
    4,
    1,
    2,
    2,
    2,
    2,
    1,
    2,
    1,
    2,
    1,
    4,
    4,
    4,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1
  ];
}
