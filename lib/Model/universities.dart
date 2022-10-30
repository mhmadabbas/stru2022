// To parse this JSON data, do
//
//     final getUniversities = getUniversitiesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetUniversities getUniversitiesFromJson(String str) => GetUniversities.fromJson(json.decode(str));

String getUniversitiesToJson(GetUniversities data) => json.encode(data.toJson());

class GetUniversities {
  GetUniversities({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datumun> data;
  final Pagination pagination;

  factory GetUniversities.fromJson(Map<String, dynamic> json) => GetUniversities(
    code: json["code"],
    message: json["message"],
    data: List<Datumun>.from(json["data"].map((x) => Datumun.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Datumun {
  Datumun({
    required this.id,
    required this.name,
    required this.city,
    required this.description,
    required this.logo,
    required this.category,
    required this.featured,
    required this.inCurrentUserFavorite,
  });

  final int id;
  final String name;
  final Category city;
  final String description;
  final String logo;
  final Category category;
  final int featured;
    bool inCurrentUserFavorite;

  factory Datumun.fromJson(Map<String, dynamic> json) => Datumun(
    id: json["id"],
    name: json["name"],
    city: Category.fromJson(json["city"]),
    description: json["description"],
    logo: json["logo"],
    category: Category.fromJson(json["category"]),
    featured: json["featured"],
    inCurrentUserFavorite: json["in_current_user_favorite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city": city.toJson(),
    "description": description,
    "logo": logo,
    "category": category.toJson(),
    "featured": featured,
    "in_current_user_favorite": inCurrentUserFavorite,
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
