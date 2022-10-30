// To parse this JSON data, do
//
//     final getSubCorseList = getSubCorseListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSubCorseList getSubCorseListFromJson(String str) => GetSubCorseList.fromJson(json.decode(str));

String getSubCorseListToJson(GetSubCorseList data) => json.encode(data.toJson());

class GetSubCorseList {
  GetSubCorseList({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datum> data;
  final Pagination pagination;

  factory GetSubCorseList.fromJson(Map<String, dynamic> json) => GetSubCorseList(
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
    required this.name,
    required this.content,
    required this.degree,
    required this.university,
    required this.course,
    required this.language,
    required this.level,
    required this.fees,
    required this.featured,
    required this.inCurrentUserFavorite,
  });

  final int id;
  final String name;
  final String content;
  final Degree degree;
  final Course university;
  final Course course;
  final String language;
  final int level;
  final int fees;
  final int featured;
   bool inCurrentUserFavorite;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    content: json["content"],
    degree: Degree.fromJson(json["degree"]),
    university: Course.fromJson(json["university"]),
    course: Course.fromJson(json["course"]),
    language: json["language"],
    level: json["level"],
    fees: json["fees"],
    featured: json["featured"],
    inCurrentUserFavorite: json["in_current_user_favorite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "content": content,
    "degree": degree.toJson(),
    "university": university.toJson(),
    "course": course.toJson(),
    "language": language,
    "level": level,
    "fees": fees,
    "featured": featured,
    "in_current_user_favorite": inCurrentUserFavorite,
  };
}

class Course {
  Course({
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
  final bool inCurrentUserFavorite;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
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

class Degree {
  Degree({
    required this.id,
    required this.name,
    required this.icon,
  });

  final int id;
  final String name;
  final String icon;

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
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
