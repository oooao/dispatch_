import 'dart:async';

import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/util/open_api.dart';
import 'package:dispatch/view/login_page.dart';
import 'package:dispatch/view/widgets/custom_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomerEditPage extends StatefulWidget {
  const CustomerEditPage({super.key});

  @override
  State<CustomerEditPage> createState() => _CustomerEditPageState();
}

class _CustomerEditPageState extends State<CustomerEditPage> {
  TextEditingController addressController = TextEditingController();

  late UserModel currentUser =
      Provider.of<Auth>(context, listen: false).currentUser;
  int currentTab = 0;

  Map<String, dynamic> _city_list = {};
  String _selectedCity = "";
  Map<String, dynamic> _area_list = {};
  String _selectedArea = "";

  @override
  void initState() {
    super.initState();
    addressController.text = currentUser.address;
    _selectedCity = currentUser.city;
    _selectedArea = currentUser.area;
    loadCountryList();
  }

  Future<void> loadCountryList() async {
    _city_list = await OpenApi.getCountryList();
    if (_city_list.isNotEmpty) {
      _selectedCity = _city_list.keys.first;
    }
    await loadAreaList();
    setState(() {});
  }

  Future<void> loadAreaList() async {
    print("loadAreaList: _selectedCity = $_selectedCity");
    _area_list = await OpenApi.getAreaList(_selectedCity);
    if (_area_list.isNotEmpty) {
      _selectedArea = _area_list.keys.first;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/TextLogo.png',
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 20.h),
        color: Color(0xFFf1f1f1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
              child: Text(
                '個人首頁',
                style: TextStyle(
                    fontFamily: 'MicrosoftYaHei',
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 15.w),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 110.w,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 90.w,
                        height: 90.h,
                        child: Image.asset("assets/images/male.png"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("會員編號：${currentUser.user_id}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("會員名稱：${currentUser.name}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text("會員電話：${currentUser.phone}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text("會員身份：${getRoleString(currentUser.role)}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.h)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: primaryTextColor, // Set the tab indicator color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: '訂單紀錄'),
                        Tab(text: '行事曆'),
                        Tab(text: '客服系統'),
                        Tab(text: '個人設定'),
                      ],
                      onTap: (value) {
                        setState(() {
                          currentTab = value;
                        });
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(),
                          buildCalendar(),
                          Container(),
                          buildPersonal(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCalendar() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SfCalendar(
        view: CalendarView.month,
      ),
    );
  }

  Widget buildPersonal() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 30.w),
            child: Column(
              children: [
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
                              border:
                                  Border.all(color: Colors.black26, width: 1.5),
                              borderRadius: BorderRadius.circular(30))),
                      value: _selectedCity,
                      onChanged: (value) => {
                        setState((() {
                          _selectedCity = value!;
                          loadAreaList();
                        }))
                      },
                      items: _city_list.keys.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            _city_list[item],
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
                              border:
                                  Border.all(color: Colors.black26, width: 1.5),
                              borderRadius: BorderRadius.circular(30))),
                      value: _selectedArea,
                      onChanged: (value) => {
                        setState((() {
                          _selectedArea = value!;
                        }))
                      },
                      items: _area_list.keys.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            _area_list[item],
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
                  hinttext: '請輸入詳細地點',
                  labelText: '聯絡地址',
                  controller: addressController,
                ),
                context.emptySizedHeightBoxLow3x,
                SizedBox(
                  width: 120.w,
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      // print("城市:${_selectedCity}");
                      currentUser.city = _selectedCity;
                      //print("${currentUser.city}");
                      currentUser.area = _selectedArea;
                      currentUser.address = addressController.text;
                      await WebAPI()
                          .UserUpdateInformation(context, currentUser);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      '更新',
                      style: TextStyle(
                          fontFamily: 'MicrosoftYaHei',
                          letterSpacing: 12.w,
                          fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            width: MediaQuery.sizeOf(context).width,
            height: 80,
            child: ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      contentTextStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontFamily: 'MicrosoftYaHei',
                          letterSpacing: 2,
                          height: 2),
                      content: const Text(
                        '是否確定要刪除帳號？',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          child: const Text("取消"),
                          onPressed: () {
                            return;
                          },
                        ),
                        TextButton(
                          child: const Text("確定"),
                          onPressed: () async {
                            EasyLoading.show();
                            Timer(Duration(seconds: 3), () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  ((route) => false));
                              EasyLoading.showToast('帳號已刪除');
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffED3232),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                '刪除帳號',
                style: TextStyle(
                    fontFamily: 'MicrosoftYaHei',
                    letterSpacing: 12.w,
                    fontSize: 16.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
