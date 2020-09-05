import 'dart:io';

import 'package:app_f1_telemetry/View/draggable.dart';
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
  runApp(Background());
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

      fuelInTank = DataToStringConverter.dp(playerCar.fuelInTank, 1).toString();

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

    return Scaffold();
  }
}