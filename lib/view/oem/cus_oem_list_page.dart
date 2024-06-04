import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/oem/cus_oem_detail_page.dart';
import 'package:dispatch/view/oem/term_of_use_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class CusOemListPage extends StatefulWidget {
  const CusOemListPage({super.key});

  @override
  State<CusOemListPage> createState() => _CusOemListPageState();
}

class _CusOemListPageState extends State<CusOemListPage>
    with SingleTickerProviderStateMixin {
  int currentTab = 0;
  List<OEMModel> pending_list = [];

  @override
  void initState() {
    super.initState();
    retrievePendingList();
  }

  Future<void> retrievePendingList() async {
    pending_list = await WebAPI().getOEMs(context);
    for (var list in pending_list) {
      print("ID:${list.oem_id} \n");
      print("PDF:${list.pdf}");
      print("Area: ${list.area}");
      print("Status: ${list.status}");
      print("worker:${list.worker}");
      print("workerId:${list.worker_id}");
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
                                SizedBox(height: 10),
                                Text("新增您想要預約安排的組裝訂單",
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
                                Text("當您訂單已媒合到師傅時，請確認並選定師傅",
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
                                Text("完成訂單的委派會顯示在這唷！",
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
                                SizedBox(height: 10.h),
                                Text("您委派的案件，完工後會顯示在這唷！",
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
    List<OEMModel> matching_list = pending_list
        .where((element) =>
            element.status != 'canceled' &&
            element.worker == '0' &&
            element.total < 3 &&
            !isMatchingExpire(element.date_added))
        .toList();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: matching_list.isNotEmpty
          ? const Color(0xfffafafa)
          : Colors.transparent,
      child: ListView.builder(
        itemCount: matching_list.length + 1,
        itemBuilder: (context, index) {
          if (index == matching_list.length) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermOfUsePage()),
                );
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                width: MediaQuery.of(context).size.width,
                height: 80.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.asset('assets/images/add.png')],
                ),
              ),
            );
          } else {
            OEMModel model = matching_list[index];
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              width: MediaQuery.of(context).size.width,
              height: 80.h,
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
                      builder: (context) => CusOemDetailPage(
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
          }
        },
      ),
    );
  }

  Widget buildMatchingList() {
    List<OEMModel> matching_list = pending_list
        .where((element) =>
            element.worker == '0' &&
            (element.total >= 3 || isMatchingExpire(element.date_added)))
        .toList();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: matching_list.isNotEmpty
          ? const Color(0xfffafafa)
          : Colors.transparent,
      child: ListView.builder(
        itemCount: matching_list.length,
        itemBuilder: (context, index) {
          OEMModel model = matching_list[index];
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            width: MediaQuery.of(context).size.width,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ],
            ),
            child: ListTile(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CusOemDetailPage(
                      oemModel: model,
                      status: MATCHING,
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

  Widget buildProcessingList() {
    List<OEMModel> processing_list = pending_list
        .where(
            (element) => element.worker != '0' && element.status != COMPLETED)
        .toList();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: processing_list.isNotEmpty
          ? const Color(0xfffafafa)
          : Colors.transparent,
      child: ListView.builder(
        itemCount: processing_list.length,
        itemBuilder: (context, index) {
          OEMModel model = processing_list[index];
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            width: MediaQuery.of(context).size.width,
            height: 80.h,
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
                    builder: (context) => CusOemDetailPage(
                      oemModel: model,
                      status: PROCESSING,
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

  Widget buildCompletedList() {
    List<OEMModel> processing_list =
        pending_list.where((element) => element.status == COMPLETED).toList();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: processing_list.isNotEmpty
          ? const Color(0xfffafafa)
          : Colors.transparent,
      child: ListView.builder(
        itemCount: processing_list.length,
        itemBuilder: (context, index) {
          OEMModel model = processing_list[index];
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            width: MediaQuery.of(context).size.width,
            height: 80.h,
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
                    builder: (context) => CusOemDetailPage(
                      oemModel: model,
                      status: PROCESSING,
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

  @override
  void dispose() {
    super.dispose();
  }
}
