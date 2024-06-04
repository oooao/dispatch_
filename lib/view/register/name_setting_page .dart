import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/view/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:form_validator/form_validator.dart';

class NameSettingPage extends StatefulWidget {
  final Function onCompleted;
  final UserModel model;
  final ValueChanged<UserModel> updateModel;
  const NameSettingPage(
      {super.key,
      required this.onCompleted,
      required this.model,
      required this.updateModel});

  @override
  State<NameSettingPage> createState() => _NameSettingPageState();
}

class _NameSettingPageState extends State<NameSettingPage> {
  bool isError = false;
  final _nameController = TextEditingController();
  final vaidator = ValidationBuilder().minLength(2).build();
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
    widget.model.name = _nameController.text;
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
                  onChanged: (value) {
                    isError = value.isEmpty ? true : false;
                  },
                  controller: _nameController,
                  style:
                      TextStyle(fontSize: 14.sp, fontFamily: 'MicrosoftYaHei'),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                    hintText: '用戶名稱',
                    hintStyle: isError
                        ? TextStyle(color: Colors.red, letterSpacing: 2.w)
                        : TextStyle(letterSpacing: 2.w),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Image.asset('assets/images/lines.png'),
                    ),
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
              if (!isError && _nameController.text.isNotEmpty) {
                completed();
              } else {
                EasyLoading.showError("請輸入名字！");
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
