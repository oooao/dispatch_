import 'dart:async';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/util/user_default.dart';
import 'package:dispatch/view/coupon/coupon_list_page.dart';
import 'package:dispatch/view/oem/term_of_use_page.dart';
import 'package:dispatch/view/invite/agreement_page.dart';
import 'package:dispatch/view/login_page.dart';
import 'package:dispatch/view/odm/legal_page.dart';
import 'package:dispatch/view/personal/customer/customer_edit_page.dart';
import 'package:dispatch/view/personal/worker/oem_list_page.dart';
import 'package:dispatch/view/personal/worker/worker_edit_page.dart';
import 'package:dispatch/view/personal/worker/invoice/worker_invoice_list.dart';
import 'package:dispatch/view/transmit/transport_request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({Key? key}) : super(key: key);

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  ItemScrollController itemScrollController = ItemScrollController();
  List<BannerModel> listBanners = [
    BannerModel(imagePath: 'assets/images/space.png', id: '0')
  ];
  int bannerindex = 0;

  UserModel? currentUser;
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: '3wiOo0z7Eow',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  void initState() {
    WebAPI().getBannerIamge().then((value) {
      setState(() {
        listBanners = value;
      });
    });
    super.initState();
    generateAvatar();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      bannerindex < listBanners.length - 1 ? bannerindex++ : bannerindex = 0;
      //& 9/25 切換至其他頁面會導致函式持續執行而錯誤(尚未解決)
      try {
        itemScrollController.scrollTo(
            index: bannerindex, duration: const Duration(seconds: 1));
      } catch (error) {
        timer.cancel();
      }
    });
  }

  void generateAvatar() {
    setState(() {
      tmpSVG = RandomAvatarString(
          DateTime.now().millisecondsSinceEpoch.toRadixString(16));
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width / 3 - 20.w;
    currentUser = Provider.of<Auth>(context, listen: false).currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/TextLogo.png'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {},
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: SizedBox(
                        width: 80.w,
                        height: 80.h,
                        child: Image.asset("assets/images/male.png"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(currentUser!.name,
                            style: TextStyle(fontSize: 16.sp)),
                        Text(currentUser!.phone,
                            style: TextStyle(fontSize: 16.sp)),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkerEditPage(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                  size: 32.w,
                ),
                title: Text(
                  "個人資料",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18.sp),
                ),
              ),
              ListTile(
                onTap: () {
                  launchUrlString(line_url,
                      mode: LaunchMode.externalApplication);
                },
                leading: Icon(
                  Icons.info,
                  color: Theme.of(context).primaryColor,
                  size: 32.w,
                ),
                title: Text(
                  "客服中心",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18.sp),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: Theme.of(context).primaryColor,
                  size: 32.w,
                ),
                title: Text(
                  "邀請朋友",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18.sp),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.branding_watermark,
                  color: Theme.of(context).primaryColor,
                  size: 32.w,
                ),
                title: Text(
                  "品牌介紹",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18.sp),
                ),
              ),
              ListTile(
                leading: Icon(
                  FontAwesome.business_time,
                  color: Theme.of(context).primaryColor,
                  size: 32.w,
                ),
                title: Text(
                  "企業合作",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18.sp),
                ),
              ),
              /*ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
              title: Text(
                "相關設定",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
              ),
            ),*/
              ListTile(
                onTap: () async {
                  await Provider.of<Auth>(context, listen: false).logout();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      ((route) => false));
                },
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                  size: 32.w,
                ),
                title: Text(
                  "登出",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18.sp),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFFDCDDDD),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                //9/25 改用橫向listview
                SizedBox(
                    width: MediaQuery.of(context).size.width - 10.w,
                    height: 200.h,
                    child: Builder(
                      builder: (BuildContext context) => listBanners.length == 1
                          ? Center(
                              child: const CircularProgressIndicator(),
                            )
                          : ScrollablePositionedList.builder(
                              itemScrollController: itemScrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: listBanners.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  //margin: EdgeInsets.only(right:15,left: 15,bottom: 5),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 8.h),
                                  width:
                                      MediaQuery.of(context).size.width - 40.w,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          blurStyle: BlurStyle.normal,
                                          color: Colors.grey,
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          //offset: Offset(1, -2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            listBanners[index].imagePath,
                                          ),
                                          fit: BoxFit.cover)),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8.0),
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          listBanners[index].imagePath));
                                    },
                                  ),
                                );
                              }),
                    )),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 10,
                  children: [
                    SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OemListPage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 100.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: Offset(3, 5),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 15.h),
                                      child: Image.asset(
                                          "assets/images/dispatch.png")),
                                ),
                                if (UserDefault.instance.notification_count > 0)
                                  Container(
                                    width: 30.w,
                                    height: 30.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                        "${UserDefault.instance.notification_count}",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Text("吉時派工",
                                style: TextStyle(color: primaryTextColor)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onPressed: () {},
                        child: Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(3, 5),
                                  ),
                                ],
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  child:
                                      Image.asset("assets/images/upload.png")),
                            ),
                            SizedBox(height: 5.h),
                            Text("上傳資料",
                                style: TextStyle(
                                  color: primaryTextColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InvoicePage(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(3, 5),
                                  ),
                                ],
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  child: Image.asset("assets/images/wage.png")),
                            ),
                            SizedBox(height: 5.h),
                            Text("提領工資",
                                style: TextStyle(
                                  color: primaryTextColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onPressed: () {},
                        child: Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(3, 5),
                                  ),
                                ],
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  child: Image.asset(
                                      "assets/images/design_sharing.png")),
                            ),
                            SizedBox(height: 5.h),
                            Text("設計分享",
                                style: TextStyle(
                                  color: primaryTextColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onPressed: () {},
                        child: Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(3, 5),
                                  ),
                                ],
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  child: Image.asset("assets/images/9-08.png")),
                            ),
                            SizedBox(height: 5.h),
                            Text("吉時開箱",
                                style: TextStyle(
                                  color: primaryTextColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: buttonWidth,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "https://www.bluefruit-design.com/shop/"));
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(3, 5),
                                  ),
                                ],
                              ),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  child: Image.asset("assets/images/9-05.png")),
                            ),
                            SizedBox(height: 5.h),
                            Text("吉時商城",
                                style: TextStyle(
                                  color: primaryTextColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //Spacer(),
                SizedBox(
                  height: 20.h,
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   padding: const EdgeInsets.all(5),
                //   child: Text(
                //     "吉時報報",
                //     style: TextStyle(
                //       color: Theme.of(context).primaryColor,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //     ),
                //   ),
                // ),
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
