// To parse this JSON data, do
//
//     final pemeriksaanFisikModel = pemeriksaanFisikModelFromJson(jsonString);

import 'dart:convert';

List<PemeriksaanFisikModel> pemeriksaanFisikModelFromJson(String str) => List<PemeriksaanFisikModel>.from(json.decode(str).map((x) => PemeriksaanFisikModel.fromJson(x)));

String pemeriksaanFisikModelToJson(List<PemeriksaanFisikModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PemeriksaanFisikModel {
    int id;
    DateTime tanggalP;
    int beratBadan;
    int tinggiBadan;
    double imt;
    String statusGizi;
    int sistole;
    int diastole;
    String tekananDarah;
    String lain;
    String tataLaksana;
    String konseling;
    String rujuk;
    int desaId;
    int lansiaId;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    PemeriksaanFisikModel({
        required this.id,
        required this.tanggalP,
        required this.beratBadan,
        required this.tinggiBadan,
        required this.imt,
        required this.statusGizi,
        required this.sistole,
        required this.diastole,
        required this.tekananDarah,
        required this.lain,
        required this.tataLaksana,
        required this.konseling,
        required this.rujuk,
        required this.desaId,
        required this.lansiaId,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory PemeriksaanFisikModel.fromJson(Map<String, dynamic> json) => PemeriksaanFisikModel(
        id: json["id"],
        tanggalP: DateTime.parse(json["tanggal_p"]),
        beratBadan: json["berat_badan"],
        tinggiBadan: json["tinggi_badan"],
        imt: json["imt"]?.toDouble(),
        statusGizi: json["status_gizi"],
        sistole: json["sistole"],
        diastole: json["diastole"],
        tekananDarah: json["tekanan_darah"],
        lain: json["lain"],
        tataLaksana: json["tata_laksana"],
        konseling: json["konseling"],
        rujuk: json["rujuk"],
        desaId: json["desa_id"],
        lansiaId: json["lansia_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal_p": tanggalP.toIso8601String(),
        "berat_badan": beratBadan,
        "tinggi_badan": tinggiBadan,
        "imt": imt,
        "status_gizi": statusGizi,
        "sistole": sistole,
        "diastole": diastole,
        "tekanan_darah": tekananDarah,
        "lain": lain,
        "tata_laksana": tataLaksana,
        "konseling": konseling,
        "rujuk": rujuk,
        "desa_id": desaId,
        "lansia_id": lansiaId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class User {
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

    User({
        required this.id,
        required this.userName,
        required this.name,
        required this.email,
        required this.userType,
        required this.emailVerifiedAt,
        required this.imageUrl,
        required this.nip,
        required this.gender,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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
