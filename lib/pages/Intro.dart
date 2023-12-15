// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:posyandu_petugas/routes/route_names.dart';
import 'package:posyandu_petugas/utils/constans.dart';
import 'package:posyandu_petugas/utils/core.dart';
import 'package:posyandu_petugas/utils/dialog_helper.dart';
import 'package:posyandu_petugas/utils/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  final formKey = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();

  bool _isObscure = true;

  //controller
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: const AssetImage("assets/images/intro.jpg"),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.cover)),
          ),
          Container(
              width: 400.0,
              padding: const EdgeInsets.only(top: 223, left: 40, right: 40),
              child: Form(
                key: formKey,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Formlogin(
                          textColor: blackColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email Required";
                            }
                            return null;
                          },
                          controller: emailCon,
                          password: false,
                          hintText: "Masukan email",
                          // prefixIcon:,
                          inputDecoration: const InputDecoration(
                            fillColor: blackColor,
                            contentPadding: EdgeInsets.all(2),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor , width: 0.0),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            prefixIcon:
                                Icon(Icons.email_outlined, color: greyColor),
                            hintText: "Masukan email",
                            hintStyle: TextStyle(color: greyColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: greyColor),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: blackColor),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                            .slide(),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Formlogin(
                          textColor: blackColor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password Required";
                            }
                            return null;
                          },
                          controller: passCon,
                          password: _isObscure,
                          // prefixIcon: ,
                          // suffixIcon: ,
                          // hintText: ,
                          inputDecoration: InputDecoration(
                            fillColor: greyColor,
                            contentPadding: const EdgeInsets.all(2),
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: blackColor , width: 0.0),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            suffixIcon: IconButton(
                              onPressed: (() {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                              icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: greyColor),
                            ),
                            prefixIcon: const Icon(Icons.key, color: greyColor),
                            hintText: "Masukan password",
                            hintStyle: const TextStyle(color: greyColor),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 3, color: greyColor),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: blackColor),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 1100.ms, curve: Curves.easeOutQuad)
                            .slide(),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            prosesLogin();
                          }
                        },
                        child: SizedBox(
                          width: Get.width * 0.6,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: styleText(blackColor, 14,
                                    FontWeight.w500, TextDecoration.none),
                              ),
                            ],
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                          .slide()
                    ],
                  ),
                ),
              )),
        ],
      )),
    );
  }

  void prosesLogin() async {
    clearSession();
    String route = "${AppConfig.apiEndpoint}/login?";
    print(emailCon.text);
    print(passCon.text);
    DialogHelper.showloading();
    try {
      final res = await http.post(Uri.parse(route),
          body: ({
            "email": emailCon.text,
            "password": passCon.text,
          }));

      final body = jsonDecode(res.body);

      if (body['status'] == 'success') {
        DialogHelper.hideLoading();
        String email = emailCon.text;
        String name = body['user']['name'];
        String nip = body['user']['nip'];
        String gender = body['user']['gender'];
        String image = body['user']['image_url'];
        int id = body['user']['id'];
        String token = body['data']['token']['plainTextToken'];
        createUserSession(
            email, name, token, nip, gender, image, id.toString());
        Get.snackbar("Login berhasil", "Login sebagai $name");
        Get.offAllNamed(RouteName.pageNavigasi);
      } else {
        DialogHelper.hideLoading();
        Get.snackbar("Login gagal", "Email atau Password salah");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error$e");
    }
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? login = pref.getBool('IS_LOGIN');
    String? name = pref.getString('name');
    if (login == true) {
      Get.offAllNamed(RouteName.pageNavigasi);
      Get.snackbar("Login berhasil", "Login sebagai $name");
    } else {
      Get.toNamed(RouteName.pageIntro);
    }
  }
}
