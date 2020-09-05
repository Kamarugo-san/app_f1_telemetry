import 'dart:io';
import 'dart:math';

import 'package:app_f1_telemetry/View/constants.dart';
import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/car_status_data.dart';
import 'package:app_f1_telemetry/packet/car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/header.dart';
import 'package:app_f1_telemetry/packet/lap_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_status_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/packet_ids.dart';
import 'package:app_f1_telemetry/packet/packet_lap_data.dart';
import 'package:app_f1_telemetry/widgets/cm_dashboard_right.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      home: DraggableView(),
    );
  }
}

class DraggableView extends StatefulWidget {
  _DraggableViewState createState() => _DraggableViewState();
}

class _DraggableViewState extends State<DraggableView> {
  bool isEditing = false;

  List<TelemetryWidget> wList = [];
  static TelemetryWidgetController controller = TelemetryWidgetController();

  Header lastHeader;
  PacketCarTelemetryData lastCarTelemetry;
  PacketCarStatusData lastCarStatus;
  PacketLapData lastLapData;

  _DraggableViewState() {
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
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: getWidget(),
        ),
      ),
    );
  }

  List<Widget> getWidget() {
    List<Widget> a = [];

    LapData lapData;
    if (lastLapData != null) {
      lapData = lastLapData.lapData[lastLapData.header.playerCarIndex];
    }

    CarTelemetryData telemetryData;
    if (lastCarTelemetry != null) {
      telemetryData = lastCarTelemetry
          .carTelemetryData[lastCarTelemetry.header.playerCarIndex];
    }

    CarStatusData carStatusData;
    if (lastCarStatus != null) {
      carStatusData =
      lastCarStatus.carStatusData[lastCarStatus.header.playerCarIndex];
    }

    List<TelemetryWidget> b = controller.getList();
    b.forEach((element) {
      if (element.widgetType == 0) {
        if (isEditing) {
          a.add(
            DraggableWidget(
              widget: PositionedWidget(
                id: element.id,
                start: element.start,
                top: element.top,
                widget: CmDashboardRight(
                  speedType: SpeedType.kph,
                  lapData: null,
                  telemetryData: null,
                  carStatusData: null,
                ),
              ),
              width: Constants.dataBoxWidth,
              height: Constants.dataBoxHeight,
            ),
          );
        } else {
          a.add(
            Positioned(
              top: element.top.toDouble(),
              left: element.start.toDouble(),
              child: CmDashboardRight(
                speedType: SpeedType.kph,
                lapData: lapData,
                telemetryData: telemetryData,
                carStatusData: carStatusData,
              ),
            ),
          );
        }
      }
    });

    a.add(
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            child: Icon(isEditing ? Icons.add : Icons.edit),
            onPressed: () {
              if (!isEditing) {
                setState(() {
                  isEditing = !isEditing;
                });
              } else {
                setState(
                  () {
                    controller.create(0);
                  },
                );
              }
            },
          ),
        ),
      ),
    );

    if (isEditing) {
      a.add(
        Padding(
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              child: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  isEditing = false;
                });
              },
            ),
          ),
        ),
      );
    }

    return a;
  }
}

/*class TelemetryWidget {
  final PositionedWidget widget;
  final double width;
  final double height;

  TelemetryWidget({this.widget, this.width, this.height});
}*/

class DraggableWidget extends StatefulWidget {
  final PositionedWidget widget;
  final double width;
  final double height;

  DraggableWidget(
      {@required this.widget,
      this.width = Constants.defaultSize,
      this.height = Constants.defaultSize});

  @override
  _DraggableWidgetState createState() =>
      _DraggableWidgetState(widget.start, widget.top);
}

class _DraggableWidgetState extends State<DraggableWidget> {
  int s = -2;
  int t = -2;

  _DraggableWidgetState(this.s, this.t);

  @override
  Widget build(BuildContext context) {
    if (s == -1 && t == -1) {
      s = (MediaQuery.of(context).size.width ~/ 2 - widget.width / 2).toInt();
      t = (MediaQuery.of(context).size.height ~/ 2 - widget.height / 2).toInt();

      _DraggableViewState.controller.updatePosition(widget.widget.id, s, t);
    }

    Random r = new Random();

    return Positioned(
      left: s.toDouble(),
      top: t.toDouble(),
      child: Draggable(
        child: widget.widget.widget,
        feedback: Material(
          type: MaterialType.transparency,
          child: widget.widget.widget,
        ),
        childWhenDragging: Container(width: 0, height: 0),
        onDragEnd: (details) {
          setState(() {
            s = (details.offset.dx / 10).round() * 10;
            t = (details.offset.dy / 10).round() * 10;

            widget.widget.start = s;
            widget.widget.top = t;

            _DraggableViewState.controller
                .updatePosition(widget.widget.id, s, t);
          });
        },
      ),
    );
  }
}

class PositionedWidget {
  final Widget widget;
  int start;
  int top;
  int id;

  PositionedWidget(
      {@required this.widget,
      @required this.id,
      this.start = -1,
      this.top = -1});
}

class TelemetryWidget {
  int widgetType;
  int id;
  int top;
  int start;

  TelemetryWidget(this.widgetType, this.id, this.top, this.start);
}

class TelemetryWidgetController {
  List<TelemetryWidget> _list = [];
  int lastId = 0;

  List<TelemetryWidget> getList() {
    return _list;
  }

  TelemetryWidget create(int type) {
    var d = TelemetryWidget(type, _getNextId(), -1, -1);
    _list.add(d);
    return d;
  }

  int _getNextId() {
    lastId++;
    return lastId;
  }

  void updatePosition(int id, int start, int top) {
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].id == id) {
        _list[i].start = start;
        _list[i].top = top;
        break;
      }
    }
  }
}
