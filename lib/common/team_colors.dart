import 'package:flutter/material.dart';

class TeamColors {
  static final List<Team> _team = [
    Team('Mercedes', Color.fromRGBO(0, 210, 190, 1)),
    Team('Ferrari', Color.fromRGBO(220, 0, 0, 1)),
    Team('Red Bull Racing', Color.fromRGBO(6, 0, 239, 1)),
    Team('Williams', Color.fromRGBO(0, 130, 250, 1)),
    Team('Racing Point', Color.fromRGBO(245, 150, 200, 1)),
    Team('Renault', Color.fromRGBO(255, 245, 0, 1)),
    Team('AlphaTauri', Color.fromRGBO(255, 255, 255, 1)),
    Team('Haas F1 Team', Color.fromRGBO(120, 120, 120, 1)),
    Team('McLaren', Color.fromRGBO(255, 135, 0, 1)),
    Team('Alfa Romeo Racing', Color.fromRGBO(150, 0, 0, 1)),
  ];

  static Team get(int index){
    if(index == 255){
      return Team("My Team", Colors.white);
    }
    return _team[index];
  }

}

class Team {
  final String name;
  final Color color;

  Team(this.name, this.color);
}
