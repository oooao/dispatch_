import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(4, (index) {
      switch (index) {
        case 0:
          return page_1(context);
        case 1:
          return page_2(context);
        case 2:
          return page_3(context);
        case 3:
          return page_4(context);
        default:
          return Container();
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/aboutUs_background.png')),
          ),
          child: PageView(
            scrollDirection: Axis.vertical,
            children: [
              page_1(context),
              page_2(context),
              page_3(context),
              page_4(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget page_1(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15.h),
    height: MediaQuery.of(context).size.height,
    child: Column(
      children: [
        context.emptySizedHeightBoxNormal,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Image.asset(
            'assets/images/page1Title.png',
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Image.asset(
            'assets/images/OK.jpg',
            // width: 200,
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 30.h, left: 20.w),
            alignment: Alignment.centerLeft,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '【   ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13.sp)),
                    TextSpan(
                        text: '品牌故事',
                        style: TextStyle(
                            letterSpacing: 6.w,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 20.sp,
                            color: Colors.black)),
                    TextSpan(
                        text: ' 】',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13.sp))
                  ],
                ))),
        Container(
            padding: EdgeInsets.only(top: 5.h, left: 25.w, right: 20.w),
            alignment: Alignment.centerLeft,
            child: Text(
              '在這個快節奏的現代社會中，我們始終相信，時間是最珍貴的資源之一。\n為了讓顧客在排程工作上更加便利，於是乎在某年某月創立了吉時上工這個品牌。',
              textDirection: TextDirection.ltr,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.8.w,
                  fontFamily: 'MicrosoftYaHei',
                  fontSize: 11.sp,
                  height: 2.h),
            )),
        Container(
            padding: EdgeInsets.only(top: 30.h, left: 20.h),
            alignment: Alignment.centerLeft,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '【   ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13.sp)),
                    TextSpan(
                        text: '存在價值',
                        style: TextStyle(
                            letterSpacing: 6.w,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 20.sp,
                            color: Colors.black)),
                    TextSpan(
                        text: ' 】',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13.sp))
                  ],
                ))),
        Container(
            padding: EdgeInsets.only(top: 5.h, left: 25.w, right: 20.w),
            alignment: Alignment.centerLeft,
            child: Text(
              '吉時上工的存在價值在於以顧客為中心，讓顧客在排程工作上更加便利。\n我們深信，只有真正理解客戶的需求，才能提供最貼心、最有效的服務。\n客人的認知和需求是我們創立吉時上工的出發點，因此我們努力聆聽每一位客戶的聲音，不斷優化我們的平台，以滿足客戶日益多樣化的需求。',
              textDirection: TextDirection.ltr,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.8.w,
                  fontFamily: 'MicrosoftYaHei',
                  fontSize: 11.sp,
                  height: 2.h),
            )),
        context.emptySizedHeightBoxLow3x
      ],
    ),
  );
}

