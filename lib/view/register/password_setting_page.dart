import 'package:dispatch/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class PasswordSettingPage extends StatefulWidget {
  final ValueChanged<UserModel> updateModel;
  final UserModel model;
  final Function onCompleted;

  const PasswordSettingPage(
      {super.key,
      required this.onCompleted,
      required this.model,
      required this.updateModel});

  @override
  State<PasswordSettingPage> createState() => _PasswordSettingPageState();
}

class _PasswordSettingPageState extends State<PasswordSettingPage> {
  final _passwrodController = TextEditingController();
  final _confirmPasswrodController = TextEditingController();
  bool isPasswordError = false;
  bool isPasswordOk = false;
  bool isConfirmPasswordError = false;
  bool isConfirmPasswordOk = false;
  bool confirmPassword() {
    return _passwrodController.text.trim() ==
        _confirmPasswrodController.text.trim();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswrodController.dispose();
    _passwrodController.dispose();
    super.dispose();
  }

  //register ->next page
  void completed() {
    widget.model.password = _passwrodController.text;
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
              height: 39,
              child: TextFormField(
                  controller: _passwrodController,
                  onChanged: (value) {
                    setState(() {
                      isPasswordError = value.length < 6 ? true : false;
                      isPasswordOk = !isPasswordError;
                    });
                  },
                  style: TextStyle(fontSize: 14.sp, letterSpacing: 2.w),
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                    suffixIcon: isPasswordOk
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                    hintText: '設定註冊密碼',
                    hintStyle:
                        isPasswordError ? TextStyle(color: Colors.red) : null,
                    // isDense: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Image.asset('assets/images/lines.png'),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: isPasswordError
                          ? BorderSide(color: Colors.red, width: 2)
                          : isPasswordOk
                              ? BorderSide(color: Colors.green, width: 2)
                              : BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: isPasswordError
                          ? BorderSide(color: Colors.red, width: 2)
                          : isPasswordOk
                              ? BorderSide(color: Colors.green, width: 2)
                              : BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  )),
            ),
            // ),
            context.emptySizedHeightBoxLow3x,
            Container(
              height: 39,
              child: TextFormField(
                  enabled: isPasswordOk,
                  controller: _confirmPasswrodController,
                  onChanged: (value) {
                    setState(() {
                      isConfirmPasswordOk = confirmPassword();
                      isConfirmPasswordError = !isConfirmPasswordOk;
                    });
                  },
                  style: TextStyle(fontSize: 14.sp, letterSpacing: 2.w),
                  //controller: _textEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                    suffixIcon: isConfirmPasswordOk
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                    hintText: '再次輸入密碼',
                    hintStyle: isConfirmPasswordError
                        ? TextStyle(color: Colors.red)
                        : null,
                    isDense: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Image.asset('assets/images/lines.png'),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: isConfirmPasswordError
                          ? BorderSide(color: Colors.red, width: 2)
                          : isConfirmPasswordOk
                              ? BorderSide(color: Colors.green, width: 2)
                              : BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: isConfirmPasswordError
                          ? BorderSide(color: Colors.red, width: 2)
                          : isConfirmPasswordOk
                              ? BorderSide(color: Colors.green, width: 2)
                              : BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  )),
            ),
          ],
        ),
        context.emptySizedHeightBoxHigh,
        context.emptySizedHeightBoxNormal,
        SizedBox(
          width: 160.w,
          height: 50.sp,
          child: TextButton(
            style: TextButton.styleFrom(
              side: BorderSide(color: Colors.grey),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              if (isConfirmPasswordOk && isPasswordOk) {
                completed();
              }
              return;
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
