// To parse this JSON data, do
//
//     final unCategores = unCategoresFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UnCategores unCategoresFromJson(String str) => UnCategores.fromJson(json.decode(str));

String unCategoresToJson(UnCategores data) => json.encode(data.toJson());

class UnCategores {
  UnCategores({
    required this.code,
    required this.message,
    required this.data,
  });

  final int code;
  final String message;
  final List<Datumcu> data;

  factory UnCategores.fromJson(Map<String, dynamic> json) => UnCategores(
    code: json["code"],
    message: json["message"],
    data: List<Datumcu>.from(json["data"].map((x) => Datumcu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datumcu {
  Datumcu({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Datumcu.fromJson(Map<String, dynamic> json) => Datumcu(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
