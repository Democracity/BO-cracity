import 'dart:convert';

import 'package:bo_cracity/services/sondage.dart';
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
    final List<User> users = (jsonBody as List).map((user) =>
        User.fromJson(user)).toList();

    return users;
  }


  static Future<List<User>> getUsers() async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/users"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    //print(jsonBody);
    final List<User> users = (jsonBody as List).map((user) =>
        User.fromJson(user)).toList();

    return users;
  }

  static Future<List<Sondage>> getSondages() async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/allsondages"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    final List<Sondage> sondages = (jsonBody as List).map((sondage) =>
        Sondage.fromJson(sondage)).toList();
    return sondages;
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
    final List<User> users = (jsonBody as List).map((user) =>
        User.fromJson(user)).toList();
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
    final List<UserD> users = (jsonBody as List).map((userDetail) =>
        UserD.fromJson(userDetail)).toList();
    print("user detail:     $users");
    return users;
  }


  static Future<List<User>> getFavorites() async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/favorites"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }

    final jsonBody = json.decode(response.body);
    print("helllooo $jsonBody");
    final List<User> users = (jsonBody as List).map((user) =>
        User.fromJson(user)).toList();
    print("user detail:   $users");
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


  static Future<bool> login(String username, String password) async {
    final http.Response response = await http.post(
      (Uri.parse('https://democracity-api.herokuapp.com/login')),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password
      }),
    );
    var data = response.body;
    print(data);

    return response.statusCode == 200;
  }

  static Future<bool> addFavorite(String username) async {
    final http.Response response = await http.put(
      (Uri.parse('https://democracity-api.herokuapp.com/favorite/$username')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    var data = response.body;
    print(data);

    return response.statusCode == 200;
  }

  static Future<bool> banUser(String username) async {
    final http.Response response = await http.put(
      (Uri.parse('https://democracity-api.herokuapp.com/banuser/$username')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    var data = response.body;
    print(data);

    return response.statusCode == 200;
  }

  static Future<bool> unbanUser(String username) async {
    final http.Response response = await http.put(
      (Uri.parse('https://democracity-api.herokuapp.com/unbanuser/$username')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    var data = response.body;
    print(data);

    return response.statusCode == 200;
  }

}