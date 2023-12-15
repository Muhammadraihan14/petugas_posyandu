import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:posyandu_petugas/model/DesaModel.dart';
import 'package:posyandu_petugas/model/DetailPmModel.dart';
import 'package:posyandu_petugas/model/LansiaDetailModel.dart';
import 'package:posyandu_petugas/routes/route_names.dart';
import 'package:posyandu_petugas/utils/app_exceptions.dart';
// import 'package:posyandu_petugas/utils/app_exceptions.dart';
import 'package:posyandu_petugas/utils/constans.dart';
import 'package:posyandu_petugas/utils/dialog_helper.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PemeriksaanControler extends GetxController {
  @override
  void onInit() {
    // Get called when controller is created
    // onConnectPressed();
    
    super.onInit();
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
    try {
      final res = await http.get(Uri.parse(route), headers: header);
      final data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];

      return LansiaDetailModel.fromJson(data);
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

  Future<DetailPmModel> getPemeriksaanDetail({required id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/pm/$id";
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    // try {
      final res = await http.get(Uri.parse(route), headers: header);
      final data = (jsonDecode(res.body) as Map<String, dynamic>)["data"];
      print(res.body);

      return DetailPmModel.fromJson(data);
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

  Future postPemeriksaan(
      {required String userid,
      required String desaid,
      required String lansiaid,
      required String tanggal,
      required String tinggibadan,
      required String beratbadan,
      required String sistole,
      required String diastole,
      required String tatalaksana,
      required String konseling,
      required String lain,
      required String rujuk}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/pm/save";
    var header = {
      // "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    // print(desa);
    try {
      final res = await http.post(
        Uri.parse(route),
        body: ({
          'user_id': userid,
          'desa_id': desaid,
          'lansia_id': lansiaid,
          'tanggal_p': tanggal,
          'tinggi_badan': tinggibadan,
          'berat_badan': beratbadan,
          'sistole': sistole,
          'diastole': diastole,
          'lain': lain,
          'tata_laksana': tatalaksana,
          'konseling': konseling,
          'rujuk': rujuk,
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
        Get.offAndToNamed(RouteName.pageNavigasi);
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

  deletePemeriksaan({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    String route = "${AppConfig.apiEndpoint}/pm/delete/$id";
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

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  // Future<void>alatPengkuran()async {
  //   Pusher.ins
  // }

  void onConnectPressed() async {
    try {
      await pusher.init(
        apiKey: AppConfig.key,
        cluster: AppConfig.cluster,
        onConnectionStateChange: onConnectionStateChange,
        onEvent: onEvent,
      );
      await pusher.subscribe(channelName: AppConfig.channelName);
      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection: $currentState");
  }

  void onEvent(PusherEvent event) {
    log("onEvent: ${AppConfig.eventName}");
    var dataPengukuran = jsonDecode(event.data);
    print(dataPengukuran);
    var tinggi = dataPengukuran['tinggi'];
    var berat = dataPengukuran['berat'];
    print(tinggi);
    print(berat);
    if (dataPengukuran['tinggi'] != null) {

    } else {
    }
  }





}
