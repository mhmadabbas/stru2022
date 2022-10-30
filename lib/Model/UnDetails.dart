// To parse this JSON data, do
//
//     final unDetails = unDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UnDetails unDetailsFromJson(String str) => UnDetails.fromJson(json.decode(str));

String unDetailsToJson(UnDetails data) => json.encode(data.toJson());

class UnDetails {
  UnDetails({
    required this.code,
    required this.message,
    required this.data,
  });

  final int code;
  final String message;
  final Data data;

  factory UnDetails.fromJson(Map<String, dynamic> json) => UnDetails(
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
    required this.name,
    required this.city,
    required this.description,
    required this.logo,
    required this.photo,
    required this.content,
    required this.phone,
    required this.email,
    required this.website,
    required this.category,
    required this.media,
    required this.videos,
    required this.featured,
    required this.inCurrentUserFavorite,
  });

  final int id;
  final String name;
  final Category city;
  final String description;
  final String logo;
  final String photo;
  final String content;
  final String phone;
  final String email;
  final String website;
  final Category category;
  final List<Media> media;
  final List<Video> videos;
  final int featured;
  final bool inCurrentUserFavorite;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    city: Category.fromJson(json["city"]),
    description: json["description"],
    logo: json["logo"],
    photo: json["photo"],
    content: json["content"],
    phone: json["phone"],
    email: json["email"],
    website: json["website"],
    category: Category.fromJson(json["category"]),
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    featured: json["featured"],
    inCurrentUserFavorite: json["in_current_user_favorite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city": city.toJson(),
    "description": description,
    "logo": logo,
    "photo": photo,
    "content": content,
    "phone": phone,
    "email": email,
    "website": website,
    "category": category.toJson(),
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
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


class Media {
  Media({
    required this.path,
    required this.id,
  });

  final String path;
  final int id;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    path: json["path"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "id": id,
  };
}

class Video {
  Video({
    required this.id,
    required this.link,
  });

  final int id;
  final String link;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
  };
}

