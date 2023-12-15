// To parse this JSON data, do
//
//     final detailPmModel = detailPmModelFromJson(jsonString);

import 'dart:convert';

DetailPmModel detailPmModelFromJson(String str) => DetailPmModel.fromJson(json.decode(str));

String detailPmModelToJson(DetailPmModel data) => json.encode(data.toJson());

class DetailPmModel {
    int id;
    DateTime? tanggalP;
    double? beratBadan;
    int? tinggiBadan;
    double? imt;
    String? statusGizi;
    String? sistole;
    String? diastole;
    String? tekananDarah;
    String? lain;
    String? tataLaksana;
    String? konseling;
    String? rujuk;
    int? desaId;
    int? lansiaId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;

    DetailPmModel({
        required this.id,
         this.tanggalP,
         this.beratBadan,
         this.tinggiBadan,
         this.imt,
         this.statusGizi,
         this.sistole,
         this.diastole,
         this.tekananDarah,
         this.lain,
         this.tataLaksana,
         this.konseling,
         this.rujuk,
         this.desaId,
         this.lansiaId,
         this.userId,
         this.createdAt,
         this.updatedAt,
    });

    factory DetailPmModel.fromJson(Map<String, dynamic> json) => DetailPmModel(
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
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal_p": tanggalP?.toIso8601String(),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
