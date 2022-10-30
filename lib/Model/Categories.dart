// To parse this JSON data, do
//
//     final getcat = getcatFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getcat getcatFromJson(String str) => Getcat.fromJson(json.decode(str));

String getcatToJson(Getcat data) => json.encode(data.toJson());

class Getcat {
  Getcat({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final List<Datum>? data;

  factory Getcat.fromJson(Map<String, dynamic> json) => Getcat(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
