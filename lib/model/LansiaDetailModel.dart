// To parse this JSON data, do
//
//     final lansiaDetailModel = lansiaDetailModelFromJson(jsonString);

import 'dart:convert';

LansiaDetailModel lansiaDetailModelFromJson(String str) => LansiaDetailModel.fromJson(json.decode(str));

String lansiaDetailModelToJson(LansiaDetailModel data) => json.encode(data.toJson());

class LansiaDetailModel {
    int id;
    String name;
    int umur;
    String nik;
    String alamat;
    String gender;
    DateTime createdAt;
    DateTime updatedAt;
    int desaId;
    List<PemerisaanFisikTindakan>? pemerisaanFisikTindakan;
    List<PemerisaanLab>? pemerisaanLab;
    List<P3G>? p3G;
    List<RiwayatGangguan>? riwayatGangguan;

    LansiaDetailModel({
        required this.id,
        required this.name,
        required this.umur,
        required this.nik,
        required this.alamat,
        required this.gender,
        required this.createdAt,
        required this.updatedAt,
        required this.desaId,
         this.pemerisaanFisikTindakan,
         this.pemerisaanLab,
         this.p3G,
         this.riwayatGangguan,
    });

    factory LansiaDetailModel.fromJson(Map<String, dynamic> json) => LansiaDetailModel(
        id: json["id"],
        name: json["name"],
        umur: json["umur"],
        nik: json["nik"],
        alamat: json["alamat"],
        gender: json["gender"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        desaId: json["desa_id"],
        pemerisaanFisikTindakan: List<PemerisaanFisikTindakan>.from(json["pemerisaan_fisik_tindakan"].map((x) => PemerisaanFisikTindakan.fromJson(x))),
        pemerisaanLab: List<PemerisaanLab>.from(json["pemerisaan_lab"].map((x) => PemerisaanLab.fromJson(x))),
        p3G: List<P3G>.from(json["p3g"].map((x) => P3G.fromJson(x))),
        riwayatGangguan: List<RiwayatGangguan>.from(json["riwayat_gangguan"].map((x) => RiwayatGangguan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "umur": umur,
        "nik": nik,
        "alamat": alamat,
        "gender": gender,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "desa_id": desaId,
        "pemerisaan_fisik_tindakan": List<dynamic>.from(pemerisaanFisikTindakan == null ? [] :  pemerisaanFisikTindakan!.map((x) => x.toJson())),
        "pemerisaan_lab": List<dynamic>.from(pemerisaanLab == null ? [] : pemerisaanLab!.map((x) => x.toJson())),
        "p3g": List<dynamic>.from(p3G == null ? [] : p3G!.map((x) => x.toJson())),
        "riwayat_gangguan": List<dynamic>.from(riwayatGangguan == null ? [] : riwayatGangguan!.map((x) => x.toJson())),
    };
}

class P3G {
    int id;
    DateTime tanggalPP3G;
    String tingkatKemandirian;
    String gEmosional;
    String gKognitiv;
    String pResikoMalnutrisi;
    String pResikoJatuh;
    int lansiaId;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    int desaId;
    User user;

    P3G({
        required this.id,
        required this.tanggalPP3G,
        required this.tingkatKemandirian,
        required this.gEmosional,
        required this.gKognitiv,
        required this.pResikoMalnutrisi,
        required this.pResikoJatuh,
        required this.lansiaId,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.desaId,
        required this.user,
    });

    factory P3G.fromJson(Map<String, dynamic> json) => P3G(
        id: json["id"],
        tanggalPP3G: DateTime.parse(json["tanggal_p_p3g"]),
        tingkatKemandirian: json["tingkat_kemandirian"],
        gEmosional: json["g_emosional"],
        gKognitiv: json["g_kognitiv"],
        pResikoMalnutrisi: json["p_resiko_malnutrisi"],
        pResikoJatuh: json["p_resiko_jatuh"],
        lansiaId: json["lansia_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        desaId: json["desa_id"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal_p_p3g": tanggalPP3G.toIso8601String(),
        "tingkat_kemandirian": tingkatKemandirian,
        "g_emosional": gEmosional,
        "g_kognitiv": gKognitiv,
        "p_resiko_malnutrisi": pResikoMalnutrisi,
        "p_resiko_jatuh": pResikoJatuh,
        "lansia_id": lansiaId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "desa_id": desaId,
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

class PemerisaanFisikTindakan {
    int id;
    DateTime tanggalP;
    double? beratBadan;
    int? tinggiBadan;
    double imt;
    String statusGizi;
    int? sistole;
    int? diastole;
    String? tekananDarah;
    String? lain;
    String? tataLaksana;
    String? konseling;
    String? rujuk;
    int desaId;
    int lansiaId;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    PemerisaanFisikTindakan({
        required this.id,
        required this.tanggalP,
         this.beratBadan,
         this.tinggiBadan,
        required this.imt,
        required this.statusGizi,
         this.sistole,
         this.diastole,
         this.tekananDarah,
         this.lain,
         this.tataLaksana,
         this.konseling,
         this.rujuk,
        required this.desaId,
        required this.lansiaId,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory PemerisaanFisikTindakan.fromJson(Map<String, dynamic> json) => PemerisaanFisikTindakan(
        id: json["id"],
        tanggalP: DateTime.parse(json["tanggal_p"]),
        beratBadan: json["berat_badan"]?.toDouble(),
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

class PemerisaanLab {
    int id;
    DateTime tanggalPLab;
    int kolesterol;
    int gulaDarah;
    int asamUrat;
    String statusAsamUrat;
    int hb;
    int lansiaId;
    int userId;
    int desaId;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    PemerisaanLab({
        required this.id,
        required this.tanggalPLab,
        required this.kolesterol,
        required this.gulaDarah,
        required this.asamUrat,
        required this.statusAsamUrat,
        required this.hb,
        required this.lansiaId,
        required this.userId,
        required this.desaId,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory PemerisaanLab.fromJson(Map<String, dynamic> json) => PemerisaanLab(
        id: json["id"],
        tanggalPLab: DateTime.parse(json["tanggal_p_lab"]),
        kolesterol: json["kolesterol"],
        gulaDarah: json["gula_darah"],
        asamUrat: json["asam_urat"],
        statusAsamUrat: json["status_asam_urat"],
        hb: json["hb"],
        lansiaId: json["lansia_id"],
        userId: json["user_id"],
        desaId: json["desa_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal_p_lab": tanggalPLab.toIso8601String(),
        "kolesterol": kolesterol,
        "gula_darah": gulaDarah,
        "asam_urat": asamUrat,
        "status_asam_urat": statusAsamUrat,
        "hb": hb,
        "lansia_id": lansiaId,
        "user_id": userId,
        "desa_id": desaId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class RiwayatGangguan {
    int id;
    DateTime tanggalPG;
    String gGinjal;
    String gPengelihatan;
    String gPendengaran;
    String penyuluhan;
    String pemberdayaan;
    String keterangan;
    int desaId;
    int lansiaId;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    RiwayatGangguan({
        required this.id,
        required this.tanggalPG,
        required this.gGinjal,
        required this.gPengelihatan,
        required this.gPendengaran,
        required this.penyuluhan,
        required this.pemberdayaan,
        required this.keterangan,
        required this.desaId,
        required this.lansiaId,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory RiwayatGangguan.fromJson(Map<String, dynamic> json) => RiwayatGangguan(
        id: json["id"],
        tanggalPG: DateTime.parse(json["tanggal_p_g"]),
        gGinjal: json["g_ginjal"],
        gPengelihatan: json["g_pengelihatan"],
        gPendengaran: json["g_pendengaran"],
        penyuluhan: json["penyuluhan"],
        pemberdayaan: json["pemberdayaan"],
        keterangan: json["keterangan"],
        desaId: json["desa_id"],
        lansiaId: json["lansia_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal_p_g": tanggalPG.toIso8601String(),
        "g_ginjal": gGinjal,
        "g_pengelihatan": gPengelihatan,
        "g_pendengaran": gPendengaran,
        "penyuluhan": penyuluhan,
        "pemberdayaan": pemberdayaan,
        "keterangan": keterangan,
        "desa_id": desaId,
        "lansia_id": lansiaId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}
