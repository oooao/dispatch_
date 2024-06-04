import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:styled_text/styled_text.dart';

class PrivacyPage extends StatefulWidget {
  final bool isDesigner;
  const PrivacyPage({super.key, required this.isDesigner});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  bool confirm = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            context.emptySizedHeightBoxLow3x,
            Text(
              "隱私權政策",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            context.emptySizedHeightBoxLow3x,
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child: StyledText(
                      style: TextStyle(fontSize: 14.sp),
                      text: privacy,
                      tags: {
                        'bold': StyledTextTag(
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp)),
                      },
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => setState(() {
                  confirm = true;
                }),
                child: Text(
                  '本人已詳細閱讀並充分理解且同遵守以上',
                  style: TextStyle(
                      fontSize: 12.sp,
                      letterSpacing: 2.w,
                      color: Colors.black87),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  side: BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                  shape: StadiumBorder(),
                ),
              ),
            ),
            SizedBox(
              width: 120.w,
              height: 40.h,
              child: ElevatedButton(
                onPressed: confirm
                    ? () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage(
                                    isDesigner: widget.isDesigner,
                                  )),
                        );
                      }
                    : null,
                style: !confirm
                    ? ElevatedButton.styleFrom(
                        elevation: 0,
                        disabledBackgroundColor: Colors.white,
                        shape:
                            StadiumBorder(side: BorderSide(color: Colors.grey)))
                    : ElevatedButton.styleFrom(shape: StadiumBorder()),
                child: Text(
                  '開始註冊',
                  style: TextStyle(
                      color: confirm ? Colors.white : Color(0xff0069ab),
                      fontFamily: 'MicrosoftYaHei',
                      letterSpacing: 3.w,
                      fontSize: 16.sp),
                ),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
          ],
        ),
      ),
    );
  }
}
