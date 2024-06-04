import 'package:dispatch/view/register/privacy_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class IdentitySelectionPage extends StatefulWidget {
  const IdentitySelectionPage({super.key});

  @override
  State<IdentitySelectionPage> createState() => _IdentitySelectionPageState();
}

class _IdentitySelectionPageState extends State<IdentitySelectionPage> {
  bool isdesigner = false;
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: isdesigner
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 50.h,
                          right: 0,
                          child: SelectionCard(
                              Image.asset('assets/images/customer_card.png'),
                              '一般客戶',
                              false),
                        ),
                        Positioned(
                          top: 50.h,
                          left: 0,
                          child: SelectionCard(
                              Image.asset(
                                'assets/images/designer_card.png',
                              ),
                              '設計師',
                              true),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 50.h,
                          left: 0,
                          child: SelectionCard(
                              Image.asset(
                                'assets/images/designer_card.png',
                              ),
                              '設計師',
                              true),
                        ),
                        Positioned(
                          bottom: 50.h,
                          right: 0,
                          child: SelectionCard(
                              Image.asset('assets/images/customer_card.png'),
                              '一般客戶',
                              false),
                        ),
                      ],
                    ),
                  )),
        SizedBox(
          width: 130.w,
          height: 45.h,
          child: ElevatedButton(
            onPressed: isSelected
                ? () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyPage(
                            isDesigner: isdesigner,
                          ),
                        ));
                  }
                : null,
            style: !isSelected
                ? ElevatedButton.styleFrom(
                    elevation: 0,
                    disabledBackgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: Colors.grey,
                        )))
                : ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
            child: Text(
              '確認',
              style: TextStyle(
                  fontFamily: 'MicrosoftYaHei',
                  letterSpacing: 12.w,
                  fontSize: 18.sp,
                  color: isSelected ? Colors.white : Color(0xff0069ab)),
            ),
          ),
        ),
        context.emptySizedHeightBoxLow3x,
        Text('@吉時上工',
            style: TextStyle(
                color: Colors.grey,
                fontFamily: 'MicrosoftYaHei',
                fontSize: 12.sp)),
      ],
    );
  }

  Widget SelectionCard(Widget image, String title, bool designer) {
    return SizedBox(
      height: 390.h,
      width: 260.w,
      child: TextButton(
          style: (isdesigner == designer && isSelected)
              ? TextButton.styleFrom(
                  shadowColor: Color(0xff000000),
                  elevation: 15,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0xff0069ab), width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)))
              : TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xfff1f1f1),
                  side: BorderSide(color: Color(0xffD9D9D9), width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
          onPressed: () {
            setState(() {
              isSelected = true;
              isdesigner = designer;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: image),
              Padding(
                padding: EdgeInsets.only(bottom: 28.0.h),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Color(0xff0069ab),
                      fontFamily: 'MicrosoftYaHei',
                      letterSpacing: 4.w,
                      fontSize: 16.sp),
                ),
              )
            ],
          )),
    );
  }
}
