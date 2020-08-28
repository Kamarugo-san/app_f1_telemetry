import 'dart:typed_data';

import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/header.dart';

class PacketCarTelemetryData {
  Header header;
  List<CarTelemetryData> carTelemetryData = List(22);
  int buttonStatus;
  int mfdPanelIndex;
  int mfdPanelIndexSecondaryPlayer;
  int suggestedGear;

  PacketCarTelemetryData(Header header, Uint8List list) {
    this.header = header;

    int i = 0;
    int listIndex = 24;

    int byteSize = CarTelemetryData.telemetryData.reduce((a, b) => a + b);

    while (i < 22) {
      var t = list.sublist(listIndex, listIndex + byteSize);
      listIndex += byteSize;

      carTelemetryData[i] = CarTelemetryData(t);
      i++;
    }

    buttonStatus = Uint8List.fromList(list
        .sublist(listIndex, listIndex + 4)
        .reversed
        .toList())
        .buffer
        .asByteData()
        .getUint32(0);

    mfdPanelIndex = list[listIndex + 4];
    mfdPanelIndexSecondaryPlayer = list[listIndex + 5];
    suggestedGear = list[listIndex + 6];
  }
}
