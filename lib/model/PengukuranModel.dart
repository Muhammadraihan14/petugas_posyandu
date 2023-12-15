// To parse this JSON data, do
//
//     final pengukuranModel = pengukuranModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:pusher_channels_flutter/pusher-js/core/connection/protocol/message-types.dart';

PengukuranModel pengukuranModelFromJson(String str) =>
    PengukuranModel.fromJson(json.decode(str));
String pengukuranModelToJson(PengukuranModel data) =>
    json.encode(data.toJson());

class PengukuranModel extends ChangeNotifier {
  String? tinggi;
  String? berat;

  PengukuranModel({
    this.tinggi,
    this.berat,
  });
  factory PengukuranModel.fromJson(Map<String, dynamic> json) =>
      PengukuranModel(
        tinggi: json["tinggi"],
        berat: json["berat"],
      );

  Map<String, dynamic> toJson() => {
        "tinggi": tinggi,
        "berat": berat,
      };

}
