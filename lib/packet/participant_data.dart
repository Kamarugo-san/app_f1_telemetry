import 'dart:convert';
import 'dart:typed_data';

class ParticipantData {
  /// Whether the vehicle is AI (1) or Human (0) controlled
  int aiControlled;

  /// Driver id - see appendix
  int driverId;

  /// Team id - see appendix
  int teamId;

  /// Race number of the car
  int raceNumber;

  /// Nationality of the driver
  int nationality;

  /// Name of participant in UTF-8 format – null terminated
  /// Will be truncated with … (U+2026) if too long
  String name;

  /// The player's UDP setting, 0 = restricted, 1 = public
  int yourTelemetry;

  ParticipantData(Uint8List list) {
    int refIndex = 0;
    int listIndex = 0;

    while (refIndex < participantData.length) {
      if (participantData[refIndex] == 1) {
        setValue(
            refIndex,
            Uint8List.fromList(list
                    .sublist(listIndex, listIndex + participantData[refIndex])
                    .reversed
                    .toList())
                .buffer
                .asByteData()
                .getUint8(0));
      }
      if (participantData[refIndex] == 48) {
        setValue(
            refIndex,
            utf8.decode(list.sublist(
                listIndex, listIndex + participantData[refIndex])));
      }
      listIndex += participantData[refIndex];
      refIndex++;
    }
  }

  void setValue(int position, var val) {
    switch (position) {
      case 0:
        {
          aiControlled = val;
        }
        break;
      case 1:
        {
          driverId = val;
        }
        break;
      case 2:
        {
          teamId = val;
        }
        break;
      case 3:
        {
          raceNumber = val;
        }
        break;
      case 4:
        {
          nationality = val;
        }
        break;
      case 5:
        {
          name = val;
        }
        break;
      case 6:
        {
          yourTelemetry = val;
        }
        break;
    }
  }

  static final participantData = [1, 1, 1, 1, 1, 48, 1];
}