Widget page_2(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15.h),
    height: MediaQuery.of(context).size.height,
    child: Column(
      children: [
        context.emptySizedHeightBoxNormal,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Image.asset(
            'assets/images/page2Title.png',
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100.0.w,
                  height: 100.0.h,
                  decoration: const BoxDecoration(
                    color: Color(0xff0069ab),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/page2Icon1.png',
                        width: 35.w,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        '吉時效率',
                        style: TextStyle(
                            color: Color(0xffEFEFEF),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 100.0.w,
                  height: 100.0.h,
                  decoration: const BoxDecoration(
                    color: Color(0xffD9D9D9),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/page2Icon1.png',
                        width: 35.w,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        '專業培訓',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 100.0.w,
                  height: 100.0.w,
                  decoration: const BoxDecoration(
                    color: Color(0xfff1f1f1),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/page2Icon1.png',
                        color: Colors.grey,
                        width: 35.w,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        '卓越品質',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            )),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            alignment: Alignment.center,
            child: Text(
              '我們的「三大堅持」代表著我們對客戶的承諾，無論是在效率、培訓還是品質方面，我們都不會妥協。我們期待著能夠為您提供卓越的服務，並成為您成功路上的重要合作夥伴。',
              textDirection: TextDirection.ltr,
              softWrap: true,
              style: TextStyle(
                  letterSpacing: 2.8.w,
                  fontFamily: 'MicrosoftYaHei',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  height: 2.h),
            )),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/images/page2Image2.png',
              width: 100.w,
            )),
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/page2Image4.png',
                height: 200.h,
              ),
              Image.asset(
                'assets/images/page2Image5.png',
                height: 224.h,
              ),
              Image.asset(
                'assets/images/page2Image6.png',
                height: 224.h,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget page_3(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15.h),
    height: MediaQuery.of(context).size.height,
    child: Column(
      children: [
        context.emptySizedHeightBoxNormal,
        Container(
            padding: EdgeInsets.only(top: 30.h, left: 20.w),
            alignment: Alignment.centerLeft,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '【   ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13.sp)),
                    TextSpan(
                        text: '展望未來',
                        style: TextStyle(
                            letterSpacing: 6.w,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 20.sp,
                            color: Colors.black)),
                    TextSpan(
                        text: ' 】',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13.sp))
                  ],
                ))),
        Container(
            padding: EdgeInsets.only(top: 5.h, left: 25.w, right: 20.w),
            alignment: Alignment.centerLeft,
            child: Text(
              '未來，我們將持續致力於提供更簡便、更快速的平台，讓顧客能夠輕鬆安排工作，專注於更重要的項目及拓展新事業。\n我們將不斷引進新技術，不斷優化使用者體驗，並開發更智能化的功能，以滿足客戶不斷變化的需求。',
              textDirection: TextDirection.ltr,
              softWrap: true,
              style: TextStyle(
                  letterSpacing: 2.8.w,
                  fontFamily: 'MicrosoftYaHei',
                  fontSize: 11.sp,
                  height: 2.h,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
            child: Image.asset(
              'assets/images/page3Image1.png',
              width: 200,
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
            child: Image.asset(
              'assets/images/page3Image2.png',
              width: 300,
            )),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
            child: Image.asset(
              'assets/images/page3Image3.png',
              width: 300,
            )),
        Container(
            padding: EdgeInsets.only(top: 5.h, left: 25.w, right: 20.w),
            alignment: Alignment.centerLeft,
            child: Text(
              '感謝您們一直以來的辛勤付出和專業精神。是您們的奉獻，讓吉時上工能夠為客戶提供更優質、更便利的服務。\n您們的努力是我們取得成就的重要保障，讓我們攜手共創更加光明的未來。',
              textDirection: TextDirection.ltr,
              softWrap: true,
              style: TextStyle(
                  letterSpacing: 2.8.w,
                  fontFamily: 'MicrosoftYaHei',
                  fontSize: 11.sp,
                  height: 2.h,
                  fontWeight: FontWeight.bold),
            )),
      ],
    ),
  );
}

Widget page_4(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15.h),
    height: MediaQuery.of(context).size.height,
    child: Column(
      children: [
        context.emptySizedHeightBoxNormal,
        Container(
            padding: EdgeInsets.only(top: 30.h, left: 20.w),
            alignment: Alignment.centerLeft,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '【   ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13.sp)),
                    TextSpan(
                        text: '目前服務區域',
                        style: TextStyle(
                            letterSpacing: 6.w,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 20.sp,
                            color: Colors.black)),
                    TextSpan(
                        text: ' 】',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 13.w))
                  ],
                ))),
        Container(
            padding: EdgeInsets.only(top: 5.h, left: 25.w, right: 20.w),
            alignment: Alignment.centerLeft,
            child: Text(
              '新竹以北、台中為主\n\n其他縣市正在開發、籌備中！ \n如有其他縣市需要服務，歡迎直接聯繫客服，會再依單量為您安排。',
              textDirection: TextDirection.ltr,
              softWrap: true,
              style: TextStyle(
                  letterSpacing: 2.8.w,
                  fontFamily: 'MicrosoftYaHei',
                  fontSize: 11.sp,
                  height: 2.h,
                  fontWeight: FontWeight.bold),
            )),
        Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 80.h, left: 20.w),
            child: Image.asset(
              'assets/images/page4Image1.png',
            )),
      ],
    ),
  );
}
