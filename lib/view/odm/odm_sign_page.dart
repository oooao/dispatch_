import 'dart:convert';
import 'dart:typed_data';
import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/util/phoneVerify.dart';
import 'package:dispatch/view/odm/odm_verify_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'dart:ui' as ui;

class ODMSignPage extends StatefulWidget {
  final List<String> photoList;
  final ODMModel model;

  const ODMSignPage(
      {super.key, required this.model, this.photoList = const []});
  @override
  _ODMSignPageState createState() => _ODMSignPageState();
}

class _ODMSignPageState extends State<ODMSignPage> {
  late ODMModel model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  bool isSigned = false;
  bool confirm = false;
  DateTime signDate = DateTime.now();
  

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  void _handleClearButtonPressed() {
    isSigned = false;
    signatureGlobalKey.currentState!.clear();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                'ODM表單確認',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 5,
                ),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            Expanded(
              child: FormBackground(
                child: Container(
                  padding: EdgeInsets.only(left: 35.w, right: 35.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.emptySizedHeightBoxNormal,
                      context.emptySizedHeightBoxLow,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50.w, right: 40.0.w),
                            child: Text("業主名稱",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'MicrosoftYaHei',
                                    letterSpacing: 2.5.sp)),
                          ),
                          Image.asset(
                            'assets/images/lines.png',
                            height: 12.h,
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: Text("${model.name}",
                                  textDirection: TextDirection.ltr,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: 'MicrosoftYaHei',
                                      letterSpacing: 2.5.sp)),
                            ),
                          ),
                        ],
                      ),
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50.w, right: 40.0.w),
                            child: Text("施工地點",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'MicrosoftYaHei',
                                    letterSpacing: 2.5.sp)),
                          ),
                          Image.asset(
                            'assets/images/lines.png',
                            height: 12.h,
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: Text("${model.address}",
                                  textDirection: TextDirection.ltr,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: 'MicrosoftYaHei',
                                      letterSpacing: 2.5.sp)),
                            ),
                          ),
                        ],
                      ),
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50.w, right: 40.0.w),
                            child: Text("聯絡時間",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'MicrosoftYaHei',
                                    letterSpacing: 2.5.sp)),
                          ),
                          Image.asset(
                            'assets/images/lines.png',
                            height: 12.h,
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: Text(
                                  "${DateTime.fromMillisecondsSinceEpoch(int.parse(model.date) * 1000).toString().split(" ").first}",
                                  textDirection: TextDirection.ltr,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: 'MicrosoftYaHei',
                                      letterSpacing: 2.5.sp)),
                            ),
                          ),
                        ],
                      ),
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50.w, right: 40.0.w),
                            child: Text("聯絡電話",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'MicrosoftYaHei',
                                    letterSpacing: 2.5.sp)),
                          ),
                          Image.asset(
                            'assets/images/lines.png',
                            height: 12.h,
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: Text("${model.phone}",
                                  textDirection: TextDirection.ltr,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontFamily: 'MicrosoftYaHei',
                                      letterSpacing: 2.5.sp)),
                            ),
                          ),
                        ],
                      ),
                      context.emptySizedHeightBoxLow3x,
                      Container(
                        height: MediaQuery.of(context).size.height / 4 - 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SfSignaturePad(
                            key: signatureGlobalKey,
                            minimumStrokeWidth: 1,
                            maximumStrokeWidth: 5,
                            strokeColor: Colors.black54,
                            onDrawStart: () {
                              isSigned = true;
                              return false;
                            },
                          ),
                        ),
                      ),
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: null, child: Container()),
                          Text(
                            "請在方框中簽名\n以確保自身權益!",
                            style: TextStyle(
                              height: 2.h,
                              color: Colors.black,
                              fontFamily: 'MicrosoftYaHei',
                              fontSize: 12.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _handleClearButtonPressed();
                            },
                            child: Text(
                              "清除",
                              style: TextStyle(
                                fontFamily: 'MicrosoftYaHei',
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  if (isSigned == false) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('請在簽名板上簽名！'),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  final data = await signatureGlobalKey.currentState!
                      .toImage(pixelRatio: 3.0);

                  final bytes =
                      await data.toByteData(format: ui.ImageByteFormat.png);
                  Uint8List imageData = bytes!.buffer.asUint8List();

                  model.photos = widget.photoList;
                  model.signature = base64.encode(imageData);
                  print(model.signature);
                  await verifyPhone(
                      model.phone, context, "ODMVerifyPage", model);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.5,
                  backgroundColor: Colors.white,
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
                        color: Color(0xff0069ab),
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
