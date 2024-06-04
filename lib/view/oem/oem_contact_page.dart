import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/user_default.dart';
import 'package:dispatch/view/oem/requirement_checklist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OEMContactPage extends StatefulWidget {
  final OEMModel oemModel;

  const OEMContactPage({super.key, required this.oemModel});

  @override
  _OEMContactPageState createState() => _OEMContactPageState();
}

class _OEMContactPageState extends State<OEMContactPage> {
  bool isLinePressed = UserDefault().priceRequested;
  bool confirm = UserDefault().priceRequested;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/TextLogo.png'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Form(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    context.emptySizedHeightBoxHigh,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Text(
                        "點擊LINE圖示詳閱安裝價格表",
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    context.emptySizedHeightBoxLow3x,
                    InkWell(
                      onTap: () async {
                        if (await canLaunchUrlString(line_url)) {
                          launchUrlString(line_url,
                              mode: LaunchMode.externalApplication);
                          setState(() {
                            print(isLinePressed);
                            isLinePressed = true;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.w, right: 40.w),
                        child:
                            Image.asset("assets/images/line.png", width: 200.w),
                      ),
                    ),
                    context.emptySizedHeightBoxLow3x,
                    isLinePressed == true ? confirmed() : Container(),
                    context.emptySizedHeightBoxLow3x,
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget confirmed() {
    return Column(
      children: [
        Container(
          child: CheckboxListTile(
            value: confirm,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              if (isLinePressed == false) {
                EasyLoading.showInfo("請先點擊Line圖示連繫官方Line取得安裝價格表");
                return;
              }
              setState(() {
                confirm = value!;
                UserDefault().priceRequested = confirm;
              });
            },
            title: Text(
              "本人已詳讀安裝價格表並同意",
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ),
        context.emptySizedHeightBoxLow3x,
        SizedBox(
          width: 180.w,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () async {
              if (confirm == false) {
                EasyLoading.showInfo("請詳讀安裝價格表並同意");
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RequirementCheckListPage(oemModel: widget.oemModel),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text('下一步'),
          ),
        ),
        context.emptySizedHeightBoxLow3x,
      ],
    );
  }
}
