import 'package:dispatch/util/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDefault {
  static UserDefault instance = UserDefault._internal();
  factory UserDefault() => instance;

  UserDefault._internal();
  late SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isLogin => accessToken.isNotEmpty ? true : false;

  String get fcmToken {
    return _prefs.getString(KEY_FCM_TOKEN) ?? "";
  }

  set fcmToken(String value) {
    _prefs.setString(KEY_FCM_TOKEN, value);
  }

  String get accessToken => _prefs.getString(KEY_ACCESS_TOKEN) ?? "";
  set accessToken(String? value) {
    if (value != null) {
      _prefs.setString(KEY_ACCESS_TOKEN, value);
    }
  }

  set notification_count(int value) =>
      _prefs.setInt(KEY_NOTIFICATION_COUNT, value);
  int get notification_count => _prefs.getInt(KEY_NOTIFICATION_COUNT) ?? 0;

  set phone(String value) => _prefs.setString(KEY_PHONE, value);
  String get phone => _prefs.getString(KEY_PHONE) ?? "";

  set password(String value) => _prefs.setString(KEY_PASSWORD, value);
  String get password => _prefs.getString(KEY_PASSWORD) ?? "";

  set userData(String value) => _prefs.setString(KEY_USERDATA, value);
  String get userData => _prefs.getString(KEY_USERDATA) ?? "";

  set socialId(String value) => _prefs.setString(KEY_SOCIAL_ID, value);
  String get socialId => _prefs.getString(KEY_SOCIAL_ID) ?? "";

  set loginType(String value) => _prefs.setString(KEY_LOGIN_TYPE, value);
  String get loginType => _prefs.getString(KEY_LOGIN_TYPE) ?? "";

  set priceRequested(bool value) => _prefs.setBool(KEY_PRICE_REQUESTED, value);
  bool get priceRequested => _prefs.getBool(KEY_PRICE_REQUESTED) ?? false;

  logout() {
    _prefs.remove(KEY_USERDATA);
    _prefs.clear();
  }
}
