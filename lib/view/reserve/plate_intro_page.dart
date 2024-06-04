import 'package:dispatch/view/reserve/plate_list_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class PlateIntroPage extends StatefulWidget {
  const PlateIntroPage({super.key});

  @override
  _PlateIntroPageState createState() => _PlateIntroPageState();
}

class _PlateIntroPageState extends State<PlateIntroPage> {
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/TextLogo.png'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            context.emptySizedHeightBoxLow3x,
            Text(
              '系統板材',
              style: TextStyle(
                  letterSpacing: 3.w,
                  fontSize: 20.sp,
                  fontFamily: 'MicrosoftYaHei'),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              margin: EdgeInsets.only(bottom: 40.h),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 2 / 3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/plate_intro_background.png'),
                      fit: BoxFit.fitWidth)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  context.emptySizedHeightBoxNormal,
                  Text(
                    '板材花色',
                    style: TextStyle(fontSize: 24.sp, letterSpacing: 10.w),
                  ),
                  SizedBox(
                    height: 33.h,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlateListPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "瞭解更多",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'MicrosoftYaHei',
                                  letterSpacing: 5),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.h),
                              child: Image.asset(
                                'assets/images/arrow.png',
                                color: Color(0xff0069ab),
                                width: 10.w,
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

//Tab分頁模板
// Container(
//           child: DefaultTabController(
//             length: 2,
//             child: Column(
//               children: [
//                 context.emptySizedHeightBoxLow,
//                 Container(
//                   height: 40,
//                   // width: MediaQuery.of(context).size.width - 60.w,
//                   decoration: BoxDecoration(
//                       color: Color(0xffE5E4E4),
//                       borderRadius: BorderRadius.circular(8)),
//                   child: TabBar(
//                     isScrollable: true,
//                     labelStyle: TextStyle(
//                         letterSpacing: 5.w,
//                         color: Colors.black,
//                         fontFamily: 'MicrosoftYaHei'),
//                     indicator: BoxDecoration(
//                       color: Color(0xffa7b6cc),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     labelColor: Colors.black,
//                     unselectedLabelColor: Colors.black,
//                     tabs: [
//                       Tab(
//                         child: Container(
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.symmetric(horizontal: 30.w),
//                           child: Text(
//                             '吉時版材',
//                             style: TextStyle(fontSize: 16.sp),
//                           ),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.symmetric(horizontal: 30.w),
//                           child: Text(
//                             '表單查看',
//                             style: TextStyle(fontSize: 16.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                     onTap: (value) {
//                       setState(() {
//                         currentTab = value;
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       buildPlateIntro(),
//                       Container(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )