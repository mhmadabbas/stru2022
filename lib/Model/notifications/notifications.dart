// To parse this JSON data, do
//
//     final getnotificationsList = getnotificationsListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetnotificationsList getnotificationsListFromJson(String str) => GetnotificationsList.fromJson(json.decode(str));

String getnotificationsListToJson(GetnotificationsList data) => json.encode(data.toJson());

class GetnotificationsList {
  GetnotificationsList({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datum> data;
  final Pagination pagination;

  factory GetnotificationsList.fromJson(Map<String, dynamic> json) => GetnotificationsList(
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
    required this.title,
    required this.content,
    required this.time,
  });

  final String title;
  final String content;
  final Time time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    content: json["content"],
    time: Time.fromJson(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "time": time.toJson(),
  };
}

class Time {
  Time({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  final String date;
  final int timezoneType;
  final String timezone;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
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
