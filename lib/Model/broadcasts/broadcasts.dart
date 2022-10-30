// To parse this JSON data, do
//
//     final broadcasts = broadcastsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Broadcasts broadcastsFromJson(String str) => Broadcasts.fromJson(json.decode(str));

String broadcastsToJson(Broadcasts data) => json.encode(data.toJson());

class Broadcasts {
  Broadcasts({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datum> data;
  final Pagination pagination;

  factory Broadcasts.fromJson(Map<String, dynamic> json) => Broadcasts(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.broadcastTime,
    required this.link,
  });

  final int id;
  final String title;
  final String description;
  final BroadcastTime broadcastTime;
  final String link;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    broadcastTime: BroadcastTime.fromJson(json["broadcastTime"]),
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "broadcastTime": broadcastTime.toJson(),
    "link": link,
  };
}

class BroadcastTime {
  BroadcastTime({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  final String date;
  final int timezoneType;
  final String timezone;

  factory BroadcastTime.fromJson(Map<String, dynamic> json) => BroadcastTime(
    date: json["date"],
    timezoneType: json["timezone_type"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "timezone_type": timezoneType,
    "timezone": timezone,
  };
}

class Pagination {
  Pagination({
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
  });

  final int currentPage;
  final int totalItems;
  final int itemsPerPage;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    totalItems: json["total_items"],
    itemsPerPage: json["items_per_page"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "total_items": totalItems,
    "items_per_page": itemsPerPage,
  };
}
