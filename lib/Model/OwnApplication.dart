// To parse this JSON data, do
//
//     final ownApplication = ownApplicationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OwnApplication ownApplicationFromJson(String str) => OwnApplication.fromJson(json.decode(str));

String ownApplicationToJson(OwnApplication data) => json.encode(data.toJson());

class OwnApplication {
  OwnApplication({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  final int code;
  final String message;
  final List<Datum> data;
  final Pagination pagination;

  factory OwnApplication.fromJson(Map<String, dynamic> json) => OwnApplication(
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
    required this.subCourse,
    required this.createTime,
    required this.updateTime,
    required this.status,
    required this.documents,
  });

  final int id;
  final SubCourse subCourse;
  final CreateTime createTime;
  final dynamic updateTime;
  final int status;
  final List<Document> documents;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    subCourse: SubCourse.fromJson(json["sub_course"]),
    createTime: CreateTime.fromJson(json["create_time"]),
    updateTime: json["update_time"],
    status: json["status"],
    documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sub_course": subCourse.toJson(),
    "create_time": createTime.toJson(),
    "update_time": updateTime,
    "status": status,
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
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

class Document {
  Document({
    required this.path,
    required this.type,
    required this.id,
  });

  final String path;
  final int type;
  final int id;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    path: json["path"],
    type: json["type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "type": type,
    "id": id,
  };
}

class SubCourse {
  SubCourse({
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
  final bool inCurrentUserFavorite;

  factory SubCourse.fromJson(Map<String, dynamic> json) => SubCourse(
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
