import 'dart:convert';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:posyandu_petugas/controller/LansiaController.dart';
import 'package:posyandu_petugas/model/ProfileModel.dart';
import 'package:posyandu_petugas/routes/route_names.dart';
import 'package:posyandu_petugas/utils/constans.dart';
import 'package:posyandu_petugas/utils/session.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:posyandu_petugas/utils/core.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var controller = Get.put(LansiaControler());

  String nama = "";
  String emails = "";
  String nips = "";
  String genders = "";
  String images = "";

  // void getSession() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var name = pref.getString('name')!;
  //   var email = pref.getString('email')!;
  //   var nip = pref.getString('nip')!;
  //   var gender = pref.getString('gender')!;
  //   var image = pref.getString('image')!;
  //   setState(() {
  //     nama = name;
  //     emails = email;
  //     nips = nip;
  //     genders = gender;
  //     images = image;
  //     print(images);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SmartRefresher(
        onRefresh: _onRefresh,
        controller: _refreshController,
        // onLoading: _onLoading,
        header: const WaterDropMaterialHeader(backgroundColor: primaryGreen),
        child: SingleChildScrollView(
            controller: ScrollController(),
            child: FutureBuilder<ProfileModel>(
                future: controller.getProfile(),
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
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: 110.0,
                        ),
                        width: MediaQuery.of(context).size.width,
                        color: primaryGreen,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Row(
                          children: [
                            // ClipOval(
                            //   clipBehavior: Clip.antiAlias,
                            //   child: snapshot.data!.imageUrl ==
                            //           'http://localhost/avatars/150-5.jpg'
                            //       ? Image.asset(
                            //           "assets/images/laki.png",
                            //           scale: 15,
                            //         )
                            //       : Image.network(
                            //           "https://www.posyandulansia.my.id/upload/${snapshot.data!.imageUrl}",
                            //           scale: 15,
                            //           fit: BoxFit.cover),
                            // ),

                            SizedBox(
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: snapshot.data!.imageUrl ==
                                        'http://localhost/avatars/150-5.jpg'
                                    ? Image.asset(
                                        "assets/images/laki.png",
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        "https://www.posyandulansia.my.id/upload/${snapshot.data!.imageUrl}",
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            // CircleAvatar(
                            //   radius: 30.0,
                            //   backgroundImage: snapshot.data!.imageUrl == 'http://localhost/avatars/150-5.jpg' ? AssetImage("assets/images/laki.png") : NetworkImage("assets/images/laki.png", scale: 15,) : Image.network("https://www.posyandulansia.my.id/upload/${snapshot.data!.imageUrl}"),
                            // ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Hello",
                                      style: styleText(
                                          whiteColor,
                                          12,
                                          FontWeight.normal,
                                          TextDecoration.none)),
                                  Text(snapshot.data!.name,
                                      style: styleText(
                                          whiteColor,
                                          14,
                                          FontWeight.normal,
                                          TextDecoration.none)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Builder(
                          builder: (context) {
                            List items = [
                              {
                                "label": snapshot.data!.nip,
                                "icon": Icons.card_giftcard,
                                "on_tap": () {}
                              },
                              {
                                "label": snapshot.data!.email,
                                "icon": Icons.email_outlined,
                                "on_tap": () {}
                              },
                              {
                                "label": snapshot.data!.gender,
                                "icon": MdiIcons.information,
                                "on_tap": () {}
                              },
                              {
                                "label": "Keluar",
                                "icon": Icons.logout,
                                "on_tap": () {
                                  // Modal(content: "keluar ?");
                                  Get.defaultDialog(
                                    middleTextStyle: hurufSedang,
                                    middleText: 'Keluar ?',
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryGreen),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Tidak', style: hurufBox),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryGreen),
                                        onPressed: () {
                                          logOut();
                                        },
                                        child: Text('Ya', style: hurufBox),
                                      ),
                                    ],
                                  );
                                }
                              }
                            ];

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 12.0,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: ListView.builder(
                                itemCount: items.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var item = items[index];
                                  return InkWell(
                                    onTap: () {
                                      if (item["on_tap"] != null) {
                                        item["on_tap"]!();
                                      }
                                    },
                                    child: SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: ListTile(
                                          leading: Icon(
                                            item["icon"],
                                            size: 30.0,
                                          ),
                                          title: Text(item["label"]),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                                .animate()
                                .fadeIn(
                                    duration: 1000.ms,
                                    curve: Curves.easeOutQuad)
                                .slide();
                          },
                        ),
                      ),
                    ],
                  );
                })),
      ),
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

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    print("ln");
    setState(() {
      controller.getProfile();
    });
    _refreshController.refreshCompleted();
  }

  final RefreshController _refreshController = RefreshController();
}
