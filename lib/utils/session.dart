import 'package:shared_preferences/shared_preferences.dart';

const EMAIL = 'email';
const NAME = 'name';
const TOKEN = 'token';
const IS_LOGIN = 'IS_LOGIN';
const ID = 'id';
const NIP = 'nip';
const GENDER = 'gender';
const IMAGE = 'image';

Future createUserSession(
  String email,
  String name,
  String token,
  String nip,
  String gender,
  String image,
  String id,
) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(IS_LOGIN, true);
  prefs.setString(EMAIL, email);
  prefs.setString(NAME, name);
  prefs.setString(TOKEN, token);
  prefs.setString(NIP, nip);
  prefs.setString(GENDER, gender);
  prefs.setString(IMAGE, image);
  prefs.setString(ID, id);
}

Future clearSession() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  return true;
}
