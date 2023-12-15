import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

const primaryGreen =  Color(0xff416d6d);
// ignore: use_full_hex_values_for_flutter_colors
const tagColor = Color(0xff478bf833);
const bleuColor = Color(0xff4896F2);
const lgbgColor = Color(0xff3F97FD);

// background: #;

const whiteColor = Colors.white;
const blackColor = Colors.black;
const greyColor = Colors.grey;

const activeColor = Colors.black;
const inActiveColor = Colors.grey;
List<BoxShadow> shadowList = [
  const BoxShadow(color: Colors.grey, blurRadius: 30, offset: Offset(0, 10))
];

TextStyle styleText(Color color, double fontSize, FontWeight fonWeigt, TextDecoration deco ) =>
    GoogleFonts.poppins(color: color, fontSize: fontSize, fontWeight: fonWeigt, decoration: deco);

var  hurufBesar = styleText(blackColor, 20, FontWeight.bold, TextDecoration.none);
var hurufKecil = styleText(blackColor, 12, FontWeight.normal, TextDecoration.none);
var hurufSedang = styleText(blackColor, 15, FontWeight.normal, TextDecoration.none);
var hurufSedangBold = styleText(blackColor, 15, FontWeight.bold, TextDecoration.none);
var hurufBox = styleText(whiteColor, 12, FontWeight.bold, TextDecoration.none);


class AppConfig {
  static const String apiEndpoint = "https://www.posyandulansia.my.id/api";

  //  app_id = "1663333"
// key = "6f68404576d48427f8f3"
// secret = "0f9d91ab8a4c5f3c5ac2"
// cluster = "ap1"
  static const String appId = "1663333";
  static const String key = "6f68404576d48427f8f3";
  static const String secret = "0f9d91ab8a4c5f3c5ac2";
  static const String cluster = "ap1";
  static const String channelName = "posyandu";
  static const String eventName  = "new-request";



}
