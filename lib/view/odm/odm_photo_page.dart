import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/odm_model.dart';
import 'package:dispatch/util/image_helper.dart';
import 'package:dispatch/view/odm/odm_confirm_page.dart';

import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';


// 2023/10 重製畫面
class ODMPhotoPage extends StatefulWidget {
  final ODMModel model;

  const ODMPhotoPage({super.key, required this.model});
  @override
  _ODMPhotoPageState createState() => _ODMPhotoPageState();
}

class _ODMPhotoPageState extends State<ODMPhotoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ODMModel model;
  List<String> photoList = [];

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  '請上傳施工的照片',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 5,
                  ),
                ),
              ),
              context.emptySizedHeightBoxLow3x,
              FormBackground(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    context.emptySizedHeightBoxLow3x,
                    buildPhotoList(),
                  ],
                ),
              ),
              SizedBox(
                //width: 180,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    photoList.isEmpty
                        ? EasyLoading.showError('請上傳圖片')
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ODMConfirmPage(
                                    model: model, photoList: photoList)),
                          );
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
      ),
    );
  }

  Column buildPhotoList() {
    List<Widget> lists = [];
    for (int i = 0; i < photoList.length; i++) {
      lists.add(buildPhotoGrid(i));
      lists.add(const SizedBox(height: 10));
    }

    lists.add(buildEmptyPhoto());
    // lists.add(
    //   Text(
    //     "請上傳施工區域及\n其他相關圖片",
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //         fontSize: 18, fontWeight: FontWeight.bold, color: primaryTextColor),
    //   ),
    // );
    return Column(
      children: lists,
    );
  }

  Widget buildPhotoGrid(int index) {
    Widget photo = ImageHelper.imageFromBase64String(photoList[index]);
    return Container(
      width: 256.w,
      height: 144.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryTextColor,
        ),
      ),
      child: photo,
    );
  }

  Widget buildEmptyPhoto() {
    Widget photo = Icon(
      Icons.add,
      color: Color(0xff0069ab),
    );
    return Container(
      width: 256.w,
      height: 144.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xfff1f1f1)),
      child: TextButton(
        onPressed: () async {
          List<String> photos = await ImageHelper.pickPhotos();
          print("[DEBUG] photos = $photos");
          setState(() {
            photoList.addAll(photos);
          });
        },
        child: photo,
      ),
    );
  }
}
