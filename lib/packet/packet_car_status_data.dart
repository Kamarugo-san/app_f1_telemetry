import 'dart:typed_data';

import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/header.dart';

class PacketCarStatusData {
  Header header;
  List<CarStatusData> carStatusData = List(22);

  PacketCarStatusData(Header header, Uint8List list) {
    this.header = header;

    int i = 0;
    int listIndex = 24;

    int byteSize = CarStatusData.statusData.reduce((a, b) => a + b);

    while (i < 22) {
      var s = list.sublist(listIndex, listIndex + byteSize);
      listIndex += byteSize;

      carStatusData[i] = CarStatusData(s);
      i++;
    }
  }
}
