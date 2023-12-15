// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

// import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:posyandu_petugas/controller/PemeriksaanController.dart';
import 'package:posyandu_petugas/model/DetailPmModel.dart';
// import 'package:posyandu_petugas/model/LansiaDetailModel.dart';

// import 'package:posyandu_petugas/pages/form/formLansia.dart';
import 'package:posyandu_petugas/utils/constans.dart';
import 'package:posyandu_petugas/utils/core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormEditP extends StatefulWidget {
  const FormEditP({Key? key}) : super(key: key);

  @override
  State<FormEditP> createState() => _FormEditPState();
}

class _FormEditPState extends State<FormEditP> {
  final argument = Get.arguments;

  final formKey = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();

  // bool _isObscure = true;
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
    super.initState();
  }

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
                Get.defaultDialog(
                  title: "Perangkat Pengukuran",
                  titleStyle: styleText(
                      blackColor, 15, FontWeight.bold, TextDecoration.none),
                  middleTextStyle: hurufSedang,
                  middleText: 'Apakah Anda yakin ingin menghapus data?',
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen),
                      onPressed: () {},
                      child: Text('Simpan', style: hurufBox),
                    ),
                  ],
                );
              },
              icon: const Icon(Icons.device_hub_outlined))
        ],
      ),
      body: SmartRefresher(
                  onRefresh: _onRefresh,
          controller: _refreshController,
        header: const WaterDropMaterialHeader(backgroundColor: primaryGreen),

        child: SingleChildScrollView(
          child: FutureBuilder<DetailPmModel>(
              future: controller.getPemeriksaanDetail(id: argument.toString()),
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
                            onChanged: (v) { 
                            },
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
                            textColor: blackColor,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Tinggi required";
                              } else if (value.length < 3) {
                                return "Tinggi min 3 ";
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
                              hintText: "Masukan Tinggi",
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
                              } else if (value.isEmpty) {
                                return "Berat min 4 digit";
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
                          // const SizedBox(height: 20),
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
      if(value == null){
            // Get.back();
      }else{
       setState(() {
        selectedDate = value;
      });
      }
      
    });
  }

  DateTime selectedDate = DateTime.now();


   void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    print("ln");
    setState(() {
    // Get.toNamed(RouteName.pageTest);
    // Get.offAndToNamed(RouteName.pageTest);
    controller.getPemeriksaanDetail(id: argument.toString());
    });
    _refreshController.refreshCompleted();
  }

  final RefreshController _refreshController = RefreshController();
}
