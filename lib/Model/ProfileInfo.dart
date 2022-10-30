// To parse this JSON data, do
//
//     final profileInfo = profileInfoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileInfo profileInfoFromJson(String str) => ProfileInfo.fromJson(json.decode(str));

String profileInfoToJson(ProfileInfo data) => json.encode(data.toJson());

class ProfileInfo {
  ProfileInfo({
    required this.user,
  });

  final User user;

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.mobile,
    required this.whatsapp,
    required this.type,
    required this.status,
    required this.activeNow,
    required this.verified,
    required this.country,
    required this.gender,
    required this.birthdate
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String image;
  final String? country;
  final int? gender;
  final String? birthdate;
  final dynamic mobile;
  final dynamic whatsapp;
  final int type;
  final bool status;
  final bool activeNow;
  final bool verified;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
    mobile: json["mobile"],
    whatsapp: json["whatsapp"],
    country: json["country"],
    gender: json["gender"],
    birthdate: json["birthdate"],
    type: json["type"],
    status: json["status"],
    activeNow: json["activeNow"],
    verified: json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
    "mobile": mobile,
    "whatsapp": whatsapp,
    "country": country,
    "gender": gender,
    "birthdate": birthdate,
    "type": type,
    "status": status,
    "activeNow": activeNow,
    "verified": verified,
  };
}
