import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/personal/worker/oem_list_page.dart';
import 'package:dispatch/view/oem/pdf_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class OemDetailPage extends StatefulWidget {
  final OEMModel oemModel;
  final String status;
  const OemDetailPage(
      {super.key, required this.oemModel, required this.status});

  @override
  State<OemDetailPage> createState() => _OemDetailPageState();
}

class _OemDetailPageState extends State<OemDetailPage> {
  @override
  void initState() {
    super.initState();
    print("list status:${widget.oemModel.status}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Text(
              '詳細需求',
              style: TextStyle(fontSize: 16, letterSpacing: 5),
            ),
          ),
          context.sized.emptySizedHeightBoxLow3x,
          FormBackground(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: PageView.builder(
                itemCount: buildPhotoList(widget.oemModel.photos).length + 1,
                itemBuilder: (context, index) {
                  return index == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            context.sized.emptySizedHeightBoxNormal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                    ),
                                    child: Text("施工地點:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                    height: 15.h,
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                    ),
                                    child: Text(
                                        "${widget.oemModel.city}${widget.oemModel.area}${widget.oemModel.address}",
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                            context.sized.emptySizedHeightBoxNormal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("施工時間：",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                    height: 15.h,
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text(
                                        "${getDateStringFromDB(widget.oemModel.date)}",
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                            context.sized.emptySizedHeightBoxNormal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("現場狀態：",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                    height: 15.h,
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("${widget.oemModel.situation}",
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                            context.sized.emptySizedHeightBoxNormal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("鑰匙：",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                    height: 15.h,
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("${widget.oemModel.key_info}",
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                            if (widget.oemModel.password.isNotEmpty)
                              context.sized.emptySizedHeightBoxNormal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (widget.oemModel.password.isNotEmpty)
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Text("密碼：",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ),
                                  ),
                                if (widget.oemModel.password.isNotEmpty)
                                  Container(
                                      height: 15.h,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 2,
                                      )),
                                if (widget.oemModel.password.isNotEmpty)
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Text("${widget.oemModel.password}",
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ),
                              ],
                            ),
                            context.sized.emptySizedHeightBoxNormal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("現場注意需知：",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                    height: 15.h,
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("${widget.oemModel.notice}",
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                            context.sized.emptySizedHeightBoxNormal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("現場照片：",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ),
                                ),
                                Container(
                                    height: 15.h,
                                    child: VerticalDivider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: widget.oemModel.photos.length == 0
                                          ? Text("無現場照片",
                                              style: TextStyle(fontSize: 14))
                                          : Text("右滑查看照片",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff0069ab)))),
                                ),
                              ],
                            ),
                            context.sized.emptySizedHeightBoxLow3x,
                            if (widget.oemModel.pdf.isNotEmpty)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Text("附檔：",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ),
                                  ),
                                  Container(
                                      height: 15.h,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 2,
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10.w, right: 10.w),
                                        child: TextButton(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('PDF'),
                                            ),
                                            onPressed: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfPage(
                                                      fileName:
                                                          widget.oemModel.pdf,
                                                    ),
                                                  ));
                                            })),
                                  ),
                                ],
                              ),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: buildPhotoList(
                              widget.oemModel.photos)[index - 1]);
                },
              ),
            ),
          ),
          SizedBox(height: 20.h),
          if (widget.status == PENDING)
            Container(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 5.h),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 130.w,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text('是否確認要拒絕此案件？'),
                              actions: [
                                TextButton(
                                  child: const Text("否"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("是"),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    WebAPI().acceptOEMRequest(
                                        context, widget.oemModel.oem_id, false);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OemListPage()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        '拒絕',
                        style: TextStyle(
                            fontFamily: 'MicrosoftYaHei',
                            letterSpacing: 12.w,
                            fontSize: 16,
                            color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text('是否確認要媒合此案件？'),
                              actions: [
                                TextButton(
                                  child: const Text("否"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("是"),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    WebAPI().acceptOEMRequest(
                                        context, widget.oemModel.oem_id, true);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OemListPage()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child:  Text('開始媒合', style: TextStyle(
                            fontFamily: 'MicrosoftYaHei',
                            letterSpacing: 4.w,
                            fontSize: 16,
                            color: Color(0xff0069ab)),),
                    ),
                  ),
                ],
              ),
            ),
          if (widget.status == PROCESSING)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              height: 50.h,
              child: ElevatedButton(
                onPressed: () async {
                  await WebAPI()
                      .completeOEMRequest(context, widget.oemModel.oem_id);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '已完工',
                  style: TextStyle(
                      fontFamily: 'MicrosoftYaHei',
                      letterSpacing: 10.w,
                      fontSize: 20.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> buildPhotoList(List<dynamic> photos) {
    List<Widget> list = [];
    for (String path in photos) {
      print("$oem_image_path$path");
      list.add(FastCachedImage(url: "$oem_image_path$path"));
    }

    return list;
  }
}
