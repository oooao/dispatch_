import 'package:dispatch/util/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class CouponListPage extends StatefulWidget {
  const CouponListPage({super.key});

  @override
  _CouponListPageState createState() => _CouponListPageState();
}

class _CouponListPageState extends State<CouponListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        child: _Form(),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int selectedIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(initialIndex: selectedIndex, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 9/15 票券頁面更新
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Padding(
                padding:  EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Text(
                  '我的優惠券',
                  style: TextStyle(
                      fontFamily: 'MicrosoftYaHei',
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 15.w),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: TabBar(
                  isScrollable: true,
                  //dividerColor: Color(0xff0069ab),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 0, 98, 162),
                  ),
                  indicatorWeight: 2,
                  unselectedLabelColor: Colors.black54,
                  labelColor: Colors.white,
                  //indicatorColor: const Color.fromARGB(255, 0, 98, 162),
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width:
                            ((MediaQuery.of(context).size.width - 50) / 2 - 30).w,
                        child: Text(
                          '全部類型',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        alignment: Alignment.center,
                        width:
                            ((MediaQuery.of(context).size.width - 50) / 2 - 30).w,
                        child: Text(
                          '已兌換',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                      // ),
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                      _tabController.animateTo(index);
                    });
                  },
                ),
              ),
              IndexedStack(
                index: selectedIndex,
                children: [
                  couponList(selectedIndex),
                  couponList(selectedIndex)
                ],
              ),
            ]),
          ),
        ));
  }

  Widget couponList(int type) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding:  EdgeInsets.only(bottom: 10.h),
              child: Stack(alignment: Alignment.center, children: [
                type == 0
                    ? Image.asset("assets/images/coupon.png")
                    : Image.asset("assets/images/coupon_disabled.png"),
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/couponIcon_dispatch.png",
                          width: 60.w,
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                          child: Text(
                            '吉時運送',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                  TextSpan(
                                      text: '折 ',
                                      style: TextStyle(fontSize: 20.sp)),
                                  TextSpan(
                                    text: '＄ 888',
                                    style: TextStyle(
                                        fontSize: 70.sp,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                            Text('低消500'),
                            Text('03/01 00:00-06/06 24:00'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ]));
        },
      ),
    );
  }
}
