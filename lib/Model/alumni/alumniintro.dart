// To parse this JSON data, do
//
//     final alumniintro = alumniintroFromJson(jsonString);

import 'dart:convert';

Alumniintro alumniintroFromJson(String str) => Alumniintro.fromJson(json.decode(str));

String alumniintroToJson(Alumniintro data) => json.encode(data.toJson());

class Alumniintro {
  Alumniintro({
    required  this.code,
    required  this.message,
    required this.data,
    required this.pagination,
  });

  int code;
  String message;
  List<Datum> data;
  Pagination pagination;

  factory Alumniintro.fromJson(Map<String, dynamic> json) => Alumniintro(
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
    required this.content,
    required this.link,
  });

  int id;
  String title;
  String content;
  String link;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "link": link,
  };
}

class Pagination {
  Pagination({
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
  });

  int currentPage;
  int totalItems;
  int itemsPerPage;

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
