import 'package:dispatch/view/aboutUs/about%20us_page.dart';
import 'package:dispatch/view/home_page.dart';
import 'package:dispatch/view/invite/agreement_page.dart';
import 'package:dispatch/view/personal/customer/customer_edit_page.dart';
import 'package:dispatch/view/personal/worker/worker_edit_page.dart';
import 'package:dispatch/view/personal/worker/worker_home_page.dart';
import 'package:dispatch/view/personal/worker/worker_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkerBottomBarPage extends StatefulWidget {
  const WorkerBottomBarPage({super.key});

  @override
  _WorkerBottomBarPageState createState() => _WorkerBottomBarPageState();
}

class _WorkerBottomBarPageState extends State<WorkerBottomBarPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      bottomNavigationBar:  SizedBox(
        height: 70.h,
        child: BottomNavigationBar( 
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
               tooltip: '首頁',
              icon: Opacity(
                  opacity: 0.5,
                  child: Image.asset("assets/images/home.png", width: 20.w,height: 20.h,)),
              activeIcon:
                  Image.asset("assets/images/home_selected.png", width: 20.w,height: 20.h),
              label: '首頁',
            ),
            BottomNavigationBarItem(
               tooltip: '聊聊',
              icon: Opacity(
                  opacity: 0.5,
                  child: Image.asset("assets/images/message.png", width: 20.w,height: 20.h)),
              activeIcon:
                  Image.asset("assets/images/message_selected.png", width: 20.w,height: 20.h),
              label: '聊聊',
            ),
            BottomNavigationBarItem(
              tooltip: '關於我們',
              icon: Opacity(
                  opacity: 0.5,
                  child: Image.asset("assets/images/aboutUs.png", width: 20.w,height: 20.h,)),
              activeIcon:
                  Image.asset("assets/images/aboutUs_selected.png", width: 20.w,height: 20.h,),
              label: '關於我們',
            ),
            BottomNavigationBarItem(
               tooltip: '個人資料',
              icon: Opacity(
                  opacity: 0.5,
                  child: Image.asset("assets/images/profile.png", width: 20.w,height: 20.h)),
              activeIcon:
                  Image.asset("assets/images/profile_selected.png", width: 20.w,height: 20.h),
              label: '個人資料',
            ),
          ],
          selectedItemColor: Colors.black54,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: <Widget>[
        const WorkerHomePage(),
        Container(),
        const AboutUsPage(),
        const WorkerEditPage(),
      ][_selectedIndex],
    );
  }
}


