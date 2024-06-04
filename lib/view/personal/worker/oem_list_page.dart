import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/util/user_default.dart';
import 'package:dispatch/view/personal/worker/oem_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class OemListPage extends StatefulWidget {
  final int tab_index;
  const OemListPage({super.key, this.tab_index = 0});

  @override
  State<OemListPage> createState() => _OemListPageState();
}

class _OemListPageState extends State<OemListPage>
    with SingleTickerProviderStateMixin {
  int currentTab = 0;
  List<OEMModel> pending_list = [];
  List<OEMModel> accept_list = [];

  @override
  void initState() {
    super.initState();
    UserDefault.instance.notification_count = 0;

    retrievePendingList();
    retrieveAcceptList();
  }

  Future<void> retrievePendingList() async {
    pending_list = await WebAPI().getOEMLists(context, 0);
    for (var pending in pending_list) {
      print("PendingID:${pending.oem_id} \n");
      print("PendingPDF:${pending.pdf}");
      print("PendingArea: ${pending.area}");
      print("-------------------");
    }
    setState(() {});
  }

  Future<void> retrieveAcceptList() async {
    accept_list = await WebAPI().getOEMLists(context, 1);
    for (var accept in accept_list) {
      print("AcceptID:${accept.oem_id} \n");
      print("AcceptPDF:${accept.pdf}");
      print("AcceptArea: ${accept.area}");
      print("acceptWorker${accept.worker}");
      print("-------------------");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/TextLogo.png'),
          centerTitle: true,
        ),
        body: Container(
          child: DefaultTabController(
            initialIndex: widget.tab_index,
            length: 4,
            child: Column(
              children: [
                context.emptySizedHeightBoxLow,
                Container(
                  height: 35,
                  // width: MediaQuery.of(context).size.width - 60.w,
                  decoration: BoxDecoration(
                      color: Color(0xffE5E4E4),
                      borderRadius: BorderRadius.circular(8)),
                  child: TabBar(
                    isScrollable: true,
                    labelStyle: TextStyle(
                        letterSpacing: 5.w,
                        color: Colors.black,
                        fontFamily: 'MicrosoftYaHei'),
                    indicator: BoxDecoration(
                      color: Color(0xffa7b6cc),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '預排單',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '已確認',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '已派工',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '已完工',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                    onTap: (value) {
                      setState(() {
                        currentTab = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/handshake.png",
                                  opacity: const AlwaysStoppedAnimation(.2),
                                ),
                                SizedBox(height: 10.h),
                                Text("客戶新增案件會顯示在這裡唷",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          buildPendingList(),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/handshake.png",
                                  opacity: const AlwaysStoppedAnimation(.2),
                                ),
                                SizedBox(height: 10.h),
                                Text("等待客戶確認訂單是否委派成功",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          buildMatchingList(),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/handshake.png",
                                  opacity: const AlwaysStoppedAnimation(.2),
                                ),
                                SizedBox(height: 10.h),
                                Text("1. 正在進行中的案件\n2.案件完工後的確認\n3.上傳完工照片",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          buildProcessingList(),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/handshake.png",
                                  opacity: const AlwaysStoppedAnimation(.2),
                                ),
                                SizedBox(height: 10),
                                Text("上傳完工照，並且確認工程已經完工",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          buildCompletedList(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildPendingList() {
    return Container(
      color: pending_list.isNotEmpty
          ? const Color(0xfffafafa)
          : Colors.transparent,
      child: ListView.builder(
        itemCount: pending_list.length,
        itemBuilder: (context, index) {
          OEMModel model = pending_list[index];
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 3,
                  //offset: Offset(3, 5),
                ),
              ],
            ),
            child: ListTile(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OemDetailPage(
                      oemModel: model,
                      status: PENDING,
                    ),
                  ),
                );
                await retrievePendingList();
              },
              title: Text(
                "${model.city}${model.area}${model.address}",
              ),
              subtitle: Text("施工日期：${getDateStringFromDB(model.date)}"),
            ),
          );
        },
      ),
    );
  }

  Widget buildMatchingList() {
    List<OEMModel> matching_list = accept_list
        .where((element) => element.worker == getCurrentUser(context).user_id)
        .toList();
    print(getCurrentUser(context).user_id);

    return Container(
      color: matching_list.isNotEmpty
          ? const Color(0xfffafafa)
          : Colors.transparent,
      child: ListView.builder(
        itemCount: matching_list.length,
        itemBuilder: (context, index) {
          OEMModel model = matching_list[index];
          return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 3,
                    //offset: Offset(3, 5),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OemDetailPage(
                        oemModel: model,
                        status: MATCHING,
                      ),
                    ),
                  );
                  await retrieveAcceptList();
                },
                title: Text(
                  "${model.city}${model.area}${model.address}",
                ),
                subtitle: Text("施工日期：${getDateStringFromDB(model.date)}"),
              ));
        },
      ),
    );
  }

  Widget buildProcessingList() {
    List<OEMModel> processing_list = accept_list
        .where((element) =>
            element.worker == getCurrentUser(context).user_id &&
            element.status != COMPLETED)
        .toList();
    for (var accept in processing_list) {
      print("ProcessingID:${accept.oem_id} \n");
      print("ProcessingPDF:${accept.pdf}");
      print("ProcessingArea: ${accept.area}");
      print("processingStatus: ${accept.status}");
      print("-------------------");
    }

    return Container(
      color: processing_list.isNotEmpty
          ? const Color(0xfffafafa)
          : Colors.transparent,
      child: ListView.builder(
        itemCount: processing_list.length,
        itemBuilder: (context, index) {
          OEMModel model = processing_list[index];
          return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 3,
                    //offset: Offset(3, 5),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OemDetailPage(
                        oemModel: model,
                        status: PROCESSING,
                      ),
                    ),
                  );
                  await retrieveAcceptList();
                },
                title: Text(
                  "${model.city}${model.area}${model.address}",
                ),
                subtitle: Text("施工日期：${getDateStringFromDB(model.date)}"),
              ));
        },
      ),
    );
  }

  Widget buildCompletedList() {
    List<OEMModel> completed_list = accept_list
        .where((element) =>
            element.worker == getCurrentUser(context).user_id &&
            element.status == COMPLETED)
        .toList();
    return Container(
      color: completed_list.isNotEmpty
          ? const Color(0xfffafafa)
          : Colors.transparent,
      child: ListView.builder(
        itemCount: completed_list.length,
        itemBuilder: (context, index) {
          OEMModel model = completed_list[index];
          return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 3,
                    //offset: Offset(3, 5),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OemDetailPage(
                        oemModel: model,
                        status: COMPLETED,
                      ),
                    ),
                  );
                  await retrieveAcceptList();
                },
                title: Text(
                  "${model.city}${model.area}${model.address}",
                ),
                subtitle: Text("施工日期：${getDateStringFromDB(model.date)}"),
              ));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
