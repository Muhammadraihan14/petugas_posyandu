// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

// import 'dart:convert';
// import 'dart:developer';

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:posyandu_petugas/controller/PemeriksaanController.dart';
import 'package:posyandu_petugas/model/LansiaDetailModel.dart';
import 'package:posyandu_petugas/model/PengukuranModel.dart';

// import 'package:posyandu_petugas/pages/form/formLansia.dart';
import 'package:posyandu_petugas/utils/constans.dart';
import 'package:posyandu_petugas/utils/core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:pusher_channels_flutter/pusher-js/core/pusher.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPemeriksaan extends StatefulWidget {
  const FormPemeriksaan({Key? key}) : super(key: key);

  @override
  State<FormPemeriksaan> createState() => _FormPemeriksaanState();
}

class _FormPemeriksaanState extends State<FormPemeriksaan> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  //  PusherChannel channel = PusherChannel(channelName: AppConfig.channelName);
  final argument = Get.arguments;

  final formKey = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();
  PengukuranModel? p;
  bool alatAktif = true;
  String konselingSelected = "";
  String rujukSelected = "";
  String idUser = "";
  //controller
  TextEditingController tanggalCon = TextEditingController();
  TextEditingController tinggiCon = TextEditingController();
  TextEditingController beratCon = TextEditingController();
  TextEditingController jkCon = TextEditingController();
  TextEditingController sisCon = TextEditingController();
  TextEditingController diasCon = TextEditingController();
  TextEditingController tataCon = TextEditingController();
  TextEditingController konselingCon = TextEditingController();
  TextEditingController rujukCon = TextEditingController();
  TextEditingController lainCon = TextEditingController();
  final List<String> konselingLits = [
    '',
    'Ya',
    'Tidak',
  ];
  final List<String> rujukLits = [
    '',
    'Ya',
    'Tidak',
  ];
