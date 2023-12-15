import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posyandu_petugas/utils/constans.dart';

class DialogHelper {
  static void showErroDialog(
      {String? title = 'Error', String? deskription = 'Something wrong'}) {
    Get.dialog(Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? "",
            style: styleText(blackColor, 20,FontWeight.bold, TextDecoration.none),
          ),
          Text(
            deskription ?? '',
            style: styleText(blackColor, 15, FontWeight.normal, TextDecoration.none),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Ok"),
          )
        ],
      ),
    ));
  }

  static void showloading([String? message]) {
    Get.dialog(Dialog(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(message ?? "Loading...")
            ],
          )),
    ));
  }

  static void showOngoing() {
    Get.defaultDialog(
      title: "!!",
      middleText: "Belum ada Fitur ini",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.black, fontFamily: 'Manrope'),
      middleTextStyle: const TextStyle(color: Colors.black),
      textCancel: "OK",
      cancelTextColor: Colors.black,
      buttonColor: greyColor,
      barrierDismissible: false,
    );
  }

  static void showloadingDialogOTP(String title, String deskription) {
    Get.dialog(Dialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: styleText(blackColor, 20,FontWeight.bold, TextDecoration.none),
          ),
          Text(
            deskription,
            style: styleText(blackColor, 15, FontWeight.normal, TextDecoration.none),
          ),
          ElevatedButton(
            onPressed: () {
              // Get.offAllNamed(RouteName.page_vertifikasi);
            },
            child: const Text("Ok"),
          )
        ],
      ),
    )));
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen == true) Get.back();
  }
}
