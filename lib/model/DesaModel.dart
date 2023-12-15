// To parse this JSON data, do
//
//     final desaModel = desaModelFromJson(jsonString);

import 'dart:convert';

List<DesaModel> desaModelFromJson(String str) => List<DesaModel>.from(json.decode(str).map((x) => DesaModel.fromJson(x)));

String desaModelToJson(List<DesaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DesaModel {
    int id;
    String name;
    String latitude;
    String longitude;
    DateTime createdAt;
    DateTime updatedAt;

    DesaModel({
        required this.id,
        required this.name,
        required this.latitude,
        required this.longitude,
        required this.createdAt,
        required this.updatedAt,
    });

    factory DesaModel.fromJson(Map<String, dynamic> json) => DesaModel(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
