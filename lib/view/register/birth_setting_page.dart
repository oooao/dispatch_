import 'package:bottom_picker/resources/arrays.dart';
import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:intl/intl.dart';

class BirthSettingPage extends StatefulWidget {
  final Function onCompleted;
  final UserModel model;
  final ValueChanged<UserModel> updateModel;

  const BirthSettingPage(
      {super.key,
      required this.onCompleted,
      required this.model,
      required this.updateModel});

  @override
  State<BirthSettingPage> createState() => _BirthSettingPageState();
}

class _BirthSettingPageState extends State<BirthSettingPage> {
  bool isError = false;
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //register ->next page
  void completed() {
    widget.model.birthday=
        (DateTime.parse(_dateController.text).millisecondsSinceEpoch / 1000)
            .toStringAsFixed(0);
    print("${widget.model.birthday}");
    widget.updateModel(widget.model);
    widget.onCompleted(); 
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
            SizedBox(
              height: 39.h,
              child: TextFormField(
                  readOnly: true,
                  onChanged: (value) {
                    isError = value.isEmpty ? true : false;
                  },
                  controller: _dateController,
                  style:
                      TextStyle(fontSize: 14.sp, fontFamily: 'MicrosoftYaHei'),
                  onTap: () => setState(() {
                        _isVisible = !_isVisible;
                      }),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                      ),
                      onPressed: () => setState(() {
                        _isVisible = !_isVisible;
                      }),
                    ),
                    prefixIcon:Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Image.asset('assets/images/lines.png'),
                          ),
                    hintText: '出生年月日',

                    // isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  )),
            ),
            SizedBox(
              height: 1,
            ),
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
                        _dateController.text =
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
              if (!isError && _dateController.text.isNotEmpty) {
                completed();
              } else {
                EasyLoading.showError("請輸入日期！");
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
