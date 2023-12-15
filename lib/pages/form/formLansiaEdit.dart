// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posyandu_petugas/controller/LansiaController.dart';
import 'package:http/http.dart' as http;
import 'package:posyandu_petugas/model/LansiaDetailModel.dart';

// import 'package:posyandu_petugas/pages/form/formLansia.dart';
import 'package:posyandu_petugas/utils/constans.dart';
import 'package:posyandu_petugas/utils/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditLansia extends StatefulWidget {
  const EditLansia({Key? key}) : super(key: key);

  @override
  State<EditLansia> createState() => _EditLansiaState();
}

class _EditLansiaState extends State<EditLansia> {
  final argument = Get.arguments;
  final formKey = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();

  // bool _isObscure = true;
  String genderSelected = "";
  String desaSelected = "";
  //controller
  TextEditingController namaCon = TextEditingController();
  TextEditingController nikCon = TextEditingController();
  TextEditingController umurCon = TextEditingController();
  TextEditingController jkCon = TextEditingController();
  TextEditingController alamatCon = TextEditingController();
  TextEditingController desaCon = TextEditingController();
  final List<String> _list = [
    '',
    'pria',
    'wanita',
  ];
  List<String> listDesa = [
    '',
  ];

  getDesa() async {
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
    List<String> stringList = ldata.map((item) => item.toString()).toList();
    setState(() {
      listDesa = stringList;
    });
  }

  var controller = Get.put(LansiaControler());

  @override
  void initState() {
    getDesa();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulir Lansia"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<LansiaDetailModel>(
          future: controller.getLansiaDetail(id:argument.toString()),
          builder: (context, x) {
             if (x.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (x.connectionState == ConnectionState.none) {
                  return const Center(child: CircularProgressIndicator());
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
                      //name
                      Formlogin(
                        onChanged: (v) {
                          if ( v.isEmpty) {
                            v = x.data!.name;

                          }
                        },
                        textColor: blackColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nama Required";
                          }
                          return null;
                        },
                      
                        controller: namaCon,
                        password: false,
                        inputDecoration:  InputDecoration(
                          fillColor: primaryGreen,
                          contentPadding: const EdgeInsets.all(2),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryGreen, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          // suffixIcon: Icon(Icons.people_alt),
                          prefixIcon: const Icon(Icons.people_alt),
                          hintText: x.data!.name,
                          hintStyle: const TextStyle(color: blackColor),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: whiteColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: greyColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                          .slide(),
                      const SizedBox(height: 20),
                      // nik
                      Formlogin(
                        textColor: blackColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Nik required";
                          } else if (value.length < 16) {
                            return "Nik min 16 ";
                          }
                          return null;
                        },

                        controller: nikCon,
                        type: TextInputType.number,
                        maxLengh: 16,
                        password: false,
                        inputDecoration: InputDecoration(
                          fillColor: primaryGreen,
                          contentPadding: const EdgeInsets.all(2),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryGreen, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          // suffixIcon: Icon(Icons.people_alt),
                          prefixIcon: Icon(MdiIcons.card),
                          hintText: x.data!.nik,
                          hintStyle: const TextStyle(color: blackColor),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: whiteColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: greyColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                          .slide(),
                      const SizedBox(height: 20),
                      // Umur
                      Formlogin(
                        textColor: blackColor,
                        type: TextInputType.number,
                        maxLengh: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Umur Required";
                          } else if (value.isEmpty) {
                            return "Umur min 2 digit";
                          }
                          return null;
                        },
                        controller: umurCon,
                        password: false,
                        inputDecoration:  InputDecoration(
                          fillColor: primaryGreen,
                          contentPadding: const EdgeInsets.all(2),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryGreen, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          // suffixIcon: Icon(Icons.people_alt),
                          prefixIcon: const Icon(Icons.people_alt),
                          hintText: x.data!.umur.toString(),
                          hintStyle: const TextStyle(color: blackColor),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: whiteColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: greyColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                          .slide(),
                      //gender
                      CustomDropdown<String>(
                        hintText: x.data!.gender.toString(),
                        // closedSuffixIcon:Icon(Icons.close) ,
                        items: _list,
                        excludeSelected: false,
                        validateOnChange: true,
                        onChanged: (valueselected) {
                          genderSelected = valueselected;
                          print(genderSelected);
                        },
                        validator: (value) {
                          if (genderSelected == "") {
                            return "gender required";
                          }
                          return null;
                        },
                      )
                          .animate()
                          .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                          .slide(),
                      const SizedBox(height: 20),
                      // alamat
                      Formlogin(
                        textColor: blackColor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Alamat Required";
                          }
                          return null;
                        },
                        controller: alamatCon,
                        password: false,
                        inputDecoration: InputDecoration(
                          fillColor: primaryGreen,
                          contentPadding: const EdgeInsets.all(2),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: primaryGreen, width: 0.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          // suffixIcon: Icon(Icons.people_alt),
                          prefixIcon: Icon(MdiIcons.map),
                          hintText: x.data!.alamat,
                          hintStyle: const TextStyle(color: blackColor),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: whiteColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: greyColor),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                          .slide(),
                      const SizedBox(height: 20),
                      CustomDropdown<String>(
                        hintText: 'Pilih desa',
                        items: listDesa,
                        excludeSelected: false,
                        validateOnChange: true,
                        onChanged: (valueselected) {
                          String searchItem = valueselected;
                          int index = listDesa.indexOf(searchItem);
                          int idDesa = index +1;
                          desaSelected = idDesa.toString();
                        },
                        validator: (value) {
                          if (desaSelected == "") {
                            return "Desa required";
                          }
                          return null;
                        },
                      )
                          .animate()
                          .fadeIn(duration: 1000.ms, curve: Curves.easeOutQuad)
                          .slide(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.postLansiaEdit(
                              id: argument.toString(),
                                nama: namaCon.text,
                                umur: umurCon.text,
                                nik: nikCon.text,
                                alamat: alamatCon.text,
                                gender: genderSelected,
                                desa: desaSelected);
                           print(namaCon.text);
                            setState(() {
                              namaCon.clear();
                              umurCon.clear();
                              nikCon.clear();
                              alamatCon.clear();
                              genderSelected = "";
                              desaSelected = "";
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
                                style: styleText(whiteColor, 14, FontWeight.bold,
                                    TextDecoration.none),
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
                ));
          }
        ),
      ),
    );
  }
}
