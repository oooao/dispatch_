import 'package:dispatch/util/common.dart';

import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/view/reserve/brand_intro_page.dart';
import 'package:dispatch/view/reserve/line_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Text(
                  '吉時特約',
                  style: TextStyle(
                      fontFamily: 'MicrosoftYaHei',
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 15),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.w),
                alignment: Alignment.centerLeft,
                child: Text("Hi！\n${currentUser.name}\n請選擇您需要的服務項目！",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'MicrosoftYaHei',
                        letterSpacing: 3.5.w,
                        height: 1.65.h)),
              ),
              context.emptySizedHeightBoxLow3x,
              //10/11 修改oem選單樣式以及新增選項
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                //childAspectRatio: 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                padding: EdgeInsets.all(8),
                children: [
                  menu(0, 'assets/images/service_menu_1.png', '廢料清運', true),
                  menu(1, 'assets/images/service_menu_2.png', '系統板材', false),
                  menu(2, 'assets/images/service_menu_3.png', '居家清潔', true),
                  menu(3, 'assets/images/service_menu_4.png', '空間攝影', true),
                  menu(4, 'assets/images/service_menu_5.png', '企業合作', false),
                  menu(5, 'assets/images/service_menu_6.png', '品牌設計', true),
                ],
              ),
            ],
          ),
        ));
  }

  Widget menu(int index, String image, String name, bool line) {
    return Ink(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.white),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Colors.grey,
              spreadRadius: 0,
              blurRadius: 5,
            )
          ]),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          onTap: () async {
            if (name == '系統板材')
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrandIntroPage(),
                  ));
            else if (line) {
              if (await canLaunchUrlString(line_url)) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LineContactPage()));
              } else {
                return;
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Image.asset(
                image,
                height: 44.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                name,
                style: TextStyle(
                    fontFamily: 'MicrosoftYaHei',
                    fontSize: 13.sp,
                    letterSpacing: 3.w),
              ),
            ],
          )),
    );
  }
}
