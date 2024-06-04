import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class OpenApi {
  static Future<Map<String, dynamic>> getCountryList() async {
    Map<String, dynamic> result = {};

    String apiUrl = "https://api.nlsc.gov.tw/other/ListCounty";
    //新增例外處理，API可能維護中。
    try {
      final response = await http.get(Uri.parse(apiUrl));
      final utf16Body = utf8.decode(response.bodyBytes);
      final document = XmlDocument.parse(utf16Body);
      List<XmlElement> countries =
          document.getElement("countyItems")!.childElements.toList();
      for (var country in countries) {
        XmlElement countyname = country.getElement("countyname")!;
        XmlElement countycode = country.getElement("countycode")!;
        XmlElement countycode01 = country.getElement("countycode01")!;
        result.putIfAbsent(countycode01.text, () => countyname.text);
      }
    } on Exception catch (e) {
      EasyLoading.showError('取得台灣地區時發生錯誤${e.toString()}');
    }
    ;

    return result;
  }

  static Future<Map<String, dynamic>> getAreaList(String countycode) async {
    Map<String, dynamic> result = {};
    String apiUrl = "https://api.nlsc.gov.tw/other/ListTown1/$countycode";
    print("apiUrl: $apiUrl");
    try {
      EasyLoading.show();
      final response = await http.get(Uri.parse(apiUrl));
      EasyLoading.dismiss();
      final utf16Body = utf8.decode(response.bodyBytes);
      final document = XmlDocument.parse(utf16Body);
      List<XmlElement> countries =
          document.getElement("townItems")!.childElements.toList();
      for (var country in countries) {
        print("town: $country");
        XmlElement townname = country.getElement("townname")!;
        XmlElement towncode = country.getElement("towncode")!;
        XmlElement towncode01 = country.getElement("towncode01")!;
        result.putIfAbsent(towncode01.text, () => townname.text);
      }
    } on Exception catch (e) {
      EasyLoading.showError('取得台灣地區時發生錯誤');
    }

    print("result: $result");
    return result;
  }
}
