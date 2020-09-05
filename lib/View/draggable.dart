import 'dart:math';

import 'package:app_f1_telemetry/View/constants.dart';
import 'package:app_f1_telemetry/View/data_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DraggableView(),
    );
  }
}

class DraggableView extends StatefulWidget {
  _DraggableViewState createState() => _DraggableViewState();
}

class _DraggableViewState extends State<DraggableView> {
  _DraggableViewState() {
    wList = [];
  }

  bool isEditing = false;

  List<TelemetryWidget> wList = [];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

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
    List<Widget> a = [
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
                    int rg = Random().nextInt(120) + 50;
                    int b = Random().nextInt(55) + 200;

                    wList.add(
                      TelemetryWidget(
                        widget: PositionedWidget(
                          widget: DataBox(
                            header: Text("142 KPH"),
                            t0_0: Text(
                              "L2",
                              style:
                                  TextStyle(color: Constants.primaryTextColor),
                            ),
                            t0_1: Text(
                              "P17",
                              style:
                                  TextStyle(color: Constants.primaryTextColor),
                            ),
                            t1_0: Text(
                              "23.5",
                              style:
                                  TextStyle(color: Constants.primaryTextColor),
                            ),
                            t1_1: Text(
                              "+1.4",
                              style:
                                  TextStyle(color: Constants.primaryTextColor),
                            ),
                          ),
                        ),
                        width: Constants.dataBoxWidth,
                        height: Constants.dataBoxHeight,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    ];

    if (isEditing) {
      a.add(
        Padding(
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              child: Icon(Icons.close),
              onPressed: () {
                wList.forEach((element) {
                  print("${element.widget.start} | ${element.widget.top}");
                });

                setState(() {
                  isEditing = false;
                });
              },
            ),
          ),
        ),
      );
    }

    wList.forEach(
      (element) {
        if (isEditing) {
          a.add(
            DraggableWidget(
              widget: PositionedWidget(widget: element.widget.widget),
              width: element.width,
              height: element.height,
            ),
          );
        } else {
          a.add(element.widget.widget);
        }
      },
    );
    return a;
  }
}

class TelemetryWidget {
  final PositionedWidget widget;
  final double width;
  final double height;

  TelemetryWidget({this.widget, this.width, this.height});
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

  PositionedWidget({@required this.widget, this.start = -1, this.top = -1});
}

class Douglas {
  int widgetType;
  int id;
  int top;
  int start;
}

class Matheus {
  List<Douglas> _list = [];
  int lastId = 0;

  List<Douglas> getList() {
    return _list;
  }

  int getNextId() {
    lastId++;
    return lastId;
  }

  void update(Douglas d) {
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].id == d.id) {
        _list[i] = d;
        break;
      }
    }
  }
}
