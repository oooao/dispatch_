import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/util/open_api.dart';
import 'package:dispatch/view/register/register.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:form_validator/form_validator.dart';

class AddressSettingPage extends StatefulWidget {
  final Function onCompleted;
  final UserModel model;
  final ValueChanged<UserModel> updateModel;

  const AddressSettingPage(
      {super.key,
      required this.onCompleted,
      required this.model,
      required this.updateModel});

  @override
  State<AddressSettingPage> createState() => _AddressSettingPageState();
}

class _AddressSettingPageState extends State<AddressSettingPage> {
  bool isError = false;
  final _addressController = TextEditingController();
  Map<String, dynamic> _city_list = {};
  String _selectedCity = "";
  Map<String, dynamic> _area_list = {};
  String _selectedArea = "";

  @override
  void initState() {
    super.initState();
    loadCountryList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //register ->next page
  void completed() {
    // 11/13 add city & area
    widget.model.city = _city_list[_selectedCity];
    widget.model.area = _area_list[_selectedArea];
    widget.model.address = _addressController.text;
    widget.updateModel(widget.model);
    widget.onCompleted();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              'assets/images/TextLogo.png',
              width: 100.w,
            ),
            context.emptySizedHeightBoxNormal,
            context.emptySizedHeightBoxLow,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton2(
                  underline: Container(),
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'MicrosoftYaHei',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 3),
                  alignment: Alignment.center,
                  iconStyleData: IconStyleData(icon: Container()),
                  buttonStyleData: ButtonStyleData(
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffffffff), width: 3),
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
                  hint: const Text('聯絡地址(縣市)'),
                ),
                SizedBox(width: 5.w),
                DropdownButton2(
                  underline: Container(),
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'MicrosoftYaHei',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 3),
                  alignment: Alignment.center,
                  iconStyleData: IconStyleData(icon: Container()),
                  buttonStyleData: ButtonStyleData(
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffffffff), width: 3),
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
                  hint: const Text('選擇地區'),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 39.h,
              child: TextFormField(
                  onChanged: (value) {
                    isError = value.isEmpty ? true : false;
                  },
                  controller: _addressController,
                  style:
                      TextStyle(fontSize: 14.sp, fontFamily: 'MicrosoftYaHei'),
                  decoration: InputDecoration(
                    hintText: '(路/巷/弄/街)',
                    hintStyle: isError
                        ? TextStyle(color: Colors.red, letterSpacing: 2)
                        : TextStyle(letterSpacing: 2),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 1.h),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: isError
                          ? BorderSide(color: Colors.red, width: 2)
                          : BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: isError
                          ? BorderSide(color: Colors.red, width: 2)
                          : BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  )),
            ),
            // ),
            context.emptySizedHeightBoxLow3x,
          ],
        ),
        context.emptySizedHeightBoxHigh,
        context.emptySizedHeightBoxNormal,
        SizedBox(
          width: 160.w,
          height: 50.h,
          child: TextButton(
            style: TextButton.styleFrom(
              side: BorderSide(color: Colors.grey),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              if (!isError && _addressController.text.isNotEmpty) {
                completed();
              } else {
                EasyLoading.showError("請輸入正確地址！");
              }
            },
            child: Text(
              '下一步',
              style: TextStyle(
                fontFamily: 'MicrosoftYaHei',
                letterSpacing: 3.w,
              ),
            ),
          ),
        ),
        context.emptySizedHeightBoxHigh
      ],
    );
  }
}
