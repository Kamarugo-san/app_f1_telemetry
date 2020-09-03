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
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              print("A");
              setState(() {
                wList.add(Cube());
              });
            },
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

  void addWidget() {
    wList.add(Cube());
  }
}

class Cube extends StatefulWidget {
  @override
  _CubeState createState() => _CubeState();
}

class _CubeState extends State<Cube> {
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
        child: Container(
          width: 50,
          height: 50,
          color: Color.fromARGB(
              255, r.nextInt(255), r.nextInt(255), r.nextInt(255)),
        ),
        feedback: Container(
          width: 50,
          height: 50,
          color: Color.fromARGB(
              255, r.nextInt(255), r.nextInt(255), r.nextInt(255)),
        ),
        childWhenDragging: Container(
          width: 0,
          height: 0,
        ),
        onDragEnd: (details) {
          setState(() {
            s = (details.offset.dx ~/ 30) * 30;
            t = (details.offset.dy ~/ 30) * 30;
          });
        },
      ),
    );
  }
}
