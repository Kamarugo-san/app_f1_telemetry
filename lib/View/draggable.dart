import 'dart:io';

import 'package:app_f1_telemetry/View/constants.dart';
import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/header.dart';
import 'package:app_f1_telemetry/packet/packet_car_status_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/packet_ids.dart';
import 'package:app_f1_telemetry/packet/packet_lap_data.dart';
import 'package:app_f1_telemetry/widgets/widget_creator.dart';
import 'package:app_f1_telemetry/widgets/widget_types.dart';
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
      title: 'F1 Telemetry',
      home: DraggableView(),
    );
  }
}

class DraggableView extends StatefulWidget {
  void showWidgetDialog(BuildContext context, WidgetBuilder builder) {
    showDialog(
      context: context,
      builder: builder,
    );
  }

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

  WidgetBuilder getDialog(BuildContext context) {
    Widget cmDashboardLeft = SimpleDialogOption(
      child: Text('CodeMaster\'s dashboard (left)'),
      onPressed: () {
        setState(() {
          controller.create(WidgetTypes.cmDashboardLeft);
        });
        Navigator.of(context).pop();
      },
    );

    Widget gear = SimpleDialogOption(
      child: Text('Gear'),
      onPressed: () {
        setState(() {
          controller.create(WidgetTypes.gear);
        });
        Navigator.of(context).pop();
      },
    );

    Widget lights = SimpleDialogOption(
      child: Text('Lights'),
      onPressed: () {
        setState(() {
          controller.create(WidgetTypes.lights);
        });
        Navigator.of(context).pop();
      },
    );

    Widget speed = SimpleDialogOption(
      child: Text('Speed'),
      onPressed: () {
        setState(() {
          controller.create(WidgetTypes.speed);
        });
        Navigator.of(context).pop();
      },
    );

    SimpleDialog dialog = SimpleDialog(
      title: const Text('Chose a widget'),
      children: [
        cmDashboardLeft,
        gear,
        lights,
        speed,
      ],
    );

    return (context) {
      return dialog;
    };
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> l = getWidget();

    l.add(
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
                widget.showWidgetDialog(context, getDialog(context));
              }
            },
          ),
        ),
      ),
    );

    if (isEditing) {
      l.add(
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

    return Scaffold(
      body: Container(
        color: Constants.backgroundColor,
        child: Stack(
          children: l,
        ),
      ),
    );
  }

  List<Widget> getWidget() {
    List<Widget> a = [];

    WidgetCreator creator = WidgetCreator(
        lastCarTelemetry, lastCarStatus, lastLapData, SpeedType.kph);

    List<TelemetryWidget> b = controller.getList();
    b.forEach((element) {
      a.add(creator.create(element, isEditing));
    });

    return a;
  }
}

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
  final int id;
  int start;
  int top;

  PositionedWidget({
    @required this.widget,
    @required this.id,
    this.start = -1,
    this.top = -1,
  });
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
