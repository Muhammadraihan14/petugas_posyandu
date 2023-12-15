// ignore: file_names
import 'dart:convert';
import 'dart:io';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:posyandu_petugas/model/DesaModel.dart';
import 'package:posyandu_petugas/model/LansiaDetailModel.dart';
import 'package:posyandu_petugas/model/LansiaModel.dart';
import 'package:posyandu_petugas/model/ProfileModel.dart';
import 'package:posyandu_petugas/routes/route_names.dart';
import 'package:posyandu_petugas/utils/app_exceptions.dart';
// import 'package:posyandu_petugas/utils/app_exceptions.dart';
import 'package:posyandu_petugas/utils/constans.dart';
import 'package:posyandu_petugas/utils/dialog_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LansiaControler extends GetxController {
  Future<List<LansiaModel>> getLansia({required query}) async {
    List<LansiaModel> result = [];
    var listdata = [];

    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    // String route = "${AppConfig.apiEndpoint}/member/blogs/$id";
    String route = "${AppConfig.apiEndpoint}/search?name=$query";

    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final res = await http.get(Uri.parse(route), headers: header);
      final body = jsonDecode(res.body);
      final data =
          (jsonDecode(res.body) as Map<String, dynamic>)['data']['data'];
      listdata = data as List<dynamic>;
      if (body['status'] == "success") {
        result = listdata.map((e) => LansiaModel.fromJson(e)).toList();
        // ignore: unnecessary_null_comparison
        if (query != null) {
          result = result
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          print(result.length);
        } else {
          return [];
        }
        return listdata.map((e) => LansiaModel.fromJson(e)).toList();
      }
      return listdata.map((e) => LansiaModel.fromJson(e)).toList();
    } on SocketException {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.toString());
    }
    //  }
  }

  Future<LansiaDetailModel> getLansiaDetail({required id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/lansia/$id";
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    // try {
    final res = await http.get(Uri.parse(route), headers: header);
    final data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];
    return LansiaDetailModel.fromJson(data);
    // } on SocketException {
    //   throw NoInternetException('No Internet');
    // } on HttpException {
    //   throw NoServiceFoundException('No Service Found');
    // } on FormatException {
    //   throw InvalidFormatException('Invalid Data Format');
    // } catch (e) {
    //   throw UnknownException(e.toString());
    // }
  }

  Future<ProfileModel> getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/me";
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final res = await http.get(Uri.parse(route), headers: header);
      final data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];
      return ProfileModel.fromJson(data);
    } on SocketException {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Future<List<DesaModel>> getDesa() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/desa";
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final res = await http.get(Uri.parse(route), headers: header);
      final data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];
      // listdata = data as List<dynamic>;
      return data.map((e) => DesaModel.fromJson(e)).toList();
    } on SocketException {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Future postLansia(
      {required String nama,
      required String umur,
      required String nik,
      required String alamat,
      required String gender,
      required String desa}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/lansia/save";
    var header = {
      // "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    print(desa);
    try {
      final res = await http.post(
        Uri.parse(route),
        body: ({
          "name": nama,
          "umur": umur,
          "nik": nik,
          "alamat": alamat,
          "gender": gender,
          "desa_id": desa,
        }),
        headers: header,
      );
      final body = jsonDecode(res.body);
      print(body);

      if (body['status'] == 'success') {
        DialogHelper.hideLoading();
        Get.back();
        Get.snackbar(
          "Alert",
          "Berhasil Simpan Data",
          backgroundColor: Colors.green[300],
          icon: const Icon(Icons.check),
        );
      } else {
        DialogHelper.hideLoading();
        Get.snackbar(
          "Alert",
          "Gagal Simpan Data",
          backgroundColor: Colors.red[300],
          icon: const Icon(Icons.cancel),
        );
      }
    } catch (e) {
      print("Error$e");
    }
  }

  Future postLansiaEdit({
    required String nama,
    required String umur,
    required String nik,
    required String alamat,
    required String gender,
    required String desa,
    required String id,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/lansia/save";
    var header = {
      // "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    print(alamat);
    try {
      final res = await http.post(
        Uri.parse(route),
        body: ({
          "name": nama,
          "umur": umur,
          "nik": nik,
          "alamat": alamat,
          "gender": gender,
          "desa_id": desa,
          "id": id,
        }),
        headers: header,
      );
      final body = jsonDecode(res.body);
      print(body);

      if (body['status'] == 'success') {
        DialogHelper.hideLoading();
        Get.back();
        Get.snackbar(
          "Alert",
          "Berhasil Edit Data",
          backgroundColor: Colors.green[300],
          icon: const Icon(Icons.check),
        );
      } else {
        DialogHelper.hideLoading();

        Get.snackbar(
          "Alert",
          "Gagal Edit Data",
          backgroundColor: Colors.red[300],
          icon: const Icon(Icons.cancel),
        );
      }
    } catch (e) {
      print("Error$e");
    }
  }

  deleteLansia({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/lansia/delete/$id";
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final res = await http.get(Uri.parse(route), headers: header);
      // final data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];
      final body = jsonDecode(res.body);
      print("DDDDD");
      if (body['status'] == 'success') {
        Get.offAndToNamed(RouteName.pageNavigasi);
        Get.snackbar(
          "Alert",
          "Berhasil Delete Data",
          backgroundColor: Colors.green[300],
          icon: const Icon(Icons.check),
        );
      } else {
        Get.snackbar(
          "Alert",
          "Gagal Delete Data",
          backgroundColor: Colors.red[300],
          icon: const Icon(Icons.close),
        );
      }
    } on SocketException {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  cekDesa({required int id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/desa";
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    final res = await http.get(Uri.parse(route), headers: header);
    final data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];
    var ldata = data as List<dynamic>;
    print(ldata);
     int idDesa = id - 1;
    List<String> stringList = ldata.map((item) => item.toString()).toList();
    // var paidorder = stringList.where((c) => c['status'] == 'canceled');
    var desaSelected = stringList[idDesa];
    // String Something = string.Join(",", MyList);

    // string.Join(",", MyList);
    String desaResult = desaSelected;
    print("desaResult");
    print(desaResult);
    return desaResult.toString();
   
  }
}
