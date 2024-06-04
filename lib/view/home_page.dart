import 'dart:async';
//import 'dart:html';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:dispatch/util/user_default.dart';
import 'package:dispatch/view/charity_page.dart';
import 'package:dispatch/view/register/register.dart';
import 'package:dispatch/controller/webapi.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/model/user_model.dart';
import 'package:dispatch/provider/auth.dart';
import 'package:dispatch/view/coupon/coupon_list_page.dart';
import 'package:dispatch/view/oem/cus_oem_list_page.dart';
import 'package:dispatch/view/oem/term_of_use_page.dart';
import 'package:dispatch/view/invite/agreement_page.dart';
import 'package:dispatch/view/login_page.dart';
import 'package:dispatch/view/odm/legal_page.dart';
import 'package:dispatch/view/register/identity_Selection_page.dart';
import 'package:dispatch/view/reserve/service_page.dart';
import 'package:dispatch/view/transmit/transport_request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'personal/customer/customer_edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

      if (mounted)
        itemScrollController.scrollTo(
            index: bannerindex, duration: const Duration(seconds: 1));
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
    double buttonWidth = MediaQuery.of(context).size.width / 3 - (10.w);
    currentUser = Provider.of<Auth>(context, listen: false).currentUser;
    print(currentUser!.user_id);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Image.asset(
          'assets/images/TextLogo.png',
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 2 / 3,
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                    builder: (context) => const CustomerEditPage(),
                  ),
                );
              },
              leading: Icon(
                Icons.person,
                color: primaryTextColor,
                size: 32.w,
              ),
              title: Text(
                "個人資料",
                style: TextStyle(color: primaryTextColor, fontSize: 18.sp),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: primaryTextColor,
                size: 32.w,
              ),
              title: Text(
                "邀請朋友",
                style: TextStyle(color: primaryTextColor, fontSize: 18.sp),
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     launchUrlString(line_url, mode: LaunchMode.externalApplication);
            //   },
            //   leading: Icon(
            //     Icons.info,
            //     color: primaryTextColor,
            //     size: 32.w,
            //   ),
            //   title: Text(
            //     "客服中心",
            //     style: TextStyle(color: primaryTextColor, fontSize: 18.sp),
            //   ),
            // ),
            ListTile(
              leading: Icon(
                FontAwesome.business_time,
                color: primaryTextColor,
                size: 32.w,
              ),
              title: Text(
                "企業合作",
                style: TextStyle(color: primaryTextColor, fontSize: 18.sp),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).primaryColor,
                size: 32.w,
              ),
              title: Text(
                "相關設定",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18.sp),
              ),
            ),
            ListTile(
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    ((route) => false));
              },
              leading: Icon(
                Icons.logout,
                color: primaryTextColor,
                size: 32.w,
              ),
              title: Text(
                "登出",
                style: TextStyle(color: primaryTextColor, fontSize: 18.sp),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
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
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 8.h),
                                width: MediaQuery.of(context).size.width - 40.h,
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
                spacing: 10.w,
                children: [
                  SizedBox(
                    width: buttonWidth,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      onPressed: () {
                        if(currentUser!.token.isEmpty)   {
                          EasyLoading.showToast('請完成註冊後方可使用');
                          return;
                        }          
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CusOemListPage()),
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
                                  horizontal: 10.w, vertical: 10.h),
                              child: Image.asset(
                                "assets/images/dispatch.png",
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "吉時派工",
                            style: TextStyle(
                                fontSize: 14.sp, color: primaryTextColor),
                          )
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
                        if(currentUser!.token.isEmpty)   {
                          EasyLoading.showToast('請完成註冊後方可使用');
                          return;
                        }         
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LegalPage()),
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
                            child: Image.asset("assets/images/9-04.jpg"),
                          ),
                          SizedBox(height: 5.h),
                          Text("吉時ODM",
                              style: TextStyle(
                                fontSize: 14.sp,
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
                            child: Image.asset("assets/images/9-05.jpg"),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "吉時商城",
                            style: TextStyle(
                                fontSize: 14.sp, color: primaryTextColor),
                          ),
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
                        if(currentUser!.token.isEmpty)   {
                          EasyLoading.showToast('請完成註冊後方可使用');
                          return;
                        }         
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TransportRequestPage()),
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
                            child: Image.asset("assets/images/9-02.jpg"),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "運送服務",
                            style: TextStyle(
                                fontSize: 14.sp, color: primaryTextColor),
                          ),
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
                              builder: (context) => const CouponListPage()),
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
                            child: Image.asset("assets/images/9-03.jpg"),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "商家獎勵",
                            style: TextStyle(
                                fontSize: 14.sp, color: primaryTextColor),
                          ),
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
                            child: Image.asset("assets/images/market.png"),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "循環市集",
                            style: TextStyle(
                                fontSize: 14.sp, color: primaryTextColor),
                          ),
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
                                builder: ((context) => const ServicePage())));
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
                            child: Image.asset("assets/images/9-06.jpg"),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "吉時特約",
                            style: TextStyle(
                                fontSize: 14.sp, color: primaryTextColor),
                          ),
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
                                builder: (context) => const CharityPage()));
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
                            child: Image.asset("assets/images/9-07.jpg"),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "吉時行善",
                            style: TextStyle(
                                fontSize: 14.sp, color: primaryTextColor),
                          ),
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
                        //
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
                            child: Image.asset("assets/images/9-08.jpg"),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "吉時開箱",
                            style: TextStyle(
                                fontSize: 14.sp, color: primaryTextColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
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
      ),
    );
  }
}
