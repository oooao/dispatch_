import 'dart:convert';
import 'dart:math';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/util/user_default.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Auth with ChangeNotifier {
  UserModel? _currentUser;

  UserModel get currentUser {
    return _currentUser!;
  }

  bool get isAuth {
    return _currentUser!.token.isNotEmpty;
  }

  String get token {
    return _currentUser!.token;
  }

  bool get isWorker {
    return _currentUser!.role == "worker";
  }

  bool get isDesigner {
    return _currentUser!.role == "designer";
  }

  bool get isCustomer {
    return _currentUser!.role == "customer";
  }

  Future<void> login(String phone, String password) async {
    String url = "${base_api}api_frontend/login";
    try {
      print("[DEBUG] url = $url");
      EasyLoading.show(status: "登入中... ");
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      final response = await http.post(Uri.parse(url), body: {
        "phone": phone,
        "password": password,
        "login_type": "email",
        "device_token": deviceToken,
      });
      EasyLoading.dismiss();
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['validity'] == false) {
        _currentUser = UserModel();
        EasyLoading.showError("登入失敗! - ${responseData['message']}");
        return;
      }
      _currentUser = UserModel.fromMap(responseData['user']);
      notifyListeners();
      UserDefault().phone = phone;
      UserDefault().password = password;
      UserDefault().userData = json.encode(_currentUser!.toJson());
    } catch (error) {
      _currentUser = UserModel();
      EasyLoading.showError("登入失敗! - $error");
    }
  }

  Future<void> logout() async {
    _currentUser = UserModel();
    //_currentUser!.token = "";
    notifyListeners();
    UserDefault().logout();
  }

  Future<void> signInWithGuest() async {
    _currentUser = UserModel();
    EasyLoading.showToast('遊客登入成功');
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      EasyLoading.show();
      await socialLogin(googleSignInAccount!.id, "google");
      EasyLoading.dismiss();
    } on Exception catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  // Future<void> lineLogin(BuildContext context) async {
  //   try {
  //     EasyLoading.show();
  //     final result = await LineSDK.instance.login();
  //     UserProfile? profile = result.userProfile;
  //     await socialLogin(profile!.userId, "line");
  //     EasyLoading.dismiss();
  //   } on Exception catch (e) {
  //     EasyLoading.dismiss();
  //     print(e);
  //   }
  // }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      EasyLoading.show();
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      await socialLogin(appleCredential.userIdentifier!, "apple");
      EasyLoading.dismiss();
    } on Exception catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<void> socialLogin(String socialId, String loginType) async {
    String url = "${base_api}api_frontend/social_login";
    try {
      print("[DEBUG] url = $url");
      EasyLoading.show(status: "登入中... ");
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      final response = await http.post(Uri.parse(url), body: {
        "social_id": socialId,
        "login_type": loginType,
        "device_token": deviceToken,
      });
      EasyLoading.dismiss();
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['validity'] == false) {
        _currentUser = UserModel();
        EasyLoading.showError("登入失敗! - ${responseData['message']}");
        return;
      }
      _currentUser = UserModel.fromMap(responseData['user']);
      print("currentUser::${_currentUser}");
      notifyListeners();
      UserDefault().socialId = socialId;
      UserDefault().loginType = loginType;
      UserDefault().userData = json.encode(_currentUser!.toJson());
    } catch (error) {
      _currentUser = UserModel();
      EasyLoading.showError("登入失敗! - $error");
    }
  }
}
