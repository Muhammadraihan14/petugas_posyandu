// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:posyandu_petugas/controller/LansiaController.dart';
import 'package:posyandu_petugas/controller/PemeriksaanController.dart';
import 'package:posyandu_petugas/model/LansiaDetailModel.dart';
import 'package:posyandu_petugas/routes/route_names.dart';
import 'package:posyandu_petugas/utils/constans.dart';
// import 'package:posyandu_petugas/utils/core.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../model/PemeriksaanFisikModel.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  var controller = Get.put(LansiaControler());
  var controllerpm = Get.put(PemeriksaanControler());
  var argument = Get.arguments;
  String idLansia = "";
  String desaSelect= "";
  // dynamic  idlansia= argument[0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDesa(id:argument[6]);

    initializeDateFormatting();
  }

  final RefreshController _refreshController = RefreshController();
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      controller.getLansiaDetail(id: argument[0]);
      //  print("refersh");
    });
    _refreshController.refreshCompleted();
  }

  List<String> listDesa = [
    '',
  ];

  getDesa({required int id}) async {
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
    int idDesa = id - 1;
    var desaSelected = stringList[idDesa];
    String desaResult = desaSelected;
    setState(() {
        desaSelect   =desaResult ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Detail Lansia"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryGreen,
          child: const Icon(Icons.add),
          onPressed: () {
            // Get.toNamed(RouteName.pageForm);
            Get.toNamed(RouteName.pageFormP, arguments: argument[0]);
          },
        ),
        body: SmartRefresher(
          onRefresh: _onRefresh,
          controller: _refreshController,
          // onLoading: _onLoading,
          header: const WaterDropMaterialHeader(backgroundColor: primaryGreen),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: FutureBuilder<LansiaDetailModel>(
                future: controller.getLansiaDetail(id: argument[0]),
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
                    print("jln");
                  }
                  return Column(
                    children: [
                      const SizedBox(height: 50),
                      SizedBox(
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.6,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/blank.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 2.6,
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          // width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.name.toUpperCase(),
                                textAlign: TextAlign.left,
                                style: hurufBesar,
                              ),
                              PopupMenuButton(
                                onSelected: (value) {
                                  if (value == '1') {
                                    Get.defaultDialog(
                                      middleTextStyle: hurufSedang,
                                      middleText:
                                          'Apakah Anda yakin ingin menghapus data?',
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryGreen),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('Batal', style: hurufBox),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryGreen),
                                          onPressed: () {
                                            controller.deleteLansia(
                                                id: argument[0].toString());
                                          },
                                          child: Text('Hapus', style: hurufBox),
                                        ),
                                      ],
                                    );
                                  } else {
                                    print("jaln");
                                    Get.toNamed(RouteName.pageEdit,
                                        arguments: argument[0]);
                                  }
                                },
                                itemBuilder: (BuildContext bc) {
                                  return const [
                                    PopupMenuItem(
                                      value: '1',
                                      child: Text("Delete"),
                                    ),
                                    PopupMenuItem(
                                      value: '0',
                                      child: Text("Edit"),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Text("NIK : ", style: hurufSedang),
                      //       Text(snapshot.data!.nik.toString(),
                      //           style: hurufSedang),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Gender : ", style: hurufSedang),
                            Text(snapshot.data!.gender, style: hurufSedang),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Umur : ", style: hurufSedang),
                            Text("${snapshot.data!.umur} Tahun",
                                style: hurufSedang),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Alamat : ", style: hurufSedang),
                            Text(snapshot.data!.alamat, style: hurufSedang),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Desa : ", style: hurufSedang),
                            Text(
                                desaSelect,
                                style: hurufSedang),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          children: [
                            Text(
                              "Hasil Pemeriksaan",
                              textAlign: TextAlign.left,
                              style: hurufBesar,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height,
                        child: ListView.builder(
                            itemCount:
                                snapshot.data!.pemerisaanFisikTindakan!.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              PemerisaanFisikTindakan cls = snapshot
                                  .data!.pemerisaanFisikTindakan![index];
                              return Dismissible(
                                key: ValueKey<PemerisaanFisikTindakan>(snapshot
                                    .data!.pemerisaanFisikTindakan![index]),
                                background: Container(
                                    color: Colors.red,
                                    child: const Icon(
                                      Icons.delete,
                                      color: whiteColor,
                                    )),
                                onDismissed: (direction) {
                                  Get.defaultDialog(
                                    title: "Alert",
                                    titleStyle: styleText(blackColor, 15,
                                        FontWeight.bold, TextDecoration.none),
                                    middleTextStyle: hurufSedang,
                                    middleText:
                                        'Apakah Anda yakin ingin menghapus data?',
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryGreen),
                                        onPressed: () {
                                          controllerpm.deletePemeriksaan(
                                              id: cls.id.toString());
                                          _onRefresh();
                                          Get.back();
                                        },
                                        child: Text('Ya', style: hurufBox),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryGreen),
                                        onPressed: () {
                                          print(cls.id);
                                          _onRefresh();
                                          Get.back();
                                        },
                                        child: Text('Tidak', style: hurufBox),
                                      ),
                                    ],
                                  );
                                },
                                child: GestureDetector(
                                  onLongPress: () {
                                    Get.defaultDialog(
                                      title: "Alert",
                                      titleStyle: styleText(blackColor, 15,
                                          FontWeight.bold, TextDecoration.none),
                                      middleTextStyle: hurufSedang,
                                      middleText:
                                          'Edit data  ${DateFormat.yMMMMd('id_ID').format(cls.tanggalP)} ?',
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryGreen),
                                          onPressed: () {
                                            Get.back();
                                            Get.toNamed(RouteName.pageFormPedit,
                                                arguments: cls.id);

                                            print(cls.id);
                                          },
                                          child: Text('Ya', style: hurufBox),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryGreen),
                                          onPressed: () {
                                            print(cls.id);
                                            _onRefresh();
                                            Get.back();
                                          },
                                          child: Text('Tidak', style: hurufBox),
                                        ),
                                      ],
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: ExpansionTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat.yMMMEd('id_ID')
                                                .format(cls.tanggalP),
                                            style: hurufSedangBold,
                                          ),
                                          Text(
                                            cls.user.name,
                                            style: hurufSedangBold,
                                          ),
                                        ],
                                      ),
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 20, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Status Gizi : ',
                                                      style: hurufSedang),
                                                  Text(cls.statusGizi,
                                                      style: hurufSedang),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('IMT : ',
                                                      style: hurufSedang),
                                                  Text(cls.imt.toString(),
                                                      style: hurufSedang),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Tinggi : ',
                                                      style: hurufSedang),
                                                  Text(cls.tinggiBadan.toString(),
                                                      style: hurufSedang),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Berat : ',
                                                      style: hurufSedang),
                                                  Text(cls.beratBadan.toString(),
                                                      style: hurufSedang),
                                                ],
                                              ),

                                              // const SizedBox(height: 15),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(
                                          duration: 1000.ms,
                                          curve: Curves.easeOutQuad)
                                      .slide(),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
