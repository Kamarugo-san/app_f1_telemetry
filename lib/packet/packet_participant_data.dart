import 'dart:typed_data';

import 'package:app_f1_telemetry/packet/header.dart';
import 'package:app_f1_telemetry/packet/participant_data.dart';

class PacketParticipantData {
  Header header;
  int numActiveCars;
  List<ParticipantData> participantData = List(22);

  PacketParticipantData(Header header, Uint8List list) {
    this.header = header;

    int i = 0;
    int listIndex = 25;

    int byteSize = ParticipantData.participantData.reduce((a, b) => a + b);

    while (i < 22) {
      var t = list.sublist(listIndex, listIndex + byteSize);
      listIndex += byteSize;

      participantData[i] = ParticipantData(t);
      i++;
    }
  }
}
