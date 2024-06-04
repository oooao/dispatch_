import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/odm/intro_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:styled_text/styled_text.dart';



// 2023/10 重製畫面
class LegalPage extends StatefulWidget {
  const LegalPage({super.key});

  @override
  _LegalPageState createState() => _LegalPageState();
}

class _LegalPageState extends State<LegalPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool confirm = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0.h),
              child: Text(
                'BizWorks 用戶條款',
                style: TextStyle(
                  fontSize: 16.sp,
                  letterSpacing: 2,
                ),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            Expanded(
              child: FormBackground(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: EdgeInsets.only(top: 25.h, left: 10.w, right: 10.w),
                  child: SingleChildScrollView(
                      child: StyledText(
                    text: legal,
                    tags: {
                      'bold': StyledTextTag(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    },
                  )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
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
              // width: 180,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  if (confirm == false) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('請點擊同意說明後方可繼續！'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const IntroPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.5,
                  backgroundColor: confirm ? Color(0xff0069ab) : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Text('同意並繼續',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: confirm ? Colors.white : Color(0xff0069ab),
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
