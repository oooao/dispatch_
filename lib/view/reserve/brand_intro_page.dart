import 'package:dispatch/view/register/ballpainter.dart';
import 'package:dispatch/view/reserve/plate_intro_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class BrandIntroPage extends StatelessWidget {
  const BrandIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
          //padding: EdgeInsets.only(top: 30.h),

          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
              '系統板材',
              style: TextStyle(
                  fontSize: 22, fontFamily: 'MicrosoftYaHei', letterSpacing: 5),
            ),
          ),
          FormBackground(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    '鼎緒專業系統櫥櫃',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: 'MicrosoftYaHei',
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Image.asset(
                      'assets/images/dingxl.png',
                      width: 150,
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfff1f1f1),
                      shape: CircleBorder()),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlateIntroPage()));
                  },
                  child: Icon(
                    Icons.link,
                    color: Colors.grey,
                  ),
                ),
              ),
              context.emptySizedWidthBoxNormal,
              SizedBox(
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfff1f1f1),
                      shape: CircleBorder()),
                  onPressed: () {},
                  child: Icon(
                    Icons.phone_in_talk_outlined,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
