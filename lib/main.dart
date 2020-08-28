import 'dart:io';

import 'package:app_f1_telemetry/data_to_string/data_to_string_converter.dart';
import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/header.dart';
import 'package:app_f1_telemetry/packet/packet_car_status_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/packet_ids.dart';
import 'package:flutter/material.dart';

import 'data_to_string/temperature_type.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1 telemetry',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'F1 telemetry'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataToStringConverter converter =
      DataToStringConverter(TemperatureType.celsius, SpeedType.kph);
  Header lastHeader;
  PacketCarTelemetryData lastCarTelemetry;
  PacketCarStatusData lastCarStatus;

  _MyHomePageState() {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 20777)
        .then((RawDatagramSocket socket) {
      debugPrint('Datagram socket ready to receive');
      print('${socket.address.address}:${socket.port}');

      socket.listen((RawSocketEvent e) {
        print('heeeeeeeeeeeeeeeeey');
        Datagram d = socket.receive();
        if (d == null) return;
        print('hello');
        var list = d.data;
        var header = Header(list);

        if (header.packetId == PacketIds.carTelemetry) {
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
    String gear = '0';
    String speed = '0';
    String temps = 'RL: 0, RR: 0, FL: 0, FR: 0';

    String ersDeployMode = 'ERS';
    String ersDeployedThisLap = 'ERS D';
    String ersHarvestedThisLapMGUH = 'ERS MGU-H';
    String ersHarvestedThisLapMGUK = 'ERS MGU-K';

    if (lastCarTelemetry != null) {
      int playerCarIndex = lastCarTelemetry.header.playerCarIndex;
      CarTelemetryData playerCar =
          lastCarTelemetry.carTelemetryData[playerCarIndex];

      rpm = converter.getRpm(playerCar);
      gear = converter.getGear(playerCar);
      speed = converter.getSpeed(playerCar);

      List<String> tempsList = converter.getTyreInnerTemperature(playerCar);
      temps =
          'RL: ${tempsList[0]}, RR: ${tempsList[1]}, FL: ${tempsList[2]}, FR: ${tempsList[3]}';
    }

    if (lastCarStatus != null) {
      int playerCarIndex = lastCarStatus.header.playerCarIndex;
      CarStatusData playerCar = lastCarStatus.carStatusData[playerCarIndex];

      ersDeployMode = 'ERS ${playerCar.ersDeployMode}';
      ersDeployedThisLap = 'ERS D ${playerCar.ersDeployedThisLap}';
      ersHarvestedThisLapMGUH = 'ERS H MGU-H ${playerCar.ersHarvestedThisLapMGUH}';
      ersHarvestedThisLapMGUK = 'ERS H MGU-K ${playerCar.ersHarvestedThisLapMGUK}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              gear,
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              speed,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              rpm,
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              temps,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              ersDeployMode,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              ersDeployedThisLap,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              ersHarvestedThisLapMGUH,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              ersHarvestedThisLapMGUK,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
