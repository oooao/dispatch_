import 'dart:async';

import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/open_api.dart';
import 'package:dispatch/view/oem/upload_photo_page.dart';
import 'package:dispatch/view/widgets/custom_widgets.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class RequirementCheckListPage extends StatefulWidget {
  final OEMModel oemModel;
  const RequirementCheckListPage({super.key, required this.oemModel});

  @override
  _RequirementCheckListPageState createState() =>
      _RequirementCheckListPageState();
}

class _RequirementCheckListPageState extends State<RequirementCheckListPage> {
  late OEMModel oemModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController parkingController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  MultiSelectController noticeController = MultiSelectController();

  List<String> STATUS_LIST = ["請選擇現場狀態", "有住人", "空屋", "裝潢階段", "工地"];
  int _selectedStatus = 0;

  List<String> KEYS_LIST = ["請選擇鑰匙狀況", "警衛室", "屋主/設計師開門", "密碼鎖"];
  int _selectedKeys = 0;

  //改成複選
  List<ValueItem> NOTICE_LIST = const [
    ValueItem(label: "木地板", value: "1"),
    ValueItem(label: "木作烤漆/噴漆", value: "2"),
    ValueItem(label: "現有家具", value: "3"),
  ];
  String _selectedNotice = "";

  List<String> PARKING_LIST = ["請選擇是否有車位", "有車位", "無車位"];
  int _selectedParking = 0;

  Map<String, dynamic> _city_list = {};
  String _selectedCity = "";
  Map<String, dynamic> _area_list = {};
  String _selectedArea = "";

