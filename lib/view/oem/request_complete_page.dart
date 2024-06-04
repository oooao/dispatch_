import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/view/home_page.dart';
import 'package:dispatch/view/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class RequestCompletePage extends StatefulWidget {
  final UserModel userModel;
  const RequestCompletePage({super.key, required this.userModel});

  @override
  _RequestCompletePageState createState() => _RequestCompletePageState();
}

class _RequestCompletePageState extends State<RequestCompletePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        child: buildForm(),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 220, 222, 223),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            context.emptySizedHeightBoxLow3x,
             Text(
              "太好了",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF0063A2),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold),
            ),
            context.emptySizedHeightBoxLow3x,
             Text(
              "媒合成功！！",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF0063A2),
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold),
            ),
            context.emptySizedHeightBoxLow3x,
            Padding(
              padding:  EdgeInsets.only(left: 40.w, right: 40.w),
              child: SizedBox(
                width: 200.w,
                height: 200.h,
                child: Image.asset("assets/images/male.png"),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            Text(
              "${widget.userModel.name}師傅",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF0063A2),
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold),
            ),
            context.emptySizedHeightBoxLow3x,
            SizedBox(
              width: 180.w,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => const BottomBarPage()),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('OK'),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
          ],
        ),
      ),
    );
  }
}
