import 'package:flutter/material.dart';

class Lights extends StatelessWidget {
  static const double width = 500;
  static const double height = 50;
  static const double padding = 2;

  static const List<int> lColorsType = [5, 5, 5];

  static const List<int> lRed = [240, 0, 0];
  static const List<int> lBlue = [0, 0, 240];
  static const List<int> lGreen = [0, 240, 0];
  static const List<int> lPurple = [150, 0, 240];
  static const List<int> lYellow = [240, 200, 0];

  final int _revLightsPercent;

  Lights(this._revLightsPercent);

  @override
  Widget build(BuildContext context) {
    List<Widget> l = [];

    double lVal = (_revLightsPercent / 100);
    int cont = 0;

    for (int i = 0; i < lColorsType.length; i++) {
      for (int j = 0; j < lColorsType[i]; j++) {
        double power = (lVal > cont / getLightLength()) ? 1 : 0.2;

        List<int> color = (i == 0)
            ? lGreen
            : (i == 1) ? lRed : (i == 2) ? lPurple : (i == 3) ? lBlue : lYellow;

        l.add(RevLight(color, power));
        cont++;
      }
    }

    return Container(
      width: width,
      height: height,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: l,
      ),
    );
  }

  static getLightLength() {
    return Lights.lColorsType.reduce((a, b) => a + b);
  }
}

class RevLight extends StatelessWidget {
  final List<int> lColor;
  final double power;

  RevLight(this.lColor, this.power);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Lights.padding),
      child: Container(
        width: Lights.width / Lights.getLightLength() - Lights.padding * 2,
        height: Lights.width / Lights.getLightLength() - Lights.padding * 2,
        decoration: new BoxDecoration(
          color: Color.fromARGB(
            255,
            (lColor[0] * power).round(),
            (lColor[1] * power).round(),
            (lColor[2] * power).round(),
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
