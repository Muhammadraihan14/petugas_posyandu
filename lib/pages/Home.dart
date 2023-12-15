// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';
// import 'dart:io';
// import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:posyandu_petugas/controller/LansiaController.dart';
import 'package:posyandu_petugas/model/LansiaModel.dart';
// import 'package:posyandu_petugas/pages/form/formLansia.dart';
// import 'package:posyandu_petugas/pages/Navbar.dart';
import 'package:posyandu_petugas/routes/route_names.dart';
// import 'package:posyandu_petugas/utils/app_exceptions.dart';
import 'package:posyandu_petugas/utils/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constans.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var controller = Get.put(LansiaControler());
  deleteLansia(BuildContext context, String id) {}

  final myController = TextEditingController();

  String value = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  String nama = "";
  String emails = "";

  void getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var name = pref.getString('name')!;
    var email = pref.getString('email')!;
    setState(() {
      nama = name;
      emails = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryGreen,
            child: const Icon(Icons.add),
            onPressed: () {
              // Get.toNamed(RouteName.pageForm);
              Get.toNamed(RouteName.pageTest);
            },
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: StreamBuilder<List<LansiaModel>>(
                stream: Stream.periodic(const Duration(milliseconds: 3000)).asyncMap((i) => controller.getLansia(query: value)),
                // future: controller.searchClass(query: value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                          height: Get.height,
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: primaryGreen,
                            size: 100,
                          ),
                        ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Center(
                      child: SizedBox(
                          height: Get.height,
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: primaryGreen,
                            size: 100,
                          ),
                        ),
                    );
                  }
                  if (snapshot.hasData) {
                    print("DATA SERACHING");
                  }
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: myController,
                        onChanged: (values) {
                          value = values;
                        },
                        style: styleText(blackColor, 13, FontWeight.w400,
                            TextDecoration.none),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          fillColor: primaryGreen,
                          contentPadding: EdgeInsets.all(2),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryGreen, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          // suffixIcon: Icon(Icons.people_alt),
                          hintText: "Cari disini ....",
                          hintStyle: TextStyle(color: blackColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: primaryGreen),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: greyColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                          child: snapshot.data!.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Image.asset("assets/images/SEO-pana 1.png"),

                                    SizedBox(
                                      width: Get.width,
                                      child: Text("(+_+)?",
                                          textAlign: TextAlign.center,
                                          style: styleText(
                                              primaryGreen,
                                              50,
                                              FontWeight.w500,
                                              TextDecoration.none)),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // var item = controller.products[index];
                                    LansiaModel cls = snapshot.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: GestureDetector(
                                        onDoubleTap: () {
                                          print("jaln");
                                          Container(
                                            // height: 300,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                50,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                              child: Material(
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 15),
                                                      Text(
                                                        "Yakin Keluar ?",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: styleText(
                                                            blackColor,
                                                            14,
                                                            FontWeight.w500,
                                                            TextDecoration
                                                                .none),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    greyColor,
                                                              ),
                                                              onPressed: () {
                                                                // logOut();
                                                              },
                                                              child: Text(
                                                                "Yes",
                                                                style: styleText(
                                                                    whiteColor,
                                                                    12,
                                                                    FontWeight
                                                                        .w500,
                                                                    TextDecoration
                                                                        .none),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 2),
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          whiteColor,
                                                                      side:
                                                                          const BorderSide(
                                                                        width:
                                                                            1.0,
                                                                        color: Colors
                                                                            .red,
                                                                      )),
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: Text(
                                                                "No",
                                                                style: styleText(
                                                                    greyColor,
                                                                    12,
                                                                    FontWeight
                                                                        .w500,
                                                                    TextDecoration
                                                                        .none),
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
                                          );
                                        },
                                        onTap: () {
                                          Get.toNamed(RouteName.pageDetail,
                                              arguments: [
                                                cls.id,
                                                cls.name,
                                                cls.nik,
                                                cls.umur,
                                                cls.alamat,
                                                cls.gender,
                                                cls.desaId,
                                              ]);
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              backgroundImage: cls.gender ==
                                                      "wanita"
                                                  ? const AssetImage(
                                                      "assets/images/perempuan.png")
                                                  : const AssetImage(
                                                      "assets/images/laki.png"),
                                            ),
                                            title: Text(
                                              cls.name,
                                              style: styleText(
                                                  blackColor,
                                                  13,
                                                  FontWeight.bold,
                                                  TextDecoration.none),
                                            ),
                                            subtitle: Text(
                                              cls.gender,
                                              style: styleText(
                                                  blackColor,
                                                  12,
                                                  FontWeight.normal,
                                                  TextDecoration.none),
                                            ),
                                          ),
                                        )
                                            .animate()
                                            .fadeIn(
                                                duration: 1000.ms,
                                                curve: Curves.easeOutQuad)
                                            .slide(),
                                      ),
                                    );
                                  },
                                ))
                    ],
                  );
                }),
          )),
    );
  }

  void logOut() async {
    String route = "${AppConfig.apiEndpoint}/logout";
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token')!;
    print(token);
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

  void dd() {}
}
