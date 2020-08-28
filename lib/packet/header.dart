import 'dart:typed_data';

class Header {
  /// 2020  [0 - 1]
  int packetFormat;

  /// Game major version - "X.00" [2]
  int gameMajorVersion;

  /// Game minor version - "1.XX" [3]
  int gameMinorVersion;

  /// Version of this packet type, all start from 1 [4]
  int packetVersion;

  /// Identifier for the packet type, see below [5]
  int packetId;

  /// Unique identifier for the session [6 - 13]
  int sessionUID;

  /// Session timestamp  (in seconds, from the lights) [14 - 17]
  double sessionTime;

  /// Identifier for the frame the data was retrieved on [18 - 21]
  int frameIdentifier;

  /// Index of player's car in the array [22]
  int playerCarIndex;

  /// Index of secondary player's car in the array [23]
  int secondaryPlayerCarIndex;

  Header(Uint8List list) {
    packetFormat = (list[1] << 8) + list[0];
    gameMajorVersion = list[2];
    gameMinorVersion = list[3];
    packetVersion = list[4];
    packetId = list[5];

    sessionUID = 0;
    for (int i = 13; i >= 6; i--) {
      if (i != 13) {
        sessionUID = (sessionUID << 8);
      }
      sessionUID = list[i];
    }

//    sessionTime = 0;
//    for (int i = 18; i >= 14; i--) {
//      if (i != 18) {
//        sessionTime = (sessionTime << 8);
//      }
//      sessionTime = list[i].toDouble();
//    }


    sessionTime = Uint8List.fromList(list.sublist(14, 18).reversed.toList())
        .buffer
        .asByteData()
        .getFloat32(0);

    frameIdentifier = Uint8List.fromList(list.sublist(18, 22).reversed.toList())
        .buffer
        .asByteData()
        .getUint32(0);
    playerCarIndex = Uint8List.fromList(list.sublist(22, 23).reversed.toList())
        .buffer
        .asByteData()
        .getUint8(0);
    secondaryPlayerCarIndex =
        Uint8List.fromList(list.sublist(23, 24).reversed.toList())
            .buffer
            .asByteData()
            .getUint8(0);
  }
}
