import 'dart:convert';

import 'package:bo_cracity/services/user.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<User>> getUsers() async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/users"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    print(jsonBody);
    final List<User> users = (jsonBody as List).map((user) => User.fromJson(user)).toList();

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
    print(jsonBody);
    final List userCount = (jsonBody as List);

    return userCount;
  }
}
