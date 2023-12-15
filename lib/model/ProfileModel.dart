// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int id;
  String userName;
  String name;
  String email;
  String userType;
  dynamic emailVerifiedAt;
  String imageUrl;
  String nip;
  String gender;
  DateTime createdAt;
  DateTime updatedAt;

  ProfileModel({
    required this.id,
    required this.userName,
    required this.name,
    required this.email,
    required this.userType,
    this.emailVerifiedAt,
    required this.imageUrl,
    required this.nip,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        userName: json["user_name"],
        name: json["name"],
        email: json["email"],
        userType: json["user_type"],
        emailVerifiedAt: json["email_verified_at"],
        imageUrl: json["image_url"],
        nip: json["nip"],
        gender: json["gender"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "name": name,
        "email": email,
        "user_type": userType,
        "email_verified_at": emailVerifiedAt,
        "image_url": imageUrl,
        "nip": nip,
        "gender": gender,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
