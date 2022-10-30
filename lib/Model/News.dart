// To parse this JSON data, do
//
//     final getNews = getNewsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetNews getNewsFromJson(String str) => GetNews.fromJson(json.decode(str));

String getNewsToJson(GetNews data) => json.encode(data.toJson());

class GetNews {
  GetNews({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datumn> data;
  final Pagination pagination;

  factory GetNews.fromJson(Map<String, dynamic> json) => GetNews(
    code: json["code"],
    message: json["message"],
    data: List<Datumn>.from(json["data"].map((x) => Datumn.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Datumn {
  Datumn({
    required this.id,
    required this.title,
    required this.description,
    required this.creator,
    required this.category,
    required this.media,
    required this.views,
    required this.featured,
  });

  final int id;
  final String title;
  final String description;
  final String creator;
  final Category category;
  final String media;
  final int views;
  final int featured;

  factory Datumn.fromJson(Map<String, dynamic> json) => Datumn(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    creator: json["creator"],
    category: Category.fromJson(json["category"]),
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
