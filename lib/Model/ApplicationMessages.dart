// To parse this JSON data, do
//
//     final applicationMessages = applicationMessagesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApplicationMessages applicationMessagesFromJson(String str) => ApplicationMessages.fromJson(json.decode(str));

String applicationMessagesToJson(ApplicationMessages data) => json.encode(data.toJson());

class ApplicationMessages {
  ApplicationMessages({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datum> data;
  final Pagination pagination;

  factory ApplicationMessages.fromJson(Map<String, dynamic> json) => ApplicationMessages(
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
    required this.message,
    required this.sender,
    required this.createTime,
  });

  final int id;
  final String message;
  final String sender;
  final CreateTime createTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    message: json["message"],
    sender: json["sender"],
    createTime: CreateTime.fromJson(json["createTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "sender": sender,
    "createTime": createTime.toJson(),
  };
}

class CreateTime {
  CreateTime({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  final String date;
  final int timezoneType;
  final String timezone;

  factory CreateTime.fromJson(Map<String, dynamic> json) => CreateTime(
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
