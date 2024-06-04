import 'package:carousel_animations/carousel_animations.dart';
import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/odm/odm_request_form_page.dart';
import 'package:dispatch/view/widgets/form_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dispatch/controller/webapi.dart';


// 2023/10 重製畫面
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPagePageState createState() => _IntroPagePageState();
}

class _IntroPagePageState extends State<IntroPage> {
  SwiperController swiperController = SwiperController();

  List<String> videos = [""];
  YoutubePlayerController? _whatVideoController;
  YoutubePlayerController? _whyVideoController;
  YoutubePlayerController? _howVideoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WebAPI().getOdmvideo().then((value) {
      setState(() {
        videos = value;
        _whatVideoController = YoutubePlayerController(
          initialVideoId: videos[0],
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );

        _whyVideoController = YoutubePlayerController(
          initialVideoId: videos[1],
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );

        _howVideoController = YoutubePlayerController(
          initialVideoId: videos[2],
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      });
    });
  }

  int current_index = 0;
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
        child: Column(
          children: [
            context.emptySizedHeightBoxHigh,
            FormBackground(
              child: Container(
                padding: EdgeInsets.only(bottom: 80.h, left: 10.w, right: 10.w),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        return buildWhatPage();
                      case 1:
                        return buildWhyPage();
                      case 2:
                        return buildHowPage();
                    }
                    return Container();
                  },
                  onIndexChanged: (value) {
                    print("$current_index, $value");
                    if (value == 2 && current_index == 0) {
                      swiperController.move(0);
                      return;
                    } else if (value == 0 && current_index == 2) {
                      swiperController.move(2);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ODMRequestFormPage()),
                      );
                    } else {
                      current_index = value;
                    }
                  },
                  indicatorLayout: PageIndicatorLayout.COLOR,
                  itemCount: 3,
                  index: current_index,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      space: 10,
                      activeColor: primaryTextColor,
                      color: Colors.black12,
                    ),
                  ),
                  controller: swiperController,
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
              child: ElevatedButton(
                onPressed: () async {
                  if (current_index < 2) {
                    swiperController.next();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ODMRequestFormPage()),
                    );
                  }
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
            context.emptySizedHeightBoxLow3x,
          ],
        ),
      ),
    );
  }

  Widget buildWhatPage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          context.emptySizedHeightBoxNormal,
          Text(
            "為何使用ODM?",
            style: TextStyle(
                letterSpacing: 8.sp,
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          context.emptySizedHeightBoxHigh,
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text("用這段影片告訴你們使用吉時ODM的好處吧!",
                style: TextStyle(
                    fontSize: 11.sp, color: Colors.black, letterSpacing: 3)),
          ),
          context.emptySizedHeightBoxNormal,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: _whatVideoController != null
                      ? YoutubePlayer(
                          controller: _whatVideoController!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.amber,
                          progressColors: const ProgressBarColors(
                            playedColor: Colors.amber,
                            handleColor: Colors.amberAccent,
                          ),
                        )
                      : Container()),
            ),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  Widget buildWhyPage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          context.emptySizedHeightBoxNormal,
          Text(
            "何為吉時ODM?",
            style: TextStyle(
                letterSpacing: 8.sp,
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          context.emptySizedHeightBoxLow3x,
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text("你有任何居住想法或是希望我們幫您規劃由採購方委托製造方提供從研發、設計到生產、後期維護的全部服務。",
                  style: TextStyle(
                      fontSize: 11.sp, color: Colors.black, letterSpacing: 3)),
            ),
          ),
          context.emptySizedHeightBoxNormal,
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 40.w),
              child: Image.asset(
                'assets/images/odm_intro_boy.png',
                width: 120,
              )),
           SizedBox(height: 50.h),
        ],
      ),
    );
  }

  Widget buildHowPage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          context.emptySizedHeightBoxNormal,
          Text(
            "使用ODM好處?",
            style: TextStyle(
                letterSpacing: 8.sp,
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          context.emptySizedHeightBoxLow3x,
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                  "ODM生產的好處實際上是客戶開發項目所需的資源數量很少。 使用ODM，如果您想開發一個全新的產品，客戶當然不需要投入大量資金甚至機會來進行實驗。 通過降低產品增長的支出，消費者可以輕鬆地將更多的時間和金錢集中在營銷策略上。 利用ODM製造商的另一個優勢是范圍經濟狀況的可訪問性",
                  style: TextStyle(
                      fontSize: 11.sp, color: Colors.black, letterSpacing: 3)),
            ),
          ),
          context.emptySizedHeightBoxNormal,
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 40.w),
              child: Image.asset(
                'assets/images/odm_intro_boy.png',
                width: 120,
              )),
           SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
