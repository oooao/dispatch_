import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/view/odm/odm_confirm_page.dart';
import 'package:dispatch/view/odm/odm_photo_page.dart';
import 'package:dispatch/view/odm/odm_sign_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class PreRequirementPage extends StatefulWidget {
  final ODMModel model;

  const PreRequirementPage({super.key, required this.model});
  @override
  _PreRequirementPageState createState() => _PreRequirementPageState();
}

class _PreRequirementPageState extends State<PreRequirementPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ODMModel model;
  int options = 0;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  void nextPage() {
    switch (options) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ODMPhotoPage(model: model),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ODMConfirmPage(model: model),
          ),
        );
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
                '選擇需求項目',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 5,
                ),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            FormBackground(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  context.emptySizedHeightBoxHigh,
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
                          color: Colors.black26,
                        ),
                      ),
                      child: Text(
                        '有圖片',
                        style: TextStyle(
                            color:
                                options == 1 ? Colors.white : Color(0xff0069ab),
                            letterSpacing: 4,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 14),
                      ),
                    ),
                  ),
                  context.emptySizedHeightBoxHigh,
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
                          border: Border.all(color: Colors.black26)),
                      child: Text(
                        '無圖片',
                        style: TextStyle(
                            color:
                                options == 2 ? Colors.white : Color(0xff0069ab),
                            letterSpacing: 4,
                            fontFamily: 'MicrosoftYaHei',
                            fontSize: 14),
                      ),
                    ),
                  ),
                  context.emptySizedHeightBoxHigh,
                 
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
                  child: Text('Next',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xff0069ab),
                        fontFamily: 'MicrosoftYaHei',
                        //letterSpacing: 8.w,
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
