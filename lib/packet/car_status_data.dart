import 'dart:typed_data';

class CarStatusData {
  /// 0 (off) - 2 (high)
  int tractionControl;

  /// 0 (off) - 1 (on)
  int antiLockBrakes;

  /// Fuel mix - 0 = lean, 1 = standard, 2 = rich, 3 = max
  int fuelMix;

  /// Front brake bias (percentage)
  int frontBrakeBias;

  /// Pit limiter status - 0 = off, 1 = on
  int pitLimiterStatus;

  /// Current fuel mass
  double fuelInTank;

  /// Fuel capacity
  double fuelCapacity;

  /// Fuel remaining in terms of laps (value on MFD)
  double fuelRemainingLaps;

  /// Cars max RPM, point of rev limiter
  int maxRPM;

  /// Cars idle RPM
  int idleRPM;

  /// Maximum number of gears
  int maxGears;

  /// 0 = not allowed, 1 = allowed, -1 = unknown
  int drsAllowed;

  /// 0 = DRS not available, non-zero - DRS will be available in [X] metres
  int drsActivationDistance;

  /// Tyre wear percentage
  List<int> tyresWear = List(4);

  /// F1 Modern - 16 = C5, 17 = C4, 18 = C3, 19 = C2, 20 = C1, 7 = inter, 8 = wet | F1 Classic - 9 = dry, 10 = wet | F2 – 11 = super soft, 12 = soft, 13 = medium, 14 = hard, 15 = wet
  int actualTyreCompound;

  /// F1 visual (can be different from actual compound) 16 = soft, 17 = medium, 18 = hard, 7 = inter, 8 = wet |  F1 Classic – same as above | F2 – same as above
  int visualTyreCompound;

  /// Age in laps of the current set of tyres
  int tyresAgeLaps;

  /// Tyre damage (percentage)
  List<int> tyresDamage = List(4);

  /// Front left wing damage (percentage)
  int frontLeftWingDamage;

  /// Front right wing damage (percentage)
  int frontRightWingDamage;

  /// Rear wing damage (percentage)
  int rearWingDamage;

  /// Indicator for DRS fault, 0 = OK, 1 = fault
  int drsFault;

  /// Engine damage (percentage)
  int engineDamage;

  /// Gear box damage (percentage)
  int gearBoxDamage;

  /// -1 = invalid/unknown, 0 = none, 1 = green, 2 = blue, 3 = yellow, 4 = red
  int vehicleFiaFlags;

  /// ERS energy store in Joules
  double ersStoreEnergy;

  /// ERS deployment mode, 0 = none, 1 = medium, 2 = overtake, 3 = hotlap
  int ersDeployMode;

  /// ERS energy harvested this lap by MGU-K
  double ersHarvestedThisLapMGUK;

  /// ERS energy harvested this lap by MGU-H
  double ersHarvestedThisLapMGUH;

  /// ERS energy deployed this lap
  double ersDeployedThisLap;

  CarStatusData(Uint8List list) {
    int refIndex = 0;
    int listIndex = 0;

    while (refIndex < statusData.length) {
      if (statusData[refIndex] == 1) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + statusData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getUint8(0));
      }
      if (statusData[refIndex] == 2) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + statusData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getUint16(0));
      }
      if (statusData[refIndex] == 4) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + statusData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getFloat32(0));
      }

      listIndex += statusData[refIndex];
      refIndex++;
    }
  }

  void setValue(int position, var val) {
    switch (position) {
      case 0:
        {
          tractionControl = val;
        }
        break;
      case 1:
        {
          antiLockBrakes = val;
        }
        break;
      case 2:
        {
          fuelMix = val;
        }
        break;
      case 3:
        {
          frontBrakeBias = val;
        }
        break;
      case 4:
        {
          pitLimiterStatus = val;
        }
        break;
      case 5:
        {
          fuelInTank = val;
        }
        break;
      case 6:
        {
          fuelCapacity = val;
        }
        break;
      case 7:
        {
          fuelRemainingLaps = val;
        }
        break;
      case 8:
        {
          maxRPM = val;
        }
        break;
      case 9:
        {
          idleRPM = val;
        }
        break;
      case 10:
        {
          maxGears = val;
        }
        break;
      case 11:
        {
          drsAllowed = val;
        }
        break;
      case 12:
        {
          drsActivationDistance = val;
        }
        break;
      case 13:
        {
          tyresWear[0] = val;
        }
        break;
      case 14:
        {
          tyresWear[1] = val;
        }
        break;
      case 15:
        {
          tyresWear[2] = val;
        }
        break;
      case 16:
        {
          tyresWear[3] = val;
        }
        break;
      case 17:
        {
          actualTyreCompound = val;
        }
        break;
      case 18:
        {
          visualTyreCompound = val;
        }
        break;
      case 19:
        {
          tyresAgeLaps = val;
        }
        break;
      case 20:
        {
          tyresDamage[0] = val;
        }
        break;
      case 21:
        {
          tyresDamage[1] = val;
        }
        break;
      case 22:
        {
          tyresDamage[2] = val;
        }
        break;
      case 23:
        {
          tyresDamage[3] = val;
        }
        break;
      case 24:
        {
          frontLeftWingDamage = val;
        }
        break;
      case 25:
        {
          frontRightWingDamage = val;
        }
        break;
      case 26:
        {
          rearWingDamage = val;
        }
        break;
      case 27:
        {
          drsFault = val;
        }
        break;
      case 28:
        {
          engineDamage = val;
        }
        break;
      case 29:
        {
          gearBoxDamage = val;
        }
        break;
      case 30:
        {
          vehicleFiaFlags = val;
        }
        break;
      case 31:
        {
          ersStoreEnergy = val;
        }
        break;
      case 32:
        {
          ersDeployMode = val;
        }
        break;
      case 33:
        {
          ersHarvestedThisLapMGUK = val;
        }
        break;
      case 34:
        {
          ersHarvestedThisLapMGUH = val;
        }
        break;
      case 35:
        {
          ersDeployedThisLap = val;
        }
        break;
    }
  }

  static final statusData = [
    1,
    1,
    1,
    1,
    1,
    4,
    4,
    4,
    2,
    2,
    1,
    1,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    4,
    1,
    4,
    4,
    4
  ];
}
