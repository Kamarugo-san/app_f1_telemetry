import 'package:app_f1_telemetry/constants/team_colors.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';
import 'package:app_f1_telemetry/packet/packet_participant_data.dart';
import 'package:app_f1_telemetry/packet/participant_data.dart';
import 'package:app_f1_telemetry/view/constants.dart';
import 'package:flutter/material.dart';

class StatusTable extends StatelessWidget {
  static const double width = 170;
  static const double height = 150;
  final List<LapData> lapData;
  final List<CarStatusData> carStatusList;
  final PacketParticipantData participantList;

  StatusTable(
    this.lapData,
    this.participantList,
    this.carStatusList,
  );

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
    List<Widget> tableList = [];

    if (participantList != null && lapData != null && carStatusList != null) {
      List<CarItem> orderList = List(participantList.numActiveCars);
      int playerCarIndex = participantList.header.playerCarIndex;

      for (int i = 0; i < 22; i++) {
        if (lapData[i].resultStatus != 7 && lapData[i].resultStatus != 0) {
          orderList[lapData[i].carPosition - 1] = CarItem(
            participantList.participantData[i].name,
            lapData[i].carPosition,
            carStatusList[i].visualTyreCompound,
            participantList.participantData[i].teamId,
          );
        }
      }

      int playerPos = lapData[playerCarIndex].carPosition - 1;

      List<CarItem> listToShow = List(5);

      if (playerPos < 3) {
        listToShow[0] = orderList[0];
        listToShow[1] = orderList[1];
        listToShow[2] = orderList[2];
        listToShow[3] = orderList[3];
        listToShow[4] = orderList[4];
      } else if (playerPos > participantList.numActiveCars - 3) {
        listToShow[0] = orderList[participantList.numActiveCars - 5];
        listToShow[1] = orderList[participantList.numActiveCars - 4];
        listToShow[2] = orderList[participantList.numActiveCars - 3];
        listToShow[3] = orderList[participantList.numActiveCars - 2];
        listToShow[4] = orderList[participantList.numActiveCars - 1];
      } else {
        listToShow[0] = orderList[playerPos - 2];
        listToShow[1] = orderList[playerPos - 1];
        listToShow[2] = orderList[playerPos];
        listToShow[3] = orderList[playerPos + 1];
        listToShow[4] = orderList[playerPos + 2];
      }

      for (int i = 0; i < 5; i++) {
        tableList.add(ItemStatusTable(
          carItem: listToShow[i],
        ));
      }
    } else {
      for (int i = 0; i < 5; i++) {
        tableList.add(ItemStatusTable(
          carItem: CarItem("Participant name", i + 1, 16, 255),
        ));
      }
    }

    return tableList;
  }
}

class CarItem {
  final String name;
  final int position;
  final int tyreIcon;
  final int teamId;

  CarItem(this.name, this.position, this.tyreIcon, this.teamId);
}

class ItemStatusTable extends StatelessWidget {
  final CarItem carItem;

  ItemStatusTable({this.carItem});

  @override
  Widget build(BuildContext context) {
    Image tyreIcon;

    switch (carItem.tyreIcon) {
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
                                child: Text(carItem.position.toString()),
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
                              color: TeamColors.get(carItem.teamId).color,
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
                                  carItem.name,
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
