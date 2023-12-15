import 'dart:convert';
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:posyandu_petugas/routes/route_names.dart';
import 'package:posyandu_petugas/utils/constans.dart';
import 'package:posyandu_petugas/utils/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Formlogin extends StatelessWidget {
  TextEditingController? controller;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? hintText;
  int? maxLengh;
  TextInputType? type;
  bool password;
  Color textColor;
  InputDecoration? inputDecoration;
  String? Function(String?)? validator;
  Function(String)? onChanged;
  Function()? onTap;
  bool? enabled;
  Formlogin({
    this.validator,
    this.onTap,
    this.enabled,
    this.onChanged,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.maxLengh,
    this.type,
    this.inputDecoration,
    required this.password,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enabled: enabled,

      onTap: onTap,
      onChanged:onChanged,
        maxLength: maxLengh,
        validator: validator,
        obscureText: password,
        keyboardType: type,
        controller: controller,
        style: styleText(textColor, 13, FontWeight.w400, TextDecoration.none),
        decoration: inputDecoration);
  }
}

// ignore: must_be_immutable
class Modal extends StatelessWidget {
  String content;
  // Function onClik;
  // IconData icon;

  Modal({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width * 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Material(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        content,
                        textAlign: TextAlign.center,
                        style: styleText(blackColor, 14, FontWeight.w500,
                            TextDecoration.none),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: greyColor,
                              ),
                              onPressed: () {
                                logOut();
                              },
                              child: Text(
                                "Yes",
                                style: styleText(whiteColor, 12,
                                    FontWeight.w500, TextDecoration.none),
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: whiteColor,
                                  side: const BorderSide(
                                    width: 1.0,
                                    color: Colors.red,
                                  )),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "No",
                                style: styleText(greyColor, 12, FontWeight.w500,
                                    TextDecoration.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void logOut() async {
    String route = "${AppConfig.apiEndpoint}/logout";
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    var header = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      final res = await http.post(Uri.parse(route), headers: header);
      final body = jsonDecode(res.body);
      if (body['status'] == 'success') {
        clearSession();
        Get.snackbar("Logout success", "Silahkan login untuk masuk");
        Get.offAllNamed(RouteName.pageIntro);
      } else {
        Get.defaultDialog(
          title: "Alert",
          middleText: "Token invalid",
          backgroundColor: Colors.white,
          titleStyle:
              const TextStyle(color: Colors.black, fontFamily: 'Manrope'),
          middleTextStyle: const TextStyle(color: Colors.black),
          textCancel: "OK",
          cancelTextColor: Colors.black,
          buttonColor: greyColor,
          barrierDismissible: false,
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error$e");
    }
  }

  
}



// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

// import 'package:flutter/material.dart';

// class loadingView extends StatelessWidget {
// const loadingView({Key? key}) : super(key: key);

// @override
// Widget build(BuildContext context) {
// return Scaffold(

// body: 
// );
// }
// }

