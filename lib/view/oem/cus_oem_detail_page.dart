import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/oem/pdf_page.dart';
import 'package:dispatch/view/personal/worker/worker_profile_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';

class CusOemDetailPage extends StatefulWidget {
  final OEMModel oemModel;
  final String status;
  const CusOemDetailPage(
      {super.key, required this.oemModel, required this.status});

  @override
  State<CusOemDetailPage> createState() => _CusOemDetailPageState();
}

class _CusOemDetailPageState extends State<CusOemDetailPage> {
  List<UserModel> workers = [];
  @override
  void initState() {
    super.initState();
    retrieveMatchingList();
  }

  Future<void> retrieveMatchingList() async {
    if (widget.status == MATCHING) {
      workers =
          await WebAPI().getMatchingWorkers(context, widget.oemModel.oem_id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('是否要取消此預排單?'),
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
                          await WebAPI().cancelOEMRequest(
                              context, widget.oemModel.oem_id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.cancel, color: Colors.white),
          )
        ],
      ),
      body: Column(children: [
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
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Text("${widget.oemModel.notice}",
                                      style: TextStyle(fontSize: 14)),
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
                          //
                          //   child: Text("車位：",
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold, fontSize: 14)),
                          // ),
                          // Container(
                          //   padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
                          //
                          //   child: Text("${widget.oemModel.parking}",
                          //       style: TextStyle(fontSize: 14)),
                          // ),
                          // if (widget.oemModel.parking_no.isNotEmpty)
                          //   Container(
                          //     padding:
                          //         EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
                          //
                          //     child: Text("車位號碼：",
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold, fontSize: 14)),
                          //   ),
                          // if (widget.oemModel.parking_no.isNotEmpty)
                          //   Container(
                          //     padding:
                          //         EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
                          //
                          //     child: Text("${widget.oemModel.parking_no}",
                          //         style: TextStyle(fontSize: 14)),
                          //   ),
                          context.sized.emptySizedHeightBoxNormal,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                          if(widget.oemModel.pdf.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 10.w),
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
                                                builder: (context) => PdfPage(
                                                  fileName: widget.oemModel.pdf,
                                                ),
                                              ));
                                        })),
                              ),
                            ],
                          ),
                          context.sized.emptySizedHeightBoxLow3x,
                          if (widget.status == MATCHING)
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Text("媒合結果：",
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
                                    child: widget.oemModel.total == 0
                                        ? Text("無媒合結果",
                                            style: TextStyle(fontSize: 14))
                                        : Column(
                                            children: buildMatchingList(),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        child:
                            buildPhotoList(widget.oemModel.photos)[index - 1]);
              },
            ),
          ),
        ),
      
       
      ]),
    );
  }

  List<Widget> buildMatchingList() {
    List<Widget> list = [];
    for (UserModel user in workers) {
      list.add(
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerProfilePage(
                  userModel: user,
                  oemModel: widget.oemModel,
                ),
              ),
            );
          },
          leading: Image.asset("assets/images/male.png"),
          title: Text(user.name),
          subtitle: Text(user.city),
        ),
      );
    }
    return list;
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
