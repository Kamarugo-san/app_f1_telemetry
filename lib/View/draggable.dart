import 'dart:math';

import 'package:app_f1_telemetry/View/constants.dart';
import 'package:app_f1_telemetry/View/data_box.dart';
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
  double _maxWidth = 0;
  double _maxHeight = 0;

  _DraggableViewState() {
    wList = [
      Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  int rg = Random().nextInt(120) + 50;
                  int b = Random().nextInt(55) + 200;

                  wList.add(
                    DraggableWidget(
                      widget: DataBox(
                        header: Text("142 KPH"),
                        t0_0: Text(
                          "L2",
                          style: TextStyle(color: Constants.primaryTextColor),
                        ),
                        t0_1: Text(
                          "P17",
                          style: TextStyle(color: Constants.primaryTextColor),
                        ),
                        t1_0: Text(
                          "23.5",
                          style: TextStyle(color: Constants.primaryTextColor),
                        ),
                        t1_1: Text(
                          "+1.4",
                          style: TextStyle(color: Constants.primaryTextColor),
                        ),
                      ),
                      width: Constants.dataBoxWidth,
                      height: Constants.dataBoxHeight,
                    ),
                  );

                  // wList.add(
                  //   DraggableWidget(
                  //     Container(
                  //       color: Color.fromARGB(255, rg - 20, rg, b),
                  //       width: 100,
                  //       height: 80,
                  //     ),
                  //   ),
                  // );
                });
              },
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> wList = [];

  @override
  Widget build(BuildContext context) {
    _maxWidth = MediaQuery.of(context).size.width;
    _maxHeight = MediaQuery.of(context).size.height;

    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        child: Stack(
          children: wList,
        ),
      ),
    );
  }
}

class DraggableWidget extends StatefulWidget {
  final Widget widget;
  final double width;
  final double height;

  DraggableWidget({@required this.widget, this.width = 100, this.height = 100});

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  int s = -1;
  int t = -1;

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
        child: widget.widget,
        feedback: Material(
          type: MaterialType.transparency,
          child: widget.widget,
        ),
        childWhenDragging: Container(width: 0, height: 0),
        onDragEnd: (details) {
          setState(() {
            s = (details.offset.dx / 10).round() * 10;
            t = (details.offset.dy / 10).round() * 10;
          });
        },
      ),
    );
  }
}
