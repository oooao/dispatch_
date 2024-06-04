import 'package:dispatch/util/common.dart';
import 'package:dispatch/view/home_page.dart';
import 'package:dispatch/view/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class RequestCompletePage extends StatefulWidget {
  final int request_id;
  final String pickup_address;
  final String delivery_address;

  const RequestCompletePage(
      {super.key,
      required this.request_id,
      required this.pickup_address,
      required this.delivery_address});
  @override
  _RequestCompletePageState createState() => _RequestCompletePageState();
}

class _RequestCompletePageState extends State<RequestCompletePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 220, 222, 223),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "發送成功",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF0063A2),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      context.emptySizedHeightBoxLow3x,
                      Padding(
                        padding: EdgeInsets.only(left: 40.w, right: 40.w),
                        child: Image.asset("assets/images/truck.png",
                            color: primaryTextColor),
                      ),
                      context.emptySizedHeightBoxLow3x,
                      Text(
                        "您的配送需求已發送\n請等待通知",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF0063A2),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("訂單編號：${getRequestNumber(widget.request_id)}"),
                      Text("取貨地：${widget.pickup_address}"),
                      Text("送達地：${widget.delivery_address}"),
                      context.emptySizedHeightBoxLow3x,
                      SizedBox(
                        width: 180.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (c) => const BottomBarPage()),
                                (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('OK'),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