// PusherEvent? events;
  void getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var idUSER = pref.getString('id')!;

    setState(() {
      idUser = idUSER;
    });
  }

  var controller = Get.put(PemeriksaanControler());
  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    getSession();
    onConnectPressed();
    super.initState();
  }

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

  void onEvent(PusherEvent? event) {
    log("onEvent: ${AppConfig.eventName}");
    var dataPengukuran = jsonDecode(event?.data);
    if (dataPengukuran['tinggi'] != null) {
      tinggiCon.text = dataPengukuran['tinggi']  ;
      beratCon.text = dataPengukuran['berat']  ;
      sreamController.add(dataPengukuran);

    } else {
      sreamController.onCancel!();
    }
    // notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sreamController.close();
  }

  final StreamController<Map<String, dynamic>> sreamController =
      StreamController<Map<String, dynamic>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text("Formulir Pemeriksaan Fisik",
            style: styleText(
                whiteColor, 18, FontWeight.bold, TextDecoration.none)),
        actions: [
          IconButton(
              onPressed: () {
                Get.dialog(StreamBuilder<Map<String, dynamic>>(
                    stream: sreamController.stream,
                    // stream: sreamController.stream,
                    builder: (context, snapshot) {
                     if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } 
                      if (snapshot.hasData) {
                        // Tampilkan data tinggi dan berat
                        String tinggi = snapshot.data!['tinggi'];
                        String berat = snapshot.data!['berat'];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width * 50,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 177, 137, 137),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Material(
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 15),
                                          Text(
                                            tinggi,
                                            textAlign: TextAlign.center,
                                            style: styleText(
                                                blackColor,
                                                14,
                                                FontWeight.w500,
                                                TextDecoration.none),
                                          ),
                                          Text(
                                            berat,
                                            textAlign: TextAlign.center,
                                            style: styleText(
                                                blackColor,
                                                14,
                                                FontWeight.w500,
                                                TextDecoration.none),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: greyColor,
                                                  ),
                                                  onPressed: () {
                                                    // logOut();
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: styleText(
                                                        whiteColor,
                                                        12,
                                                        FontWeight.w500,
                                                        TextDecoration.none),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              whiteColor,
                                                          side:
                                                              const BorderSide(
                                                            width: 1.0,
                                                            color: Colors.red,
                                                          )),
                                                  onPressed: () {
                                                    sreamController.close();
                                                    Get.back();
                                                    setState(() {
                                                      _onRefresh();
                                                    });
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: styleText(
                                                        greyColor,
                                                        12,
                                                        FontWeight.w500,
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
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                    
                    ));
              },
              icon: const Icon(Icons.device_hub_outlined))
        ],
      ),
      body: SmartRefresher(
        onRefresh: _onRefresh,
        controller: _refreshController,
        // onLoading: _onLoading,
        header: const WaterDropMaterialHeader(backgroundColor: primaryGreen),
        child: SingleChildScrollView(
          child: FutureBuilder<LansiaDetailModel>(
              future: controller.getLansiaDetail(id: argument.toString()),
              builder: (context, x) {
                if (x.connectionState == ConnectionState.waiting) {
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
                if (x.connectionState == ConnectionState.none) {
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
                if (x.hasData) {
                  print("jln");
                }
                return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // tangg
                          Formlogin(
                            onTap: () async {
                              showDate();
                            },
                            onChanged: (v) {},
                            textColor: blackColor,
                            validator: (value) {
                              // if (value == null || value.isEmpty) {
                              //   return "Tanggal Pemeriksaan required";
                              // }
                              return null;
                            },
                            controller: tanggalCon,
                            password: false,
                            inputDecoration: InputDecoration(
                              fillColor: primaryGreen,
                              contentPadding: const EdgeInsets.all(2),
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryGreen, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              // suffixIcon: Icon(Icons.people_alt),
                              prefixIcon: const Icon(Icons.calendar_month),
                              hintText: DateFormat.yMd().format(selectedDate),
                              hintStyle: const TextStyle(color: blackColor),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: whiteColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: greyColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(
                                  duration: 1000.ms, curve: Curves.easeOutQuad)
                              .slide(),
                          const SizedBox(height: 20),
                          // tinggi
                          Formlogin(
                            onChanged: (v) {
                              print(v);
                            },
                            textColor: blackColor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Tinggi required";
                              } else if (value.length < 3) {
                                return "Tinggi min 4 ";
                              }
                              return null;
                            },
                            controller: tinggiCon,
                            type: TextInputType.number,
                            maxLengh: 4,
                            password: false,
                            inputDecoration: const InputDecoration(
                              fillColor: primaryGreen,
                              contentPadding: EdgeInsets.all(2),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryGreen, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              // suffixIcon: Icon(Icons.people_alt),
                              prefixIcon: Icon(Icons.height),
                              hintText: "Masukan Tinggi (meter)",
                              hintStyle: TextStyle(color: blackColor),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: whiteColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: greyColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(
                                  duration: 1000.ms, curve: Curves.easeOutQuad)
                              .slide(),
                          const SizedBox(height: 20),
                          // berat
                          Formlogin(
                            textColor: blackColor,
                            type: TextInputType.number,
                            maxLengh: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Berat Required";
                              } else if (value.length < 3) {
                                return "Berat min 3 digit";
                              }
                              return null;
                            },
                            controller: beratCon,
                            password: false,
                            inputDecoration: const InputDecoration(
                              fillColor: primaryGreen,
                              contentPadding: EdgeInsets.all(2),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: primaryGreen, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              // suffixIcon: Icon(Icons.people_alt),
                              prefixIcon: Icon(Icons.scale),
                              hintText: "Masukan Berat",
                              hintStyle: TextStyle(color: blackColor),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: whiteColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: greyColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(
                                  duration: 1000.ms, curve: Curves.easeOutQuad)
                              .slide(),
                          const SizedBox(height: 20),
                          // Formlogin(
                          //   enabled: false,
                          //   textColor: blackColor,
                          //   type: TextInputType.number,
                          //   maxLengh: 3,
                          //   validator: (value) {
                          //     // if (value == null || value.isEmpty) {
                          //     //   return "Berat Required";
                          //     // } else if (value.isEmpty) {
                          //     //   return "Berat min 2 digit";
                          //     // }
                          //     return null;
                          //   },
                          //   controller: sisCon,
                          //   password: false,
                          //   inputDecoration: const InputDecoration(
                          //     fillColor: primaryGreen,
                          //     contentPadding: EdgeInsets.all(2),
                          //     border: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(color: primaryGreen, width: 0.0),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     // suffixIcon: Icon(Icons.people_alt),
                          //     prefixIcon: Icon(Icons.bloodtype),
                          //     hintText: "Sistole",
                          //     hintStyle: TextStyle(color: blackColor),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: whiteColor),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: greyColor),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     errorBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: Colors.red),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //   ),
                          // )
                          //     .animate()
                          //     .fadeIn(
                          //         duration: 1000.ms, curve: Curves.easeOutQuad)
                          //     .slide(),
                          // const SizedBox(height: 20),
                          // // diasCon
                          // Formlogin(
                          //   textColor: blackColor,
                          //   type: TextInputType.number,
                          //   maxLengh: 3,
                          //   validator: (value) {
                          //     // if (value == null || value.isEmpty) {
                          //     //   return "Berat Required";
                          //     // } else if (value.isEmpty) {
                          //     //   return "Berat min 2 digit";
                          //     // }
                          //     return null;
                          //   },
                          //   controller: diasCon,
                          //   password: false,
                          //   inputDecoration: const InputDecoration(
                          //     fillColor: primaryGreen,
                          //     contentPadding: EdgeInsets.all(2),
                          //     border: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(color: primaryGreen, width: 0.0),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     // suffixIcon: Icon(Icons.people_alt),
                          //     prefixIcon: Icon(Icons.bloodtype_outlined),
                          //     hintText: "Diastole",
                          //     hintStyle: TextStyle(color: blackColor),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: whiteColor),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: greyColor),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     errorBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: Colors.red),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //   ),
                          // )
                          //     .animate()
                          //     .fadeIn(
                          //         duration: 1000.ms, curve: Curves.easeOutQuad)
                          //     .slide(),
                          // const SizedBox(height: 20),

                          // // tataCon
                          // Formlogin(
                          //   textColor: blackColor,
                          //   validator: (value) {
                          //     // if (value == null || value.isEmpty) {
                          //     //   return "Berat Required";
                          //     // } else if (value.isEmpty) {
                          //     //   return "Berat min 2 digit";
                          //     // }
                          //     return null;
                          //   },
                          //   controller: tataCon,
                          //   password: false,
                          //   inputDecoration: const InputDecoration(
                          //     fillColor: primaryGreen,
                          //     contentPadding: EdgeInsets.all(2),
                          //     border: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(color: primaryGreen, width: 0.0),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     // suffixIcon: Icon(Icons.people_alt),
                          //     prefixIcon: Icon(Icons.book_online_outlined),
                          //     hintText: "Tata laksana",
                          //     hintStyle: TextStyle(color: blackColor),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: whiteColor),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: greyColor),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     errorBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: Colors.red),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //   ),
                          // )
                          //     .animate()
                          //     .fadeIn(
                          //         duration: 1000.ms, curve: Curves.easeOutQuad)
                          //     .slide(),
                          // const SizedBox(height: 20),
                          // // konseling
                          // CustomDropdown<String>(
                          //   hintText: 'Konseling',
                          //   // closedSuffixIcon:Icon(Icons.close) ,
                          //   items: konselingLits,
                          //   excludeSelected: false,
                          //   validateOnChange: true,
                          //   onChanged: (valueselected) {
                          //     konselingSelected = valueselected;
                          //     print(konselingSelected);
                          //   },
                          //   validator: (value) {
                          //     // if (value == "") {
                          //     //   return "Konseling required";
                          //     // }
                          //     return null;
                          //   },
                          // )
                          //     .animate()
                          //     .fadeIn(
                          //         duration: 1000.ms, curve: Curves.easeOutQuad)
                          //     .slide(),
                          // const SizedBox(height: 20),
                          // // rujuk
                          // CustomDropdown<String>(
                          //   hintText: 'Rujuk',
                          //   // closedSuffixIcon:Icon(Icons.close) ,
                          //   items: rujukLits,
                          //   excludeSelected: false,
                          //   validateOnChange: true,
                          //   onChanged: (valueselected) {
                          //     rujukSelected = valueselected;
                          //     print(rujukSelected);
                          //   },
                          //   validator: (value) {
                          //     // if (value == "") {
                          //     //   return "Konseling required";
                          //     // }
                          //     return null;
                          //   },
                          // )
                          //     .animate()
                          //     .fadeIn(
                          //         duration: 1000.ms, curve: Curves.easeOutQuad)
                          //     .slide(),
                          // const SizedBox(height: 20),
                          // // lain2
                          // Formlogin(
                          //   textColor: blackColor,
                          //   validator: (value) {
                          //     // if (value == null || value.isEmpty) {
                          //     //   return "Berat Required";
                          //     // } else if (value.isEmpty) {
                          //     //   return "Berat min 2 digit";
                          //     // }
                          //     return null;
                          //   },
                          //   controller: lainCon,
                          //   password: false,
                          //   inputDecoration: const InputDecoration(
                          //     fillColor: primaryGreen,
                          //     contentPadding: EdgeInsets.all(2),
                          //     border: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(color: primaryGreen, width: 0.0),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     // suffixIcon: Icon(Icons.people_alt),
                          //     prefixIcon: Icon(Icons.density_small),
                          //     hintText: "Lain-lain",
                          //     hintStyle: TextStyle(color: blackColor),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: whiteColor),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: greyColor),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //     errorBorder: OutlineInputBorder(
                          //       borderSide:
                          //           BorderSide(width: 3, color: Colors.red),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(15)),
                          //     ),
                          //   ),
                          // )
                          //     .animate()
                          //     .fadeIn(
                          //         duration: 1000.ms, curve: Curves.easeOutQuad)
                          //     .slide(),
                          const SizedBox(height: 20),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              print("jlm");
                              if (formKey.currentState!.validate()) {
                                controller.postPemeriksaan(
                                  beratbadan: beratCon.text,
                                  tinggibadan: tinggiCon.text,
                                  tanggal: selectedDate.toString(),
                                  userid: idUser,
                                  desaid: x.data!.desaId.toString(),
                                  lansiaid: argument.toString(),

                                  // Tidak w
                                  diastole: diasCon.text,
                                  konseling: konselingCon.text,
                                  lain: lainCon.text,
                                  rujuk: rujukCon.text,
                                  sistole: sisCon.text,
                                  tatalaksana: tataCon.text,
                                );
                                setState(() {
                                  beratCon.clear();
                                  tinggiCon.clear();
                                  diasCon.clear();
                                  // konselingCon.clear();
                                  lainCon.clear();
                                  // rujukCon.clear();
                                  sisCon.clear();
                                  tataCon.clear();
                                  rujukSelected = "";
                                  konselingSelected = "";
                                });
                              }
                            },
                            child: SizedBox(
                              width: Get.width * 0.6,
                              height: 45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Simpan",
                                    style: styleText(whiteColor, 14,
                                        FontWeight.bold, TextDecoration.none),
                                  ),
                                ],
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(
                                  duration: 1200.ms, curve: Curves.easeOutQuad)
                              .slide()
                        ],
                      ),
                    ));
              }),
        ),
      ),
    );
  }

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        // Get.back();
      } else {
        setState(() {
          selectedDate = value;
        });
      }
    });
  }

  DateTime selectedDate = DateTime.now();

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      controller.getLansiaDetail(id: argument);
         onConnectPressed();
        //  onEvent(event);
      //  print("refersh");
    });
    _refreshController.refreshCompleted();
 
  }

  final RefreshController _refreshController = RefreshController();
}
