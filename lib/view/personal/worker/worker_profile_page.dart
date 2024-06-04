import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/view/oem/request_complete_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerProfilePage extends StatefulWidget {
  final UserModel userModel;
  final OEMModel? oemModel;
  const WorkerProfilePage({super.key, required this.userModel, this.oemModel});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  int currentTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding:  EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        color: Colors.black12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160.w,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 120.w,
                        height: 120.h,
                        child: Image.asset("assets/images/male.png"),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                        child: Text(getRoleString(widget.userModel.role),
                            style: TextStyle(
                                color: primaryTextColor, fontSize: 16.sp)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("編號：${widget.userModel.user_id}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                       SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text("名稱：${widget.userModel.name}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                       SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text("電話：${widget.userModel.phone}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                       SizedBox(height: 5.h),
                      if (widget.oemModel != null)
                        SizedBox(
                          width: 180.w,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const Text('是否確定要選擇此師傅？'),
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
                                          await WebAPI().confirmOEMRequest(
                                              context,
                                              widget.oemModel!.oem_id,
                                              widget.userModel.user_id);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RequestCompletePage(
                                                userModel: widget.userModel,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: const Text('選擇此師傅'),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
             SizedBox(height: 20.h),
            Expanded(
              child: DefaultTabController(
                length: 1,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: primaryTextColor, // Set the tab indicator color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: '作品集'),
                      ],
                      onTap: (value) {
                        setState(() {
                          currentTab = value;
                        });
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
