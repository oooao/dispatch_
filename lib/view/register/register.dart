import 'dart:async';

import 'dart:ui';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/util/common.dart';

import 'package:dispatch/util/phoneVerify.dart';
import 'package:dispatch/view/login_page.dart';
import 'package:dispatch/view/register/address_setting_page.dart';
import 'package:dispatch/view/register/ballpainter.dart';
import 'package:dispatch/view/register/birth_setting_page.dart';
import 'package:dispatch/view/register/business%20card_setting_page.dart';

import 'package:dispatch/view/register/email_setting_page.dart';
import 'package:dispatch/view/register/name_setting_page%20.dart';
import 'package:dispatch/view/register/password_setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kartal/kartal.dart';

class RegisterPage extends StatefulWidget {
  final bool isDesigner;

  const RegisterPage({super.key, required this.isDesigner});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  var model = UserModel(role: "coustomer");
  final _textEditingController = TextEditingController();
  late AnimationController _animation;
  late Animation<double> radian1;
  late Animation<double> radianRightX;
  late Animation<double> radian2;
  late Animation<double> radian3;
  late Animation<double> radianLeftX;
  late Animation<double> radianDown;
  late Animation<double> radianExpand;
  final phoneController = TextEditingController();
  String phoneNumber = "";
  bool clearText = false;
  String smsOTP = "";
  String verificationId = "";
  String errorMessage = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool resend = false;
  late int index;
  bool verified = false;

  @override
  void initState() {
    super.initState();
    index = widget.isDesigner ? 0 : 1;
    _animation = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    ); // 不斷重複

