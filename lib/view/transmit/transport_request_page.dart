import 'dart:convert';

import 'package:dispatch/util/common.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/util/open_api.dart';
import 'package:dispatch/view/transmit/request_complete_page.dart';
import 'package:dispatch/view/widgets/custom_widgets.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TransportRequestPage extends StatefulWidget {
  const TransportRequestPage({super.key});

  @override
  _TransportRequestPageState createState() => _TransportRequestPageState();
}

class _TransportRequestPageState extends State<TransportRequestPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/images/form_background.png'),
        //         fit: BoxFit.fitWidth)),
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pickupAddressController = TextEditingController();
  final deliveryAddressController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final weightController = TextEditingController();
  final customerNameController = TextEditingController();
  String svgCode = "";

  Map<String, dynamic> _pickup_city_list = {};
  Map<String, dynamic> _delivery_city_list = {};
  String _selectedpickupCity = "";
  String _selecteddeliveryCity = "";
  Map<String, dynamic> _pickup_area_list = {};
  Map<String, dynamic> _delivery_area_list = {};
  String _selectedpickupArea = "";
  String _selecteddeliveryArea = "";

  @override
  void initState() {
    super.initState();
    loadCountryList();
  }

  Future<void> loadCountryList() async {
    _pickup_city_list = _delivery_city_list = await OpenApi.getCountryList();
    if (_pickup_city_list.isNotEmpty && _delivery_city_list.isNotEmpty) {
      _selectedpickupCity = _pickup_city_list.keys.first;
      _selecteddeliveryCity = _delivery_city_list.keys.first;
    }
    await loadDeliveryAreaList();
    await loadPickupAreaList();
    setState(() {});
  }

  Future<void> loadDeliveryAreaList() async {
    _delivery_area_list = await OpenApi.getAreaList(_selecteddeliveryCity);
    if (_delivery_area_list.isNotEmpty) {
      _selecteddeliveryArea = _delivery_area_list.keys.first;
    }
    setState(() {});
  }

  Future<void> loadPickupAreaList() async {
    _pickup_area_list = await OpenApi.getAreaList(_selectedpickupCity);
    if (_pickup_area_list.isNotEmpty) {
      _selectedpickupArea = _pickup_area_list.keys.first;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            context.emptySizedHeightBoxLow3x,
            Text(
              '運送訂單',
              style: TextStyle(
                  fontFamily: 'MicrosoftYaHei',
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 15.w),
            ),
            context.emptySizedHeightBoxLow3x,
            FormBackground(
              child: Container(
                padding: EdgeInsets.only(top: 40.h),
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: "客戶名稱",
                      hinttext: '請輸入客戶名稱',
                      controller: customerNameController,
                      //hinttext: "客戶名稱"
                    ),
                    context.emptySizedHeightBoxLow3x,
                    CustomTextField(
                      labelText: "案名",
                      hinttext: '請輸入案名',
                      controller: nameController,
                      //hinttext: "案名",
                    ),
                    context.emptySizedHeightBoxLow3x,
                    CustomTextField(
                      hinttext: '請輸入電話',
                      labelText: "聯絡電話",
                      controller: phoneController,
                      //hinttext: "聯絡電話"
                    ),
                    context.emptySizedHeightBoxLow3x,
                    CustomTextField(
                      hinttext: '請輸入重量',
                      labelText: "重量",
                      controller: weightController,
                      //hinttext: "重量"
                    ),
                    context.emptySizedHeightBoxNormal,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton2(
                          iconStyleData: IconStyleData(icon: Container()),
                          underline: Container(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontFamily: 'MicrosoftYaHei',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.center,
                          buttonStyleData: ButtonStyleData(
                              width: 110.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  // color: Color(0xffD9D9D9),
                                  border: Border.all(
                                      color: Colors.black26, width: 1.5),
                                  borderRadius: BorderRadius.circular(30))),
                          value: _selecteddeliveryCity,
                          onChanged: (value) => {
                            setState((() {
                              _selecteddeliveryCity = value!;
                              loadDeliveryAreaList();
                            }))
                          },
                          items: _delivery_city_list.keys.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                _delivery_city_list[item],
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          hint: Text('聯絡地址(縣市)'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        DropdownButton2(
                          iconStyleData: IconStyleData(icon: Container()),
                          underline: Container(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontFamily: 'MicrosoftYaHei',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.center,
                          buttonStyleData: ButtonStyleData(
                              height: 35.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1.5),
                                  borderRadius: BorderRadius.circular(30))),
                          value: _selecteddeliveryArea,
                          onChanged: (value) => {
                            setState((() {
                              _selecteddeliveryArea = value!;
                            }))
                          },
                          items: _delivery_area_list.keys.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                _delivery_area_list[item],
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          hint: const Text('請選擇地區'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      hinttext: '請輸入地址',
                      labelText: '運送地點',
                      controller: deliveryAddressController,
                    ),
                    context.emptySizedHeightBoxNormal,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton2(
                          iconStyleData: IconStyleData(icon: Container()),
                          underline: Container(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontFamily: 'MicrosoftYaHei',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.center,
                          buttonStyleData: ButtonStyleData(
                              width: 110.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1.5),
                                  borderRadius: BorderRadius.circular(30))),
                          value: _selectedpickupCity,
                          onChanged: (value) => {
                            setState((() {
                              _selectedpickupCity = value!;
                              loadDeliveryAreaList();
                            }))
                          },
                          items: _pickup_city_list.keys.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                _pickup_city_list[item],
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          hint: Text('聯絡地址(縣市)'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        DropdownButton2(
                          iconStyleData: IconStyleData(icon: Container()),
                          underline: Container(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontFamily: 'MicrosoftYaHei',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.center,
                          buttonStyleData: ButtonStyleData(
                              height: 35.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1.5),
                                  borderRadius: BorderRadius.circular(30))),
                          value: _selectedpickupArea,
                          onChanged: (value) => {
                            setState((() {
                              _selectedpickupArea = value!;
                            }))
                          },
                          items: _pickup_area_list.keys.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                _pickup_area_list[item],
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          hint: const Text('請選擇地區'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      hinttext: '請輸入地址',
                      labelText: '到貨地點',
                      controller: deliveryAddressController,
                    ),
                    context.emptySizedHeightBoxNormal,
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 120.w,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  String pickupAddress = pickupAddressController.text;
                  String deliveryAddress = deliveryAddressController.text;
                  String name = nameController.text;
                  String phone = phoneController.text;
                  String weight = weightController.text;
                  String customerName = customerNameController.text;
                  if (pickupAddress.isEmpty) {
                    EasyLoading.showError("請填寫取貨地點");
                    return;
                  }
                  if (deliveryAddress.isEmpty) {
                    EasyLoading.showError("請填寫收貨地點");
                    return;
                  }
                  if (name.isEmpty) {
                    EasyLoading.showError("請填寫案名");
                    return;
                  }
                  if (phone.isEmpty) {
                    EasyLoading.showError("請填寫簽收人電話");
                    return;
                  }
                  if (weight.isEmpty) {
                    EasyLoading.showError("請填寫重量");
                    return;
                  }
                  if (customerName.isEmpty) {
                    EasyLoading.showError("請填寫簽收人姓名");
                    return;
                  }
                  showConfirmDialog();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '確認',
                  style: TextStyle(
                      fontFamily: 'MicrosoftYaHei',
                      letterSpacing: 18.w,
                      fontSize: 16.sp),
                ),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
          ],
        ),
      ),
    );
  }

  void showConfirmDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("吉時貨運"),
            content: const Text("是否確定送出此需求單？"),
            actions: [
              TextButton(
                child: const Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("確定"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await send_request();
                },
              ),
            ],
          );
        });
  }

  Future<void> send_request() async {
    String url = "${base_api}api_frontend/instant_freight";
    String authToken =
        Provider.of<Auth>(context, listen: false).currentUser.token;
    String pickupAddress = pickupAddressController.text;
    String deliveryAddress = deliveryAddressController.text;
    String name = nameController.text;
    String phone = phoneController.text;
    //欄位變動
    String floor = "";
    String collector = "";
    try {
      print("[DEBUG] url = $url");
      EasyLoading.show(status: "上傳中... ");
      final response = await http.post(Uri.parse(url), body: {
        "auth_token": authToken,
        "pickup_address": pickupAddress,
        "delivery_address": deliveryAddress,
        "name": name,
        "phone": phone,
        "floor": floor,
        "collector": collector,
      });
      EasyLoading.dismiss();
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['validity'] == false) {
        EasyLoading.showError("送出失敗! - ${responseData['message']}");
        return;
      }
      int requestId = responseData['id'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RequestCompletePage(
                request_id: requestId,
                pickup_address: pickupAddress,
                delivery_address: deliveryAddress)),
      );
    } catch (error) {
      EasyLoading.showError("送出失敗! - $error");
    }
  }
}
