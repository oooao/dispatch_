import 'dart:async';

import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/util/open_api.dart';
import 'package:dispatch/view/login_page.dart';
import 'package:dispatch/view/widgets/custom_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class WorkerEditPage extends StatefulWidget {
  const WorkerEditPage({super.key});

  @override
  State<WorkerEditPage> createState() => _WorkerEditPageState();
}

class _WorkerEditPageState extends State<WorkerEditPage> {
  bool _isVisible = false;
  int currentTab = 0;
  Map<String, dynamic> _city_list = {};
  String _selectedCity = "";
  Map<String, dynamic> _area_list = {};
  String _selectedArea = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    UserModel currentUser = Provider.of<Auth>(context).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/TextLogo.png',
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 160.w,
                child: Column(
                  children: [
                    SizedBox(
                      width: 120.w,
                      height: 120.h,
                      child: Image.asset("assets/images/male.png"),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      child: Text(getRoleString(currentUser.role),
                          style: TextStyle(
                              color: primaryTextColor, fontSize: 16.sp)),
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
                    SizedBox(height: 5.h),
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
                                color: primaryTextColor, fontSize: 16.sp)),
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
                        SfCalendar(),
                        Container(),
                        buildPersonalSetting(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final timeController = TextEditingController();
  final addressController = TextEditingController();
  int _selectedAssign = 0;
  List<String> ASSIGN_LIST = ["同意", "不同意"];
  int _selectedSmoke = 0;
  List<String> SMOKE_LIST = ["是", "否"];
  Widget buildPersonalSetting() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Column(
              children: [
                context.emptySizedHeightBoxLow3x,
                CustomTextField(
                    readOnly: true,
                    labelText: "可施工時間",
                    controller: timeController,
                    onTap: () => setState(() {
                          _isVisible = !_isVisible;
                        }),
                    child: const Icon(Icons.timer)),
                Visibility(
                    visible: _isVisible,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: DatePickerWidget(
                        looping: true,
                        initialDate: DateTime.now(),
                        dateFormat: "yyyy-MM月-dd",
                        locale: DateTimePickerLocale.zh_cn,
                        onChange: (DateTime newDate, _) {
                          setState(() {
                            timeController.text =
                                DateFormat('yyyy-MM-dd').format(newDate);
                          });
                        },
                        pickerTheme: DateTimePickerTheme(
                          backgroundColor: Colors.transparent,
                          itemTextStyle:
                              TextStyle(color: Colors.black54, fontSize: 16.sp),
                          dividerColor: Colors.white,
                        ),
                      ),
                    )),
                context.emptySizedHeightBoxLow3x,
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 35.w),
                      child: Text('指定調派',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black)),
                    ),
                    DropdownButton2<int>(
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black87,
                          fontFamily: 'MicrosoftYaHei',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.w),
                      alignment: Alignment.centerLeft,
                      buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 35.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black26, width: 1.5),
                              borderRadius: BorderRadius.circular(30))),
                      value: _selectedAssign,
                      underline: Container(),
                      onChanged: (value) {
                        setState(() {
                          _selectedAssign = value!;
                        });
                      },
                      items: ASSIGN_LIST.map((String item) {
                        return DropdownMenuItem<int>(
                          value: ASSIGN_LIST.indexOf(item),
                          child: Text(
                            item,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      hint: const Text('可否接受指定調派'),
                    ),
                  ],
                ),
                context.emptySizedHeightBoxLow3x,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 35.w),
                      child: Text('是否有抽菸',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black)),
                    ),
                    DropdownButton2<int>(
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black87,
                          fontFamily: 'MicrosoftYaHei',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.w),
                      alignment: Alignment.centerLeft,
                      buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 35.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black26, width: 1.5),
                              borderRadius: BorderRadius.circular(30))),
                      value: _selectedSmoke,
                      underline: Container(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSmoke = value!;
                        });
                      },
                      items: SMOKE_LIST.map((String item) {
                        return DropdownMenuItem<int>(
                          value: SMOKE_LIST.indexOf(item),
                          child: Text(
                            item,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      hint: const Text('選擇狀態'),
                    ),
                  ],
                ),
                context.emptySizedHeightBoxLow3x,
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
