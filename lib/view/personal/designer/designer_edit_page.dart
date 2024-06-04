import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DesignerEditPage extends StatefulWidget {
  const DesignerEditPage({super.key});

  @override
  State<DesignerEditPage> createState() => _DesignerEditPageState();
}

class _DesignerEditPageState extends State<DesignerEditPage> {
  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<Auth>(context).currentUser;
    int currentTab = 0;

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
                        child: Text(getRoleString(currentUser.role),
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
                          Text("會員編號：${currentUser.user_id}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                       SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text("會員名稱：${currentUser.name}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                       SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text("會員電話：${currentUser.phone}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text("會員身份：${getRoleString(currentUser.role)}",
                              style: TextStyle(
                                  color: primaryTextColor, fontSize: 16.sp)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
             SizedBox(height: 20.h),
            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      indicator: BoxDecoration(
                        color: primaryTextColor, // Set the tab indicator color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: '訂單紀錄'),
                        Tab(text: '行事曆'),
                        Tab(text: '客服系統'),
                        Tab(text: '個人設定'),
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
                          SfCalendar(),
                          Container(),
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
