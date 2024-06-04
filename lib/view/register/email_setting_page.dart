import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/view/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:form_validator/form_validator.dart';

class EmailSettingPage extends StatefulWidget {
  final Function onCompleted;
  final UserModel model;
  final ValueChanged<UserModel> updateModel;

  const EmailSettingPage(
      {super.key,
      required this.onCompleted,
      required this.model,
      required this.updateModel});

  @override
  State<EmailSettingPage> createState() => _EmailSettingPageState();
}

class _EmailSettingPageState extends State<EmailSettingPage> {
  final _emailController = TextEditingController();
  bool isEmailError = false;
  bool isEmailOk = false;
  final vaidator = ValidationBuilder().email().maxLength(50).build();
  @override
  void initState() {
    super.initState();
    print(widget.model.password);
  }

  @override
  void dispose() {
    super.dispose();
  }

  //register ->next page
  void completed() async {
    widget.model.email = _emailController.text;
    widget.updateModel(widget.model);
    if (await WebAPI().userSignUp(context, widget.model)) {
      widget.onCompleted();
    }
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
                  controller: _emailController,
                  onChanged: (value) {
                    setState(() {
                      isEmailError = vaidator(value) == null ? false : true;
                      isEmailOk = !isEmailError;
                    });
                  },
                  style: TextStyle(fontSize: 14.sp, letterSpacing: 1.w),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                    suffixIcon: isEmailOk
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                    hintText: '電子郵件(綁定會員密碼)',
                    hintStyle:
                        isEmailError ? TextStyle(color: Colors.red) : null,
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Image.asset('assets/images/lines.png'),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: isEmailError
                          ? BorderSide(color: Colors.red, width: 2)
                          : isEmailOk
                              ? BorderSide(color: Colors.green, width: 2)
                              : BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: isEmailError
                          ? BorderSide(color: Colors.red, width: 2)
                          : isEmailOk
                              ? BorderSide(color: Colors.green, width: 2)
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
              if (isEmailOk) {
                completed();
              } else {
                EasyLoading.showError("請輸入正確信箱！");
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
