import 'dart:io';

import 'package:app_f1_telemetry/data_to_string/data_to_string_converter.dart';
import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/header.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_status_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/packet_ids.dart';
import 'package:app_f1_telemetry/packet/packet_lap_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data_to_string/temperature_type.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'F1 telemetry',
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.black26),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color textColor = Colors.white70;
  final DataToStringConverter converter =
      DataToStringConverter(TemperatureType.celsius, SpeedType.kph);
  Header lastHeader;
  PacketCarTelemetryData lastCarTelemetry;
  PacketCarStatusData lastCarStatus;
  PacketLapData lastLapData;

  _MyHomePageState() {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 20777)
        .then((RawDatagramSocket socket) {
      debugPrint('Datagram socket ready to receive');
      print('${socket.address.address}:${socket.port}');

      socket.listen((RawSocketEvent e) {
        Datagram d = socket.receive();
        if (d == null) return;
        print('Received datagram');

        var list = d.data;
        var header = Header(list);

        if (header.packetId == PacketIds.lapData) {
          var packet = PacketLapData(header, list);

          setState(() {
            this.lastHeader = header;
            this.lastLapData = packet;
          });
        } else if (header.packetId == PacketIds.carTelemetry) {
          var packet = PacketCarTelemetryData(header, list);

          setState(() {
            this.lastHeader = header;
            this.lastCarTelemetry = packet;
          });
        } else if (header.packetId == PacketIds.carStatus) {
          var packet = PacketCarStatusData(header, list);

          setState(() {
            this.lastHeader = header;
            this.lastCarStatus = packet;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String rpm = '0';
    String gear = 'N';
    String speed = '0 KPH';
    String temps = 'RL: 0, RR: 0, FL: 0, FR: 0';

    int ersStorage = 0;
    String ersDeployMode = 'ERS';
    int ersDeployedThisLap = 0;
    String ersHarvestedThisLapMGUH = 'ERS MGU-H';
    String ersHarvestedThisLapMGUK = 'ERS MGU-K';
    String fuelInTank = '0.0';
    String fuelRemainingLaps = '(0.0)';
    Color fuelRemainingLapsColor = Colors.green[900];

    String currentLapNum = 'L1';
    String carPosition = 'P0';
    String currentLapTime = '--:--.---';
    List<String> tempsList = converter.getDefaultTempsList();

    if (lastCarTelemetry != null) {
      int playerCarIndex = lastCarTelemetry.header.playerCarIndex;
      CarTelemetryData playerCar =
          lastCarTelemetry.carTelemetryData[playerCarIndex];

      rpm = converter.getRpm(playerCar);
      gear = converter.getGear(playerCar);
      speed = converter.getSpeed(playerCar);

      tempsList = converter.getTyreInnerTemperature(playerCar);
      temps =
          'RL: ${tempsList[0]}, RR: ${tempsList[1]}, FL: ${tempsList[2]}, FR: ${tempsList[3]}';
    }

    if (lastCarStatus != null) {
      int playerCarIndex = lastCarStatus.header.playerCarIndex;
      CarStatusData playerCar = lastCarStatus.carStatusData[playerCarIndex];

      ersStorage = converter.getErsStoragePercentage(playerCar);

      ersDeployMode = 'ERS ${playerCar.ersDeployMode}';
      ersDeployedThisLap = converter.getErsDeployPercentage(playerCar);
      ersHarvestedThisLapMGUH =
          'ERS H MGU-H ${playerCar.ersHarvestedThisLapMGUH}';
      ersHarvestedThisLapMGUK =
          'ERS H MGU-K ${playerCar.ersHarvestedThisLapMGUK}';

      fuelInTank = converter.dp(playerCar.fuelInTank, 1).toString();

      fuelRemainingLaps = converter.getFuelRemainingLaps(playerCar);
      if (playerCar.fuelRemainingLaps < 0) {
        fuelRemainingLapsColor = Colors.red[900];
      }
    }

    if (lastLapData != null) {
      int playerCarIndex = lastLapData.header.playerCarIndex;
      LapData lap = lastLapData.lapData[playerCarIndex];

      currentLapNum = 'L${lap.currentLapNum}';
      carPosition = 'P${lap.carPosition}';
      currentLapTime = converter.getCurrentLapTime(lap);
    }

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DataBox(
                    header: Text(
                      speed,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    t0_0: Text(
                      currentLapNum,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    t0_1: Text(
                      carPosition,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    t1_0: Text(
                      fuelInTank,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    t1_1: Text(
                      fuelRemainingLaps,
                      style: TextStyle(
                        color: fuelRemainingLapsColor,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    child: Text(
                      gear,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 128,
                      ),
                    ),
                  ),
                  DataBox(
                    header: Text(
                      currentLapTime,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24.0,
                      ),
                    ),
                    t0_0: Text(
                      tempsList[2],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    t0_1: Text(
                      tempsList[3],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    t1_0: Text(
                      tempsList[0],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                    t1_1: Text(
                      tempsList[1],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              ersHarvestedThisLapMGUH,
              style: TextStyle(fontSize: 24, color: Colors.yellow[700]),
            ),
            Text(
              ersHarvestedThisLapMGUK,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ));
  }
}

class DataBox extends StatelessWidget {
  DataBox({
    this.header,
    this.t0_0,
    this.t0_1,
    this.t1_0,
    this.t1_1,
  });

  final Text header;
  final Text t0_0;
  final Text t0_1;
  final Text t1_0;
  final Text t1_1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.white24,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: header,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    t0_0,
                    t0_1,
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    t1_0,
                    t1_1,
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
