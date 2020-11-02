import 'dart:typed_data';

import 'package:app_f1_telemetry/packet/header.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';

class PacketLapData {
  Header header;
  List<LapData> lapData = List(22);

  PacketLapData(Header header, Uint8List list) {
    this.header = header;

    int i = 0;
    int listIndex = 24;

    int byteSize = LapData.lapData.reduce((a, b) => a + b);

    while (i < 22) {
      var lap = list.sublist(listIndex, listIndex + byteSize);
      listIndex += byteSize;

      lapData[i] = LapData(lap);
      i++;
    }
  }
}
