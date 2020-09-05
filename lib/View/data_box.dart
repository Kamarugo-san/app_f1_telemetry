import 'package:flutter/material.dart';

class DataBox extends StatefulWidget {
  static const double width = 170;
  static const double height = 120;

  final Text header;
  final Text t0_0;
  final Text t0_1;
  final Text t1_0;
  final Text t1_1;

  DataBox({
    this.header,
    this.t0_0,
    this.t0_1,
    this.t1_0,
    this.t1_1,
  });

  _DataBoxState createState() => _DataBoxState();
}

class _DataBoxState extends State<DataBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: DataBox.width,
      height: DataBox.height,
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: widget.header,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: widget.t0_0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: widget.t0_1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: widget.t1_0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: widget.t1_1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
