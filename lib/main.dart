import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posyandu_petugas/routes/page_routes.dart';
import 'package:posyandu_petugas/routes/route_names.dart';
import 'package:posyandu_petugas/utils/constans.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  
  runApp(GetMaterialApp(
      theme: ThemeData(appBarTheme: const AppBarTheme(backgroundColor: primaryGreen)),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.pageIntro,
      getPages: ROUTES.pages));
}
