import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/util/phoneVerify.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class ODMVerifyPage extends StatefulWidget {
  final List<String> photoList;
  final ODMModel model;
  final String verId;
  const ODMVerifyPage(
      {super.key,
      required this.model,
      required this.verId,
      this.photoList = const []});
  @override
  _ODMVerifyPageState createState() => _ODMVerifyPageState();
}

class _ODMVerifyPageState extends State<ODMVerifyPage> {
  late ODMModel model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String verId = "";
  String smsOTP = "";
  bool verified = false;
  bool _isButtonDisabled = false;
  int _countdownSeconds = 30;

  @override
  void initState() {
    model = widget.model;
    super.initState();
    print("${widget.verId}");
    verId = widget.verId;
  }

  void _startCountdown() {
    if (!_isButtonDisabled) {
      setState(() {
        _isButtonDisabled = true;
      });

      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownSeconds > 0) {
            _countdownSeconds--;
          } else {
            _isButtonDisabled = false;
            timer.cancel();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0.h),
              child: Text(
                '驗證碼認證',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 5,
                ),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            Expanded(
              child: SingleChildScrollView(
                child: FormBackground(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 35.w, right: 35.w),
                    child: Column(
                      children: [
                        context.emptySizedHeightBoxHigh,
                        Text(
                          '驗證碼以傳送至裝置',
                          style: TextStyle(
                              fontFamily: 'MicrosoftYaHei', letterSpacing: 2),
                        ),
                        context.emptySizedHeightBoxNormal,
                        context.emptySizedHeightBoxLow3x,
                        Container(
                          width: 270.w,
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
                                padding:
                                    EdgeInsets.only(bottom: 8.0.h, right: 20.w),
                                child: OtpTextField(
                                  //clearText: clearText,
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
                        context.emptySizedHeightBoxHigh,
                        context.emptySizedHeightBoxNormal,
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: _isButtonDisabled
                                  ? null
                                  : () async {
                                      verId = await verifyPhone(
                                          model.phone, context, null, null);
                                      _startCountdown();
                                    },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.black26)),
                                backgroundColor: Colors.white,
                              ),
                              child: Text(
                                '重新寄送驗證碼',
                                style: TextStyle(
                                    color: Color(0xff0069ab),
                                    fontFamily: 'MicrosoftYaHei'),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
              child: ElevatedButton(
                onPressed: verified
                    ? () async {
                        if (verId.isNotEmpty) if (await Authentication(
                            verId, smsOTP))
                          await WebAPI().sendODMRequest(context, model);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.white,
                  elevation: 0.5,
                  backgroundColor: Color(0xff0069ab),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Text('下一步',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: verified ? Colors.white : Color(0xff0069ab),
                        fontFamily: 'MicrosoftYaHei',
                        letterSpacing: 8.w,
                      )),
                ),
              ),
            ),
            context.emptySizedHeightBoxNormal,
          ],
        ),
      ),
    );
  }
}
