import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:dispatch/model/invoice_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/view/home_page.dart';
import 'package:dispatch/view/navigationBar.dart';
import 'package:dispatch/view/personal/worker/oem_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../model/banner_model.dart';

class WebAPI {
  Future<void> sendODMRequest(BuildContext context, ODMModel model) async {
    String authToken =
        Provider.of<Auth>(context, listen: false).currentUser.token;
    try {
      EasyLoading.show(status: "資料上傳中...");
      var uri = Uri.parse('$base_api/api_frontend/odm_request');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = authToken;
      request.fields['name'] = model.name;
      request.fields['address'] = model.address;
      request.fields['phone'] = model.phone;
      request.fields['signature'] = model.signature;
      request.fields['note'] = model.note;
      request.fields['type'] = model.type.toString();
      request.fields['date'] = model.date;

      if (model.photos.isNotEmpty) {
        List<http.MultipartFile> newList = [];
        for (int i = 0; i < model.photos.length; i++) {
          var data = base64Decode(model.photos[i]);
          var multipartFile = http.MultipartFile.fromBytes('photo_$i', data,
              filename: DateTime.now().toString().split(" ").first.toString() +
                  ".png");
          newList.add(multipartFile);
        }
        request.files.addAll(newList);
      }
      print("request: ${request.files}");
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      print(responseData);
      // var dic = json.decode(responseData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              titleTextStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: 'MicrosoftYaHei',
                  letterSpacing: 2,
                  height: 2),
              title: const Text(
                '需求已成功送出\n將會有專人與您聯繫！',
                textAlign: TextAlign.left,
              ),
              content: Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/odm_intro_boy.png',
                    fit: BoxFit.fitWidth,
                  )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomBarPage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Loader().hideIndicator(context);
        EasyLoading.showError("連線伺服器失敗");
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
    }
  }

  Future<OEMModel> sendOEMRequest(BuildContext context, OEMModel model) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      EasyLoading.show(status: "資料上傳中...");
      var uri = Uri.parse('$base_api/api_frontend/oem_request');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = currentUser.token;
      request.fields['user_id'] = currentUser.user_id;
      request.fields['services'] = json.encode(model.services);
      request.fields['city'] = model.city;
      request.fields['area'] = model.area;
      request.fields['address'] = model.address;
      request.fields['date'] = model.date;
      request.fields['worker_id'] = model.worker_id;
      request.fields['situation'] = model.situation;
      request.fields['key_info'] = model.key_info;
      request.fields['password'] = model.password;
      request.fields['notice'] = model.notice;
      request.fields['parking'] = model.parking;
      request.fields['parking_no'] = model.parking_no;
      if (model.pdf.isNotEmpty) {
        () async => request.files
            .add(await http.MultipartFile.fromPath('pdf', model.pdf));
      }
      if (model.photos.isNotEmpty) {
        List<http.MultipartFile> newList = [];
        for (int i = 0; i < model.photos.length; i++) {
          var data = base64Decode(model.photos[i]);
          var multipartFile = http.MultipartFile.fromBytes('photo_$i', data,
              filename: DateTime.now().toString().split(" ").first.toString() +
                  ".png");
          newList.add(multipartFile);
        }
        request.files.addAll(newList);
      }
      print("[DEBUG] request: ${request.files}");
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      print("[DEBUG] responseData: $responseData");
      var dic = json.decode(responseData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        log("[DEBUG] dic: $dic, dic id = ${dic['id']}");
        model.oem_id = dic['id'].toString();
        return model;
      } else {
        // Loader().hideIndicator(context);
        EasyLoading.showError("連線伺服器失敗");
        return model;
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return model;
    }
  }

  Future<void> acceptOEMRequest(
      BuildContext context, String oem_id, bool isAccept) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      var uri = Uri.parse('$base_api/api_frontend/oem_accept');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = currentUser.token;
      request.fields['oem_id'] = oem_id;
      request.fields['accept'] = isAccept ? "1" : "2";
      EasyLoading.show();
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      EasyLoading.dismiss();
      print("[OEM_DEBUG] responseData: $responseData");
      if (response.statusCode == 200) {
      } else {
        EasyLoading.showError("連線伺服器失敗");
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
    }
  }

  Future<void> cancelOEMRequest(BuildContext context, String oem_id) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      var uri = Uri.parse('$base_api/api_frontend/oem_cancel');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = currentUser.token;
      request.fields['oem_id'] = oem_id;
      EasyLoading.show();
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      EasyLoading.dismiss();
      print("[OEM_DEBUG] responseData: $responseData");
      if (response.statusCode == 200) {
        //
      } else {
        EasyLoading.showError("連線伺服器失敗");
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
    }
  }

  Future<void> confirmOEMRequest(
      BuildContext context, String oem_id, String worker_id) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      var uri = Uri.parse('$base_api/api_frontend/oem_confirm');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = currentUser.token;
      request.fields['oem_id'] = oem_id;
      request.fields['worker'] = worker_id;
      EasyLoading.show();
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      EasyLoading.dismiss();
      print("[OEM_DEBUG] responseData: $responseData");
      if (response.statusCode == 200) {
        //
      } else {
        EasyLoading.showError("連線伺服器失敗");
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
    }
  }

  Future<void> completeOEMRequest(BuildContext context, String oem_id) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      var uri = Uri.parse('$base_api/api_frontend/oem_complete');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = currentUser.token;
      request.fields['oem_id'] = oem_id;
      EasyLoading.show();
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      EasyLoading.dismiss();
      print("[OEM_DEBUG] responseData: $responseData");
      if (response.statusCode == 200) {
        //
      } else {
        EasyLoading.showError("連線伺服器失敗");
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
    }
  }

  Future<List<OEMModel>> getOEMs(BuildContext context) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      var uri = Uri.parse('$base_api/api_frontend/oems');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = currentUser.token;
      EasyLoading.show();
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      EasyLoading.dismiss();
      print("[OEM_DEBUG] response.statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        List<dynamic> oems = json.decode(responseData)['oems'];
        print("[OEM_DEBUG] oems: $oems");

        List<OEMModel> models = oems.map((e) => OEMModel.fromMap(e)).toList();
        print("[DEBUG] models: ${models}");

        return models;
      } else {
        EasyLoading.showError("連線伺服器失敗");
        return [];
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return [];
    }
  }

  Future<List<OEMModel>> getOEMLists(BuildContext context, int accept) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      var uri = Uri.parse('$base_api/api_frontend/oem_list');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = currentUser.token;
      request.fields['accept'] = "$accept";
      EasyLoading.show();
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      EasyLoading.dismiss();
      print("[OEM_DEBUG] response.statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        List<dynamic> oems = json.decode(responseData)['oems'];
        for (var oem in oems) {
          print(oem.toString());
        }

        List<OEMModel> models = oems.map((e) => OEMModel.fromMap(e)).toList();

        return models;
      } else {
        EasyLoading.showError("連線伺服器失敗");
        return [];
      }
    } catch (e) {
      print(e);
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return [];
    }
  }

  Future<List<UserModel>> getMatchingWorkers(
      BuildContext context, String oem_id) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      var uri = Uri.parse('$base_api/api_frontend/get_matching_workers');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['auth_token'] = currentUser.token;
      request.fields['oem_id'] = "$oem_id";
      EasyLoading.show();
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      EasyLoading.dismiss();
      print("[OEM_DEBUG] response.statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(responseData)['users'];
        print("[OEM_DEBUG] oems: $users");

        List<UserModel> models =
            users.map((e) => UserModel.fromMap(e)).toList();
        print("[DEBUG] models: ${models}");

        return models;
      } else {
        EasyLoading.showError("連線伺服器失敗");
        return [];
      }
    } catch (e) {
      print(e);
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return [];
    }
  }

  Future<List<String>> getOdmvideo() async {
    try {
      var uri = Uri.parse('$base_api/api_frontend/odm_videos');
      var request = http.MultipartRequest("Get", uri);
      var response = await request.send();

      String responseData =
          await response.stream.transform(utf8.decoder).join();
      if (response.statusCode == 200) {
        print(responseData);
        List<String> videos = [
          json.decode(responseData)['odm_video_1'],
          json.decode(responseData)['odm_video_2'],
          json.decode(responseData)['odm_video_3'],
        ];
        return videos;
      } else {
        EasyLoading.showError("連線伺服器失敗");
        return [];
      }
    } catch (e) {
      print(e);
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return [];
    }
  }

  Future<List<BannerModel>> getBannerIamge() async {
    try {
      var uri = Uri.parse('$base_api/api_frontend/banners');
      var request = http.MultipartRequest("Get", uri);
      var response = await request.send();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      if (response.statusCode == 200) {
        List<dynamic> banners = json.decode(responseData)['banners'];
        List<BanneRModel> models =
            banners.map((e) => BanneRModel.fromMap(e)).toList();

        List<BannerModel> listBanners = [];

        int index = 1;
        for (BanneRModel banner in models) {
          listBanners
              .add(BannerModel(imagePath: banner.image, id: index.toString()));
          index++;
        }

        return listBanners;
      } else {
        EasyLoading.showError("連線伺服器失敗");
        return [];
      }
    } catch (e) {
      print(e);
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return [];
    }
  }

  Future<bool> uploadInvoice(BuildContext context, InvoiceModel model) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      EasyLoading.show(status: "資料上傳中...");
      var uri = Uri.parse('$base_api/api_frontend/upload_invoice');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['item_and_description'] =
          json.encode(model.item_and_description);
      request.fields['oem_id'] = model.oem_id;

      request.fields['auth_token'] = currentUser.token;
      print("request : ${request.toString()}");
      print("request fields : ${request.fields.toString()}");

      var response = await request.send();
      EasyLoading.show();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      print("[DEBUG] responseData: $responseData");
      var dic = json.decode(responseData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        print("${dic.toString()}");
        return true;
      } else {
        EasyLoading.showError("連線伺服器失敗");
        return false;
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return false;
    }
  }

  Future<bool> userSignUp(BuildContext context, UserModel model) async {
    try {
      EasyLoading.show(status: "資料上傳中...");
      var uri = Uri.parse('$base_api/api_frontend/signup');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['name'] = model.name;
      request.fields['password'] = model.password;
      request.fields['email'] = model.email;
      request.fields['phone'] = model.phone;
      request.fields['address'] = model.address;
      request.fields['area'] = model.area;
      request.fields['city'] = model.city;
      request.fields['birthday'] = model.birthday;
      print("request : ${request.toString()}");
      print("request fields : ${request.fields.toString()}");
      List<http.MultipartFile> newList = [];
      if (model.attachment.isNotEmpty) {
        var data = base64Decode(model.attachment);
        var multipartFile = http.MultipartFile.fromBytes('attachment', data,
            filename:
                DateTime.now().toString().split(" ").first.toString() + ".png");
        newList.add(multipartFile);
      }
      if (model.attachment2.isNotEmpty) {
        var data = base64Decode(model.attachment2);
        var multipartFile = http.MultipartFile.fromBytes('attachment2', data,
            filename:
                DateTime.now().toString().split(" ").first.toString() + ".png");
        newList.add(multipartFile);
      }
      request.files.addAll(newList);
      var response = await request.send();
      EasyLoading.show();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      print("[DEBUG] responseData: $responseData");
      var dic = json.decode(responseData);
      EasyLoading.dismiss();
      if (dic["status"].toString().trim() == "200") {
        print("${dic.toString()}");
        return true;
      } else {
        EasyLoading.showError("${dic["message"]}");
        return false;
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return false;
    }
  }

  Future<bool> UserUpdateInformation(
      BuildContext context, UserModel model) async {
    UserModel currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    try {
      EasyLoading.show(status: "資料上傳中...");
      var uri = Uri.parse('$base_api/api_frontend/update_userdata');
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['name'] = model.name;
      request.fields['password'] = model.password;
      request.fields['email'] = model.email;
      request.fields['phone'] = model.phone;
      request.fields['address'] = model.address;
      request.fields['auth_token'] = currentUser.token;
      request.fields['area'] = model.area;
      request.fields['city'] = model.city;
      print("request : ${request.toString()}");
      print("request fields : ${request.fields.toString()}");

      var response = await request.send();
      EasyLoading.show();
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      print("[DEBUG] responseData: $responseData");
      var dic = json.decode(responseData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        print("${dic.toString()}");
        return true;
      } else {
        EasyLoading.showError("連線伺服器失敗");
        return false;
      }
    } catch (e) {
      EasyLoading.showError("發生錯誤！錯誤代碼：$e");
      return false;
    }
  }
}
