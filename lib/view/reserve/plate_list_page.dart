import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/view/odm/odm_confirm_page.dart';
import 'package:dispatch/view/odm/pre_requirement_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class PlateListPage extends StatefulWidget {
  const PlateListPage({
    super.key,
  });
  @override
  _PlateListPageState createState() => _PlateListPageState();
}

class _PlateListPageState extends State<PlateListPage> {
  int options = 0;

  @override
  void initState() {
    super.initState();
  }

  void nextPage() {
    switch (options) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
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
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 50,
                childAspectRatio: 200.w / 45.h,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 100.h),
                children: [
                  InkWell(
                    onTap: () => setState(() {
                      options = 1;
                    }),
                    child: Container(
                      width: 170,
                      alignment: Alignment.center,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: options == 1 ? Color(0xff0069ab) : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: options == 1 ? Colors.grey : Colors.black26,
                        ),
                      ),
                      child: Text(
                        '石紋系列',
                        style: TextStyle(
                            color:
                                options == 1 ? Colors.white : Color(0xff0069ab),
                            letterSpacing: 4,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      options = 2;
                    }),
                    child: Container(
                      width: 170,
                      alignment: Alignment.center,
                      height: 45.h,
                      decoration: BoxDecoration(
                          color:
                              options == 2 ? Color(0xff0069ab) : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color:
                                  options == 2 ? Colors.grey : Colors.black26)),
                      child: Text(
                        '木紋系列',
                        style: TextStyle(
                            color:
                                options == 2 ? Colors.white : Color(0xff0069ab),
                            letterSpacing: 4,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      options = 3;
                    }),
                    child: Container(
                      width: 170,
                      alignment: Alignment.center,
                      height: 45.h,
                      decoration: BoxDecoration(
                          color:
                              options == 3 ? Color(0xff0069ab) : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color:
                                  options == 3 ? Colors.grey : Colors.black26)),
                      child: Text(
                        '布紋系列',
                        style: TextStyle(
                            color:
                                options == 3 ? Colors.white : Color(0xff0069ab),
                            letterSpacing: 4,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      options = 4;
                    }),
                    child: Container(
                      width: 170,
                      alignment: Alignment.center,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: options == 4 ? Color(0xff0069ab) : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: options == 4 ? Colors.grey : Colors.black26,
                        ),
                      ),
                      child: Text(
                        '純色系列',
                        style: TextStyle(
                            color:
                                options == 4 ? Colors.white : Color(0xff0069ab),
                            letterSpacing: 4,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      options = 5;
                    }),
                    child: Container(
                      width: 170,
                      alignment: Alignment.center,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: options == 5 ? Color(0xff0069ab) : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: options == 5 ? Colors.grey : Colors.black26,
                        ),
                      ),
                      child: Text(
                        '清水模系列',
                        style: TextStyle(
                            color:
                                options == 5 ? Colors.white : Color(0xff0069ab),
                            letterSpacing: 4,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      options = 6;
                    }),
                    child: Container(
                      width: 170,
                      alignment: Alignment.center,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: options == 6 ? Color(0xff0069ab) : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: options == 6 ? Colors.grey : Colors.black26,
                        ),
                      ),
                      child: Text(
                        '特殊漆系列',
                        style: TextStyle(
                            color:
                                options == 6 ? Colors.white : Color(0xff0069ab),
                            letterSpacing: 4,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  nextPage();
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
          ],
        ),
      ),
    );
  }
}
