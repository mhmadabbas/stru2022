// To parse this JSON data, do
//
//     final getNewsDetails = getNewsDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetNewsDetails getNewsDetailsFromJson(String str) => GetNewsDetails.fromJson(json.decode(str));

String getNewsDetailsToJson(GetNewsDetails data) => json.encode(data.toJson());

class GetNewsDetails {
  GetNewsDetails({
    required this.code,
    required this.message,
    required this.data,
  });

  final int code;
  final String message;
  final Data data;

  factory GetNewsDetails.fromJson(Map<String, dynamic> json) => GetNewsDetails(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.description,
    required this.creator,
    required this.category,
    required this.content,
    required this.publishTime,
    required this.media,
    required this.views,
    required this.featured,
  });

  final int id;
  final String title;
  final String description;
  final String creator;
  final Category category;
  final String content;
  final PublishTime publishTime;
  final String media;
  final int views;
  final int featured;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    creator: json["creator"],
    category: Category.fromJson(json["category"]),
    content: json["content"],
    publishTime: PublishTime.fromJson(json["publishTime"]),
    media: json["media"],
    views: json["views"],
    featured: json["featured"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "creator": creator,
    "category": category.toJson(),
    "content": content,
    "publishTime": publishTime.toJson(),
    "media": media,
    "views": views,
    "featured": featured,
  };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
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
