import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';
import 'package:app_f1_telemetry/packet/packet_participant_data.dart';
import 'package:app_f1_telemetry/view/constants.dart';
import 'package:flutter/material.dart';

class StatusTable extends StatelessWidget {
  static const double width = 170;
  static const double height = 300;
  final List<LapData> lapData;
  final List<CarStatusData> carStatusList;
  final PacketParticipantData participantList;

  StatusTable(this.lapData, this.participantList, this.carStatusList);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ListView(
        children: createList(),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  createList() {
    List<Widget> l = [];

    if (participantList != null && lapData != null && carStatusList != null) {
      for (int i = 0; i < participantList.numActiveCars; i++) {
        for (int j = 0; j < participantList.numActiveCars; j++) {
          if (lapData[j].carPosition == i + 1) {
            Image tyreIcon;

            switch (carStatusList[j].visualTyreCompound) {
              case 16:
                tyreIcon = Image.asset('assets/images/soft-new.png');
                break;
              case 17:
                tyreIcon = Image.asset('assets/images/medium-new.png');
                break;
              case 18:
                tyreIcon = Image.asset('assets/images/hard-new.png');
                break;
              case 7:
                tyreIcon = Image.asset('assets/images/intermediate-new.png');
                break;
              case 8:
                tyreIcon = Image.asset('assets/images/wet-new.png');
                break;
            }

            l.add(ItemStatusTable(
              name: participantList.participantData[j].name,
              position: i + 1,
              tyreIcon: tyreIcon,
            ));
            break;
          }
        }
      }
    } else {
      for (int i = 0; i < 10; i++) {
        l.add(ItemStatusTable(
          name: "Participant name",
          position: i + 1,
          tyreIcon: Image.asset('assets/images/soft-new.png'),
        ));
      }
    }

    return l;
  }
}

class ItemStatusTable extends StatelessWidget {
  final String name;
  final int position;
  final Image tyreIcon;

  ItemStatusTable({this.name, this.position, this.tyreIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: tyreIcon,
              height: 30,
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: Container(
                color: Colors.black26,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            child: FittedBox(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(position.toString()),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.white,
                              width: 5,
                              height: 15,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: FittedBox(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color: Constants.primaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
