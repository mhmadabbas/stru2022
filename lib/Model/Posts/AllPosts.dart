// To parse this JSON data, do
//
//     final getAllPostsList = getAllPostsListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAllPostsList getAllPostsListFromJson(String str) => GetAllPostsList.fromJson(json.decode(str));

String getAllPostsListToJson(GetAllPostsList data) => json.encode(data.toJson());

class GetAllPostsList {
  GetAllPostsList({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datum> data;
  final Pagination pagination;

  factory GetAllPostsList.fromJson(Map<String, dynamic> json) => GetAllPostsList(
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
    required this.createdBy,
    required this.publishTime,
    required this.likes,
    required this.comments,
    required this.media,
    required this.published,
    required this.likedByCurrentUser,
    required this.featured,
    required this.content,

  });

  final int id;
  final String title;
  final String createdBy;
  final PublishTime publishTime;
   int likes;
   int comments;
  final String media;
  final bool published;
   bool likedByCurrentUser;
  final int featured;
  final String content;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    createdBy: json["createdBy"],
    publishTime: PublishTime.fromJson(json["publishTime"]),
    likes: json["likes"],
    comments:json["comments"],
    media: json["media"],
    published: json["published"],
    likedByCurrentUser: json["liked_by_current_user"],
    featured: json["featured"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "createdBy": createdBy,
    "publishTime": publishTime.toJson(),
    "likes": likes,
    "media": media,
    "published": published,
    "liked_by_current_user": likedByCurrentUser,
    "featured": featured,
    "content": content,
  };
}

class PublishTime {
  PublishTime({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  final String date;
  final int timezoneType;
  final String timezone;

  factory PublishTime.fromJson(Map<String, dynamic> json) => PublishTime(
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
