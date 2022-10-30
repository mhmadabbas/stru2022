// To parse this JSON data, do
//
//     final postComment = postCommentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostComment postCommentFromJson(String str) => PostComment.fromJson(json.decode(str));

String postCommentToJson(PostComment data) => json.encode(data.toJson());

class PostComment {
  PostComment({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datum> data;
  final Pagination pagination;

  factory PostComment.fromJson(Map<String, dynamic> json) => PostComment(
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
    required this.comment,
    required this.createTime,
    required this.createdBy,
    required this.updateTime,
  });

  final int id;
  final String comment;
  final CreateTime createTime;
  final CreatedBy createdBy;
  final dynamic updateTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    comment: json["comment"],
    createTime: CreateTime.fromJson(json["createTime"]),
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updateTime: json["updateTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "createTime": createTime.toJson(),
    "createdBy": createdBy.toJson(),
    "updateTime": updateTime,
  };
}

class CreateTime {
  CreateTime({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  final DateTime date;
  final int timezoneType;
  final String timezone;

  factory CreateTime.fromJson(Map<String, dynamic> json) => CreateTime(
    date: DateTime.parse(json["date"]),
    timezoneType: json["timezone_type"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "timezone_type": timezoneType,
    "timezone": timezone,
  };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String image;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
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
