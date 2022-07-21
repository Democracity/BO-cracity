// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Sondage sondageFromJson(String str) => Sondage.fromJson(json.decode(str));

String sondageToJson(Sondage data) => json.encode(data.toJson());

class Sondage {
  Sondage({
    required this.title,
    required this.numberchoices,
    required this.choices,
    required this.private,
    required this.isreported
  });


  String? title;
  int? numberchoices;
  List<dynamic?>? choices;
  bool? private;
  int? isreported;


  factory Sondage.fromJson(Map<String, dynamic> json) => Sondage(
      title: json["title"] as String?,
      numberchoices: json["numberchoices"] as int?,
      choices: json["choices"] as List<dynamic?>?,
      private: json["private"] as bool?,
      isreported: json["isreported"] as int?
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "numberchoices": numberchoices,
    "private": private,
    "choices": choices,
    "isreported": isreported,
  };
}
