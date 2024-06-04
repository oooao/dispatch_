import 'dart:io';

import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/util/user_default.dart';
import 'package:dispatch/view/personal/worker/worker_naviagationBar.dart';
import 'package:dispatch/view/register/ballpainter.dart';
import 'package:dispatch/view/register/identity_Selection_page.dart';
import 'package:dispatch/view/register/privacy_page.dart';
import 'package:dispatch/view/widgets/custom_widgets.dart';
import 'package:dispatch/view/navigationBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final bool auto_login;
  const LoginPage({Key? key, this.auto_login = false}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    if (widget.auto_login) {
      silentLogin();
    }
  }

  Future<void> silentLogin() async {
    String phone = UserDefault().phone;
    String password = UserDefault().password;
    if (phone.isNotEmpty && password.isNotEmpty) {
      await Provider.of<Auth>(context, listen: false).login(phone, password);
      UserModel? currentUser =
          Provider.of<Auth>(context, listen: false).currentUser;
      if (currentUser.user_id.isNotEmpty) {
        if (currentUser.role == 'worker') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const WorkerBottomBarPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomBarPage()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      color: Color(0xff186097),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Form(
            child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: BallPainter(
                x: MediaQuery.of(context).size.width / 2,
                y: MediaQuery.of(context).size.height / 2 + 200.h,
                cSize: 720.h,
              ),
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/TextLogo.png',
                    width: 100.w,
                  ),
                  context.emptySizedHeightBoxNormal,
                  context.emptySizedHeightBoxLow,
                  SizedBox(
                    height: 33.h,
                    child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                          hintText: '帳  號',
                          isDense: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Image.asset('assets/images/lines.png'),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        )),
                  ),
                  context.emptySizedHeightBoxLow3x,
                  SizedBox(
                    height: 33.h,
                    child: TextFormField(
                        controller: passwordController,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                          suffixIcon: IconButton(
                            icon: !showPassword
                                ? Icon(Icons.remove_red_eye)
                                : Icon(Icons.visibility_off),
                            onPressed: () => setState(() {
                              showPassword = !showPassword;
                            }),
                          ),
                          hintText: '密  碼',
                          isDense: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Image.asset('assets/images/lines.png'),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        )),
                  ),
                  // context.emptySizedHeightBoxNormal,
                  TextButton(
                    onPressed: () {
                      //
                    },
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "忘記密碼？",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'MicrosoftYaHei'),
                      ),
                    ),
                  ),
                  context.emptySizedHeightBoxHigh,
                  SizedBox(
                    width: 140.w,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        print(MediaQuery.of(context).size.height);
                        String phone = phoneController.text;
                        String password = passwordController.text;
                        await Provider.of<Auth>(context, listen: false)
                            .login(phone, password);
                        UserModel? currentUser =
                            Provider.of<Auth>(context, listen: false)
                                .currentUser;
                        if (currentUser.user_id.isNotEmpty) {
                          if (currentUser.role == 'worker') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WorkerBottomBarPage()),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomBarPage()),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        foregroundColor: Color(0xffd9d9d9),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        '登入',
                        style: TextStyle(
                            fontSize: 18.sp,
                            letterSpacing: 18.sp,
                            color: Color(0xff0069ab)),
                      ),
                    ),
                  ),
                  context.emptySizedHeightBoxHigh,
                  if (kIsWeb == false)
                    Text(
                      '\n\n使用其他登入方式',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'MicrosoftYaHei',
                          fontWeight: FontWeight.bold),
                    ),

                  context.emptySizedHeightBoxLow,
                  if (kIsWeb == false)
                    SizedBox(
                      width: 200.w,
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await Provider.of<Auth>(context, listen: false)
                                  .signInWithGuest();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomBarPage()),
                              );
                              //  }
                            },
                            child: Icon(
                              Icons.person,
                              size: 35.w,
                            ),
                          ),
                          if (Platform.isIOS)
                            Padding(
                              padding: EdgeInsets.only(bottom: 3.h),
                              child: TextButton(
                                onPressed: () async {
                                  await Provider.of<Auth>(context,
                                          listen: false)
                                      .signInWithApple(context);
                                  UserModel? currentUser =
                                      Provider.of<Auth>(context, listen: false)
                                          .currentUser;
                                  if (currentUser.user_id.isNotEmpty) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomBarPage()),
                                    );
                                  }
                                },
                                child: Image.asset(
                                    "assets/images/apple-login.png",
                                    width: 50.w),
                              ),
                            ),
                          TextButton(
                            onPressed: () async {
                              await Provider.of<Auth>(context, listen: false)
                                  .signInWithGoogle(context);
                              UserModel? currentUser =
                                  Provider.of<Auth>(context, listen: false)
                                      .currentUser;
                              if (currentUser.user_id.isNotEmpty) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomBarPage()),
                                );
                              }
                            },
                            child: Image.asset("assets/images/google.png",
                                width: 50.w),
                          ),
                        ],
                      ),
                    ),
                  context.emptySizedHeightBoxLow,
                  SizedBox(
                    width: 150.w,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: Color(0xfff1f1f1)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const IdentitySelectionPage()),
                        );
                      },
                      child: Text(
                        "註冊會員",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MicrosoftYaHei',
                            letterSpacing: 4.w),
                      ),
                    ),
                  ),

                  context.emptySizedHeightBoxLow3x,
                  Text('@吉時上工',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'MicrosoftYaHei',
                          fontSize: 12.sp)),
                  context.emptySizedHeightBoxLow3x,
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
