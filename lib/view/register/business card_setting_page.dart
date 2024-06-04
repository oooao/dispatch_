import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/util/image_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class BusinessCardSettingPage extends StatefulWidget {
  final Function onCompleted;
  final UserModel model;
  final ValueChanged<UserModel> updateModel;
  const BusinessCardSettingPage(
      {super.key,
      required this.onCompleted,
      required this.model,
      required this.updateModel});

  @override
  State<BusinessCardSettingPage> createState() =>
      _BusinessCardSettingPageState();
}

class _BusinessCardSettingPageState extends State<BusinessCardSettingPage> {
  String photo1 = "";
  String photo2 = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //register ->next page
  void completed() async {
    widget.model.attachment = photo1;
    widget.model.attachment2 = photo2;
    widget.model.role = "designer";
    widget.updateModel(widget.model);
    widget.onCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      context.sized.emptySizedHeightBoxNormal,
      context.sized.emptySizedHeightBoxHigh,
      Container(
        height: 200.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        alignment: Alignment.center,
        child: photo1.isNotEmpty
            ? ImageHelper.imageFromBase64String(photo1)
            : TextButton(
                onPressed: () async {
                  photo1 = await ImageHelper.pickUserPhoto();
                  setState(() {});
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xff0069ab),
                ),
              ),
      ),
      context.sized.emptySizedHeightBoxLow,
      const Text(
        '上傳名片',
        style: TextStyle(color: Colors.white, letterSpacing: 4),
      ),
      const Text('(正  面)',
          style: TextStyle(color: Colors.white, letterSpacing: 4)),
      context.sized.emptySizedHeightBoxHigh,
      Container(
        alignment: Alignment.center,
        height: 200.h,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff0069ab), width: 2),
            borderRadius: BorderRadius.circular(30)),
        child: photo2.isNotEmpty
            ? ImageHelper.imageFromBase64String(photo2)
            : TextButton(
                onPressed: () async {
                  photo2 = await ImageHelper.pickUserPhoto();
                  setState(() {});
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xff0069ab),
                ),
              ),
      ),
      context.sized.emptySizedHeightBoxLow,
      const Text(
        '上傳名片',
        style: TextStyle(color: Colors.grey, letterSpacing: 4),
      ),
      const Text('(背  面)',
          style: TextStyle(color: Colors.grey, letterSpacing: 4)),
      context.sized.emptySizedHeightBoxLow,
      SizedBox(
        width: 160.w,
        height: 50.h,
        child: TextButton(
          style: TextButton.styleFrom(
            side: BorderSide(color: Colors.grey),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () {
            if (photo1.isEmpty || photo2.isEmpty) {
              EasyLoading.showError('請上傳名片');
              return;
            }
            completed();
          },
          child: Text(
            '下一步',
            style: TextStyle(
              fontFamily: 'MicrosoftYaHei',
              letterSpacing: 3.w,
            ),
          ),
        ),
      ),
    ]);
  }
}
