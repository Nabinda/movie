import 'package:flutter/cupertino.dart';

class Person{
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;
  Person({
    @required this.id,
    @required this.popularity,
    @required this.name,
    @required this.profileImg,
    @required this.known,

  });
  Person.fromJson(Map<String,dynamic> json):
        id =json["id"],
        popularity =json["popularity"],
        name =json["name"],
        profileImg =json["profile_path"],
        known =json["known_for_department"];

}
