import 'dart:convert';

import 'package:bo_cracity/services/user.dart';
import 'package:bo_cracity/services/user_detail.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<User>> getiosUsers() async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/androidusers"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    //print(jsonBody);
    final List<User> users = (jsonBody as List).map((user) => User.fromJson(user)).toList();

    return users;
  }


  static Future<List<User>> getAndroidUsers() async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/iosusers"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    //print(jsonBody);
    final List<User> users = (jsonBody as List).map((user) => User.fromJson(user)).toList();
    //print ("HELLO    $users" );
    return users;
  }


  static Future<List<UserD>> getUserDetail(String username) async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/users/$username"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    print("helllooo $jsonBody");
    final List<UserD> users = (jsonBody as List).map((userDetail) => UserD.fromJson(userDetail)).toList();
    print ("user detail:     $users" );
    return users;
  }


  static Future<List> getUserCount() async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/count"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    //print(jsonBody);
    final List userCount = (jsonBody as List);
    return userCount;
  }
}
