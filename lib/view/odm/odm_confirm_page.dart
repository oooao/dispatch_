
import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/view/odm/odm_sign_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';



// 2023/10 新畫面
class ODMConfirmPage extends StatefulWidget {
  final ODMModel model;
  final List<String> photoList;
  const ODMConfirmPage({
    super.key,
    required this.model,
    this.photoList = const [],
  });
  @override
  _ODMConfirmPageState createState() => _ODMConfirmPageState();
}

class _ODMConfirmPageState extends State<ODMConfirmPage> {
  late ODMModel model;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  void _handleClearButtonPressed() {
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
              padding: const EdgeInsets.only(top: 30.0),
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
                  padding: EdgeInsets.only(left: 80.w, right: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.emptySizedHeightBoxNormal,
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 40.0.w),
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
                      context.emptySizedHeightBoxNormal,
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 40.0.w),
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
                      context.emptySizedHeightBoxNormal,
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 40.0.w),
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
                      context.emptySizedHeightBoxNormal,
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 40.0.w),
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
                      context.emptySizedHeightBoxNormal,
                      context.emptySizedHeightBoxLow3x,
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 40.0.w),
                            child: Text("操作項目",
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
                              child: Text("${model.getTypeString()}",
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
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              // width: 180,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ODMSignPage(
                              model: widget.model,
                            )),
                  );
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
                  child: Text('我已確認以上需求無誤並同意送出申請',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xff0069ab),
                        fontFamily: 'MicrosoftYaHei',
                        letterSpacing: 2.w,
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