    radian1 = Tween<double>(begin: 0, end: 0.5).animate(CurvedAnimation(
      // 使用 CurvedAnimation
      parent: _animation,
      curve: Interval(0, 0.2, curve: Curves.easeIn),
    ));
    radianRightX = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      // 使用 CurvedAnimation
      parent: _animation,
      curve: Interval(0, 0.35, curve: Curves.linear),
    ));
    radian2 = Tween<double>(begin: 1, end: 0.65).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.2, 0.35, curve: Curves.easeOut),
    ));
    radian3 = Tween<double>(begin: 0.65, end: 1).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.35, 0.8, curve: Curves.bounceOut),
    ));
    radianLeftX = Tween<double>(begin: 1, end: 0.55).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.35, 0.8, curve: Curves.linear),
    ));
    radianDown = Tween<double>(begin: 1, end: 1.5).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.8, 1, curve: Curves.linear),
    ));
    radianExpand =
        Tween<double>(begin: 45.h, end: 750.h).animate(CurvedAnimation(
      parent: _animation,
      curve: Interval(0.9, 1, curve: Curves.linear),
    ));
    _animation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff186097),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: radian1.value != 0.5
                      ? Offset(
                          radianRightX.value *
                              (MediaQuery.of(context).size.width - 45),
                          100 +
                              (2 *
                                  radian1.value *
                                  (MediaQuery.sizeOf(context).height - 145)))
                      : radian2.value != 0.65
                          ? Offset(
                              radianRightX.value *
                                  (MediaQuery.of(context).size.width - 45),
                              radian2.value *
                                  (MediaQuery.sizeOf(context).height - 45))
                          : radian3.value != 1
                              ? Offset(
                                  radianLeftX.value *
                                      (MediaQuery.of(context).size.width - 45),
                                  radian3.value *
                                      (MediaQuery.sizeOf(context).height - 45))
                              : Offset(
                                  radianLeftX.value *
                                      (MediaQuery.sizeOf(context).width - 45),
                                  radianDown.value *
                                      (MediaQuery.sizeOf(context).height - 45)),
                  child: CustomPaint(
                    painter: BallPainter(x: 0, y: 0, cSize: radianExpand.value),
                    child: Container(),
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: index == 0 ? 320.w : 270.w,
                    child: registerStep(index)),
              ],
            ),
            Positioned(
                top: 50.h,
                left: 18.w,
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/back.png',
                    width: 23,
                  ),
                  onPressed: () {
                    previousPage();
                  },
                )),
          ],
        ));
  }

  @override
  void dispose() {
    // _controller.dispose();
    _animation.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void nextPage() {
    setState(() {
      index++;
    });
    if (index == 7) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      EasyLoading.showSuccess('註冊成功！');
    }
  }

  void previousPage() {
    index--;
    if (index < 1) {
      if (!widget.isDesigner) {
        Navigator.of(context).pop();
        return;
      }
      if (index < 0) {
        Navigator.of(context).pop();
      }
    }
    setState(() {
      
    });
  }

  void updateUserInfomation(UserModel newModel) {
    setState(() {
      model = newModel;
    });
  }

  Widget registerStep(int index) {
    switch (index) {
      case 0:
        return BusinessCardSettingPage(
          onCompleted: nextPage,
          model: model,
          updateModel: updateUserInfomation,
        );
      case 1:
        return phone_verification_page();
      // return
      case 2:
        return PasswordSettingPage(
          onCompleted: nextPage,
          updateModel: updateUserInfomation,
          model: model,
        );
      case 3:
        return NameSettingPage(
          onCompleted: nextPage,
          model: model,
          updateModel: updateUserInfomation,
        );
      case 4:
        return AddressSettingPage(
          onCompleted: nextPage,
          model: model,
          updateModel: updateUserInfomation,
        );
      case 5:
        return BirthSettingPage(
          onCompleted: nextPage,
          model: model,
          updateModel: updateUserInfomation,
        );
      case 6:
        return EmailSettingPage(
          onCompleted: nextPage,
          model: model,
          updateModel: updateUserInfomation,
        );

      default:
        return Container();
    }
  }

  Widget phone_verification_page() {
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)),
              height: 39.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/prefix_+886.png',
                    width: 60.w,
                  ),
                  Container(
                    width: 150.w,
                    child: TextFormField(
                      enabled: !resend,
                      onTap: () {
                        _animation.forward(from: 1);
                        //expandController.forward(from: 1);
                      },
                      style: TextStyle(fontSize: 13, letterSpacing: 2.w),
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(bottom: 15.h),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            Container(
              height: 39.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(
                    flex: 5,
                  ),
                  Image.asset(
                    'assets/images/prefix_auth.png',
                    width: 60.w,
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0.h, right: 20.w),
                    child: OtpTextField(
                      clearText: clearText,
                      onSubmit: (value) => {
                        if (value.length == 6)
                          {
                            setState(
                              () {
                                smsOTP = value;
                                print(smsOTP);
                                verified = true;
                              },
                            )
                          }
                      },
                      enabled: resend ? true : false,
                      //margin: EdgeInsets.only(bottom: 5, right: 8),
                      fieldWidth: 15.w,
                      enabledBorderColor: Colors.grey,
                      borderColor: Colors.grey,
                      numberOfFields: 6,
                      textStyle: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  )
                ],
              ),
            ),
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
            onPressed: () async {
              if (verified) {
                //print("verificationId2:${verificationId}");
                //if (await Authentication(verificationId, smsOTP))
                  setState(() {
                    index++;
                    model.phone = phoneNumber;
                  });
              } else if (!resend) {
                //verifyPhone();
                setState(() {
                  resend = true;
                });
                phoneNumber = phoneController.text;
              }
            },
            child: Text(
              resend ? '下一步' : '寄送驗證碼',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'MicrosoftYaHei',
                letterSpacing: 3,
              ),
            ),
          ),
        ),
        context.emptySizedHeightBoxHigh
      ],
    );
  }

  Future<void> verifyPhone() async {
    String phone = phoneController.text;
    smsOTPSent(String verId, int? forceCodeResend) {
      verificationId = verId;
      print("[DEBUG] smsOTPSent, verificationId = $verificationId");
      EasyLoading.dismiss();
    }

    try {
      if (!phone.startsWith("+") &&
          (phone.length != 10 || !phone.startsWith("0"))) {
        EasyLoading.showError("請輸入10碼行動電話號碼");
        return;
      }
      if (phone.startsWith("0")) {
        phone = phone.replaceFirst("0", "+886");
      }
      EasyLoading.show();

      print("[DEBUG] verifyPhoneNumber: $phone");
      await _auth.verifyPhoneNumber(
          phoneNumber: phone, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            verificationId = verId;
            print("[DEBUG] verificationId = $verificationId");
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print("[DEBUG] phoneAuthCredential = $phoneAuthCredential");
            EasyLoading.dismiss();
          },
          verificationFailed: (exceptio) {
            print('${exceptio.message}');
            print("[DEBUG] exceptio: ${exceptio.message}");
            EasyLoading.dismiss();
          });
    } catch (e) {
      print(e);
    }
  }
}
