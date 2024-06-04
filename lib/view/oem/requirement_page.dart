import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/view/oem/oem_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RequirementPage extends StatefulWidget {
  const RequirementPage({super.key});

  @override
  _RequirementPageState createState() => _RequirementPageState();
}

class _RequirementPageState extends State<RequirementPage> {
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
  List<bool> options = [false, false, false, false, false, false];
  late OEMModel oemModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? currentUser =
        Provider.of<Auth>(context, listen: false).currentUser;
    oemModel = OEMModel(
      user_id: currentUser.user_id,
      services: [],
      photos: [],
    );
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Text(
                  '吉時派工',
                  style: TextStyle(
                      fontFamily: 'MicrosoftYaHei',
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                alignment: Alignment.centerLeft,
                child: Text("Hi！\n${currentUser.name}\n勾選您需要的服務項目！",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'MicrosoftYaHei',
                        letterSpacing: 3.5,
                        height: 1.65.h)),
              ),

              context.emptySizedHeightBoxLow3x,
              //10/11 修改oem選單樣式以及新增選項
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                children: [
                  menu(0, 'assets/images/oem_menu_1.png', '系統櫃組裝'),
                  menu(1, 'assets/images/oem_menu_2.png', '系統櫃拆裝工程'),
                  menu(2, 'assets/images/oem_menu_3.png', '淘寶系統家俱組裝'),
                  menu(3, 'assets/images/oem_menu_4.png', '派工協助/協助收尾'),
                  menu(4, 'assets/images/oem_menu_5.png', '建案‧系統櫃‧公共工程'),
                  menu(5, 'assets/images/oem_menu_6.png', '櫥櫃安裝'),
                ],
              ),
              context.emptySizedHeightBoxLow3x,
              SizedBox(
                width: 180.w,
                height: 50.h,
                child: ElevatedButton(
                    onPressed: () async {
                      oemModel.services.clear();
                      for (int i = 0; i < options.length; i++) {
                        if (options[i]) {
                          oemModel.services.add(i);
                        }
                      }
                      if (options[2] || options[3]) {
                        await WebAPI().sendOEMRequest(context, oemModel);
                      } else if (options[0]) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OEMContactPage(oemModel: oemModel),
                          ),
                        );
                        return;
                      } else {
                        await WebAPI().sendOEMRequest(context, oemModel);
                      }

                      print("[DEBUG] launch line");
                      if (await canLaunchUrlString(line_url)) {
                        launchUrlString(line_url,
                            mode: LaunchMode.externalApplication);
                      }
                      print("[DEBUG] finish launch");
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('下一步', style: TextStyle(fontSize: 20.sp))),
              ),
              context.emptySizedHeightBoxLow3x,
            ],
          ),
        ));
  }

  Widget menu(int index, String image, String name) {
    return InkWell(
      onTap: () => setState(() {
        options[index] = !options[index];
      }),
      child: Stack(alignment: Alignment.center, children: [
        Container(
            width: 200.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: options[index] ? 2.5 : 1,
                    color: options[index] ? primaryTextColor : Colors.white),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.normal,
                    color: Colors.grey,
                    spreadRadius: 0,
                    blurRadius: 5,
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
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
                      fontSize: 12.sp,
                      letterSpacing: 3.w),
                ),
              ],
            )),
        if (options[index])
          Positioned(
            right: 5.w,
            top: 5.h,
            child: Container(
              child: Icon(Icons.circle, color: primaryTextColor),
            ),
          ),
      ]),
    );
  }
}
