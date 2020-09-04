import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DraggableView());
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
                print("A");
                setState(() {
                  int rg = Random().nextInt(120) + 50;
                  int b = Random().nextInt(55) + 200;

                  wList.add(
                    DraggableWidget(
                      Container(
                        color: Color.fromARGB(255, rg - 20, rg, b),
                        width: 100,
                        height: 80,
                      ),
                    ),
                  );
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
  Widget widget;

  DraggableWidget(this.widget);

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  int s = -1;
  int t = -1;

  @override
  Widget build(BuildContext context) {
    if (s == -1 && t == -1) {
      s = MediaQuery.of(context).size.width ~/ 2 - 25;
      t = MediaQuery.of(context).size.height ~/ 2 - 25;
    }

    Random r = new Random();

    return Positioned(
      left: s.toDouble(),
      top: t.toDouble(),
      child: Draggable(
        child: widget.widget,
        feedback: widget.widget,
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
