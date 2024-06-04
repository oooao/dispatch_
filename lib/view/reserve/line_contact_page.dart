import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/odm/odm_confirm_page.dart';
import 'package:dispatch/view/odm/pre_requirement_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LineContactPage extends StatefulWidget {
  const LineContactPage({
    super.key,
  });
  @override
  _LineContactPageState createState() => _LineContactPageState();
}

class _LineContactPageState extends State<LineContactPage> {
  int options = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              '系統板材',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 5,
              ),
            ),
          ),
          context.emptySizedHeightBoxLow3x,
          FormBackground(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              context.sized.emptySizedHeightBoxNormal,
              Image.asset(
                'assets/images/line.png',
                width: 70.w,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfffafafa),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  '將有專人為你服務！！\nLine客服專員',
                  style: TextStyle(letterSpacing: 2.5,fontFamily: 'MicrosoftYaHei',height: 3),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 50.w),
                child: Image.asset(
                  'assets/images/odm_intro_boy.png',
                  width: 100.w,
                ),
              ),
              context.sized.emptySizedHeightBoxNormal
            ],
          )),
          SizedBox(
            height: 45.h,
            child: ElevatedButton(
              onPressed: () {
                launchUrlString(line_url, mode: LaunchMode.externalApplication);
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
                child: Text('前往客服',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff0069ab),
                      fontFamily: 'MicrosoftYaHei',
                      letterSpacing: 8.w,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
