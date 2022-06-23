// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserD userFromJson(String str) => UserD.fromJson(json.decode(str));

String userToJson(UserD data) => json.encode(data.toJson());

class UserD {
  UserD({
    required this.username,
    required this.password,
    required this.mail,
    required this.role,
    required this.sondageansweredid,
    required this.id,
    required this.favorite
  });

  String username;
  String password;
  String mail;
  int role;
  List? sondageansweredid;
  int id;
  bool favorite;

  factory UserD.fromJson(Map<String, dynamic> json) => UserD(
    username: json["username"] as String,
    password: json["password"] as String,
    mail: json["mail"] as String,
    role: json["role"] as int,
    sondageansweredid: json["sondageansweredid"] as List?,
    id: json["Id"] as int,
    favorite: json ["favorite"] as bool,

  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "mail": mail,
    "role": role,
    "sondageansweredid": sondageansweredid,
    "Id": id,
    "favorite": favorite,
  };
}