  @override
  void initState() {
    oemModel = widget.oemModel;
    super.initState();
    loadCountryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: buildForm(),
    );
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

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            context.sized.emptySizedHeightBoxLow3x,
            FormBackground(
              child: Container(
                padding: EdgeInsets.only(top: 40.h),
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      labelText: '施工時間*',
                      controller: dateController,
                      hinttext: "施工時間",
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '請選擇施工時間';
                        }
                        return null;
                      },
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year, 01),
                                lastDate: DateTime(2100, 12))
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              dateController.text =
                                  value.toString().split(" ").first;
                            });
                          } else {
                            setState(() {
                              dateController.text = "";
                            });
                          }
                        });
                      },
                    ),
                    context.sized.emptySizedHeightBoxNormal,
                    context.sized.emptySizedHeightBoxLow3x,
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
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.center,
                          buttonStyleData: ButtonStyleData(
                              width: 110.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1),
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
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.center,
                          buttonStyleData: ButtonStyleData(
                              height: 35.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1),
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
                      height: 8.h,
                    ),
                    CustomTextField(
                      hinttext: '請輸入地址',
                      labelText: '施工地點*',
                      controller: addressController,
                    ),
                    context.sized.emptySizedHeightBoxNormal,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 35.w),
                          child: Text('現場狀態*',
                              style: const TextStyle(
                                  //  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black)),
                        ),
                        DropdownButton2<int>(
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontFamily: 'MicrosoftYaHei',
                              //  fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.centerLeft,
                          buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              height: 35.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1),
                                  borderRadius: BorderRadius.circular(30))),
                          value: _selectedStatus,
                          underline: Container(),
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                          items: STATUS_LIST.map((String item) {
                            return DropdownMenuItem<int>(
                              value: STATUS_LIST.indexOf(item),
                              child: Text(
                                item,
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          hint: const Text('選擇現場狀態'),
                        ),
                      ],
                    ),
                    context.sized.emptySizedHeightBoxNormal,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 35.w),
                          child: Text('鑰匙*',
                              style: const TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black)),
                        ),
                        DropdownButton2<int>(
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              fontFamily: 'MicrosoftYaHei',
                              // fontWeight: FontWeight.bold,
                              letterSpacing: 3.w),
                          alignment: Alignment.centerLeft,
                          buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              height: 35.h,
                              width: 200.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black26, width: 1),
                                  borderRadius: BorderRadius.circular(30))),
                          value: _selectedKeys,
                          underline: Container(),
                          onChanged: (value) {
                            setState(() {
                              _selectedKeys = value!;
                            });
                          },
                          items: KEYS_LIST.map((String item) {
                            return DropdownMenuItem<int>(
                              value: KEYS_LIST.indexOf(item),
                              child: Text(
                                item,
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                          hint: const Text('請選擇鑰匙狀況'),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _selectedKeys == 3,
                      child: Column(
                        children: [
                          SizedBox(height: 8.w),
                          CustomTextField(
                            controller: passwordController,
                            hinttext: "請輸入密碼鎖密碼",
                          ),
                        ],
                      ),
                    ),
                    context.emptySizedHeightBoxLow3x,
                    //9/14注意事項改為複選
                    SizedBox(
                      //width: 250.w,
                      height: 35.h,
                      child: MultiSelectDropDown(
                        inputDecoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.circular(30)),
                        controller: noticeController,
                        onOptionSelected: (label) {
                          setState(() {
                            _selectedNotice = "";
                            for (var notice
                                in noticeController.selectedOptions) {
                              _selectedNotice += "${notice.label} ";
                            }
                            print(_selectedNotice);
                            ;
                          });
                        },
                        optionTextStyle: TextStyle(fontSize: 12.sp),
                        options: NOTICE_LIST,
                        selectionType: SelectionType.multi,
                        hint: "選擇現場注意須知(選填)",
                        hintColor: Colors.black,
                        hintStyle: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "MicrosoftYaHei",
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    //]),
                    context.sized.emptySizedHeightBoxLow3x,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Container(
                    //       alignment: Alignment.centerRight,
                    //       padding: EdgeInsets.only(right: 35.w),
                    //       child: Text('車位*',
                    //           style: const TextStyle(
                    //               //  fontWeight: FontWeight.bold,
                    //               fontSize: 13,
                    //               color: Colors.black)),
                    //     ),
                    //     DropdownButton2<int>(
                    //       style: TextStyle(
                    //           fontSize: 12.sp,
                    //           color: Colors.black87,
                    //           fontFamily: 'MicrosoftYaHei',
                    //           //   fontWeight: FontWeight.bold,
                    //           letterSpacing: 3.w),
                    //       alignment: Alignment.centerLeft,
                    //       buttonStyleData: ButtonStyleData(
                    //           padding: EdgeInsets.symmetric(horizontal: 10.w),
                    //           height: 35.h,
                    //           width: 200.w,
                    //           decoration: BoxDecoration(
                    //               border: Border.all(
                    //                   color: Colors.black26, width: 1),
                    //               borderRadius: BorderRadius.circular(30))),
                    //       value: _selectedParking,
                    //       underline: Container(),
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _selectedParking = value!;
                    //         });
                    //       },
                    //       items: PARKING_LIST.map((String item) {
                    //         return DropdownMenuItem<int>(
                    //           value: PARKING_LIST.indexOf(item),
                    //           child: Text(
                    //             item,
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         );
                    //       }).toList(),
                    //       hint: const Text('請選擇是否有車位'),
                    //     ),
                    //   ],
                    // ),
                    // Visibility(
                    //   visible: _selectedParking == 1,
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 8.h),
                    //       CustomTextField(
                    //         controller: parkingController,
                    //         hinttext: "請輸入車位號碼",
                    //         validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return '請輸入車位號碼';
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: 180.w,
              height: 50.w,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedStatus == 0) {
                        EasyLoading.showToast("請選擇現場狀態");
                        return;
                      }
                      if (_selectedKeys == 0) {
                        EasyLoading.showToast("請選擇鑰匙狀況");
                        return;
                      }
                      // if (_selectedNotice == 0) {
                      //   EasyLoading.showToast("請選擇現場注意須知");
                      //   return;
                      // }
                      if (_selectedParking == 0) {
                        EasyLoading.showToast("請選擇是否有車位");
                        return;
                      }
                      oemModel.city = _city_list[_selectedCity];
                      oemModel.area = _area_list[_selectedArea];
                      oemModel.address = addressController.text;
                      oemModel.date = (DateTime.parse(dateController.text)
                                  .millisecondsSinceEpoch /
                              1000)
                          .toStringAsFixed(0);
                      oemModel.situation = STATUS_LIST[_selectedStatus];
                      oemModel.key_info = KEYS_LIST[_selectedKeys];
                      oemModel.password = passwordController.text;
                      oemModel.notice = _selectedNotice;
                      oemModel.parking = PARKING_LIST[_selectedParking];
                      oemModel.parking_no = parkingController.text;
                      print(oemModel.toJson());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UploadPhotoPage(
                            oemModel: oemModel,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text('下一步', style: TextStyle(fontSize: 20.sp))),
            ),
            context.sized.emptySizedHeightBoxLow3x,
          ],
        ),
      ),
    );
  }
}
