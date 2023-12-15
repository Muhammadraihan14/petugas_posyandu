

import 'package:get/get.dart';
import 'package:posyandu_petugas/pages/Detail.dart';
import 'package:posyandu_petugas/pages/form/formLansiaEdit.dart';
import 'package:posyandu_petugas/pages/Home.dart';
import 'package:posyandu_petugas/pages/Intro.dart';
import 'package:posyandu_petugas/pages/Navbar.dart';
import 'package:posyandu_petugas/pages/form/formLansia.dart';
import 'package:posyandu_petugas/pages/form/pemeriksaan/formPemeriksaan.dart';
import 'package:posyandu_petugas/pages/form/pemeriksaan/formPemeriksaanEdit.dart';
// import 'package:posyandu_petugas/pages/form/formLansia.dart';
import 'package:posyandu_petugas/routes/route_names.dart';

class ROUTES {
  static final pages = [
    GetPage(name: RouteName.pageIntro, page: (() => const  IntroView())),
    GetPage(name: RouteName.pageHome, page: (() => const HomeView())),
    GetPage(name: RouteName.pageDetail, page: (() => const DetailView())),
    GetPage(name: RouteName.pageNavigasi, page: (() => const Navigasi())),
    // GetPage(name: RouteName.pageForm, page: (() => const FormLansia())),
    GetPage(name: RouteName.pageTest, page: (() => const Test())),
    GetPage(name: RouteName.pageEdit, page: (() => const EditLansia())),
    GetPage(name: RouteName.pageFormP, page: (() => const FormPemeriksaan())),
    GetPage(name: RouteName.pageFormPedit, page: (() => const FormEditP())),
  ];
}
