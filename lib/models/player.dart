import 'dart:convert';

class Player {
  final String id;
  final String name;
  final String number;
  final String postion;
  
  
  const Player(this.id, this.name, this.number, this.postion);
  
  /*factory Player.fromJson(json) {
    if (json == null) {
      return null;
    }
    else {
      print(json);
      final Map bodyJson = JSON.decode(json);
      return new Player(bodyJson['person']['id'], bodyJson['person']['fullName'], bodyJson['jerseyNumber'], bodyJson['postion']['name']);
    }
  }*/

  Player.fromJson (Map json)
    : id = json['jerseyNumber'],
      name = json['jerseyNumber'],
      number = json['jerseyNumber'],
      postion = json['jerseyNumber'];
}