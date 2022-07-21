// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.username,
    required this.password,
    required this.mail,
    required this.role,
    required this.region,
    required this.points,
    required this.sondageansweredid,
    required this.lastsondagecreated,
    required this.isbanned

  });

  String? username;
  String? password;
  String? mail;
  int role;
  String? region;
  int points;
  List<dynamic?>? sondageansweredid;
  String? lastsondagecreated;
  bool isbanned;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"] as String?,
    password: json["password"] as String?,
    mail: json["mail"] as String?,
    role: json["role"] as int,
    region: json["region"] as String?,
    points: json["points"] as int,
    sondageansweredid: json["sondageansweredid"] as List<dynamic?>?,
    lastsondagecreated: json["lastsondagecreated"] as String?,
    isbanned: json["isbanned"] as bool,
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "mail": mail,
    "role": role,
    "region": region,
    "points": points,
    "sondageansweredid": sondageansweredid,
    "lastsondagecreated": lastsondagecreated,
    "isbanned": isbanned
  };
}
