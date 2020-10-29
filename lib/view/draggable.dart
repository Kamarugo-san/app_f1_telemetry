import 'dart:io';

import 'package:app_f1_telemetry/data_to_string/speed_type.dart';
import 'package:app_f1_telemetry/packet/header.dart';
import 'package:app_f1_telemetry/packet/packet_car_status_data.dart';
import 'package:app_f1_telemetry/packet/packet_car_telemetry_data.dart';
import 'package:app_f1_telemetry/packet/packet_ids.dart';
import 'package:app_f1_telemetry/packet/packet_lap_data.dart';
import 'package:app_f1_telemetry/packet/packet_participant_data.dart';
import 'package:app_f1_telemetry/view/constants.dart';
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
  PacketParticipantData lastParticipantData;

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
        } else if (header.packetId == PacketIds.participants) {
          var packet = PacketParticipantData(header, list);

          setState(() {
            this.lastHeader = header;
            this.lastParticipantData = packet;
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
      child: Text('Rev lights'),
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

    Widget statusTable = SimpleDialogOption(
      child: Text('Status table'),
      onPressed: () {
        setState(() {
          controller.create(WidgetTypes.statusTable);
        });
        Navigator.of(context).pop();
      },
    );

    Widget ersStorage = SimpleDialogOption(
      child: Text('ERS storage'),
      onPressed: () {
        setState(() {
          controller.create(WidgetTypes.ersStorage);
        });
        Navigator.of(context).pop();
      },
    );

    Widget throttle = SimpleDialogOption(
      child: Text('Throttle'),
      onPressed: () {
        setState(() {
          controller.create(WidgetTypes.throttle);
        });
        Navigator.of(context).pop();
      },
    );

    Widget brake = SimpleDialogOption(
      child: Text('Brake'),
      onPressed: () {
        setState(() {
          controller.create(WidgetTypes.brake);
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
        statusTable,
        ersStorage,
        throttle,
        brake,
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
          child: Wrap(
            children: [
              Container(
                child: Column(
                  children: [
                    FloatingActionButton(
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
                  ],
                ),
              ),
            ],
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
              backgroundColor: Colors.green,
              child: Icon(Icons.done),
              onPressed: () {
                setState(() {
                  isEditing = false;
                });
              },
            ),
          ),
        ),
      );
      l.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 80),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.unfold_more),
              backgroundColor: Colors.purple,
              mini: true,
              onPressed: () {
                var w = _DraggableViewState.controller.getSelectedWidth();
                var h = _DraggableViewState.controller.getSelectedHeight();
                if (h < 500 && w < 500) {
                  _DraggableViewState.controller.updateSize(
                    _DraggableViewState.controller.selectedId,
                    w + 10,
                    h + 10,
                  );
                }
                setState(() {
                  isEditing = true;
                });
              },
            ),
          ),
        ),
      );

      l.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 130),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.unfold_less),
              backgroundColor: Colors.purple,
              mini: true,
              onPressed: () {
                var w = _DraggableViewState.controller.getSelectedWidth();
                var h = _DraggableViewState.controller.getSelectedHeight();
                if (h > 20 && w > 20) {
                  _DraggableViewState.controller.updateSize(
                    _DraggableViewState.controller.selectedId,
                    w - 10,
                    h - 10,
                  );
                }
                setState(() {
                  isEditing = true;
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

    WidgetCreator creator = WidgetCreator(lastCarTelemetry, lastCarStatus,
        lastLapData, lastParticipantData, SpeedType.kph);

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
  _DraggableWidgetState createState() => _DraggableWidgetState(
        widget.start,
        widget.top,
      );
}

class _DraggableWidgetState extends State<DraggableWidget> {
  int s = -1;
  int t = -1;

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
      child: GestureDetector(
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
        onTap: () => {
          setState(
            () {
              _DraggableViewState.controller.selectedId = widget.widget.id;
              print(_DraggableViewState.controller.selectedId);
            },
          ),
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
  double width;
  double height;

  TelemetryWidget(
      this.widgetType, this.id, this.top, this.start, this.width, this.height);
}

class TelemetryWidgetController {
  List<TelemetryWidget> _list = [
    TelemetryWidget(WidgetTypes.lights, 1, 10, 170, 500.0, 50.0),
    TelemetryWidget(WidgetTypes.gear, 2, 60, 360, 120.0, 120.0),
    TelemetryWidget(WidgetTypes.speed, 3, 60, 240, 120.0, 50.0),
    TelemetryWidget(WidgetTypes.statusTable, 4, 60, 490, 170.0, 150.0),
  ];
  int lastId = 4;
  int selectedId = -1;

  List<TelemetryWidget> getList() {
    return _list;
  }

  TelemetryWidget create(int type) {
    var d = TelemetryWidget(
      type,
      _getNextId(),
      -1,
      -1,
      WidgetTypes.getWidthByType(type),
      WidgetTypes.getHeightByType(type),
    );
    _list.add(d);
    selectedId = lastId;
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

  void updateSize(int id, double width, double height) {
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].id == id) {
        _list[i].width = width;
        _list[i].height = height;
        break;
      }
    }
  }

  double getSelectedWidth() {
    if (selectedId == -1) return -1;
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].id == selectedId) {
        return _list[i].width;
      }
    }
    return -1;
  }

  double getSelectedHeight() {
    if (selectedId == -1) return -1;
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].id == selectedId) {
        return _list[i].height;
      }
    }
    return -1;
  }
}
