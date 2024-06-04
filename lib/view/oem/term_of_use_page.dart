import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/oem/requirement_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:styled_text/styled_text.dart';

class TermOfUsePage extends StatefulWidget {
  const TermOfUsePage({super.key});

  @override
  _TermOfUsePageState createState() => _TermOfUsePageState();
}

class _TermOfUsePageState extends State<TermOfUsePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool confirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        padding:  EdgeInsets.only(left: 20.w, right: 20.w),
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                context.emptySizedHeightBoxLow3x,
                 Text(
                  "請先詳閱以下用戶條款\n同意後方可進行派工預約",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp),
                ),
                 SizedBox(height: 30.w),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                        color: Colors.white,
                        child: StyledText(
                          text: privacy,
                          tags: {
                            'bold': StyledTextTag(
                                style:  TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16.sp)),
                          },
                        )),
                  ),
                ),
                Container(
                  child: CheckboxListTile(
                    value: confirm,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      setState(() {
                        confirm = value!;
                      });
                    },
                    title:  Text(
                      "我同意以上條款，繼續進行派工預約！",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  width: 180.w,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (confirm == false) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text('請勾選同意條款後方可進行派工預約！'),
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

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RequirementPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('開始派工預約'),
                  ),
                ),
                context.emptySizedHeightBoxLow3x,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
