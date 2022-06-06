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
  });

  String username;
  String password;
  String mail;
  int role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    password: json["password"],
    mail: json["mail"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "mail": mail,
    "role": role,
  };
}
