import 'package:dispatch/model/oem_model.dart';
import 'package:dispatch/view/home_page.dart';
import 'package:dispatch/view/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kartal/kartal.dart';

class RequestWaitingPage extends StatefulWidget {
  final OEMModel oemModel;
  final bool isWorkerNoEmpty;
  const RequestWaitingPage(
      {super.key, required this.oemModel, required this.isWorkerNoEmpty});

  @override
  _RequestWaitingPageState createState() => _RequestWaitingPageState();
}

class _RequestWaitingPageState extends State<RequestWaitingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  String getRequestNumber(int number) {
    return "OEM${100000000 + number}";
  }

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
        child: buildForm(),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 220, 222, 223),
        child: Column(
          children: [
            widget.isWorkerNoEmpty
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        context.emptySizedHeightBoxLow3x,
                        Text(
                          "正在找尋合適的師傅...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF0063A2),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        context.emptySizedHeightBoxLow3x,
                        Padding(
                            padding: EdgeInsets.only(left: 40.w, right: 40.w),
                            child: Image.asset("assets/images/discover.png")),
                        context.emptySizedHeightBoxLow3x,
                        const Text(
                          "請您稍待片刻",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF0063A2),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        context.emptySizedHeightBoxLow3x,
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Image.asset(
                      "assets/images/appointed.png",
                      height: 400.h,
                    ),
                  ),
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "訂單編號：${getRequestNumber(int.parse(widget.oemModel.oem_id))}"),
                            Text(
                                "裝修地：${widget.oemModel.city}${widget.oemModel.area}${widget.oemModel.address} "),
                            Text(
                                "日期：${DateTime.fromMillisecondsSinceEpoch(int.parse(widget.oemModel.date) * 1000)}"),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 180.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomBarPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('OK'),
                        ),
                      ),
                      context.emptySizedHeightBoxHigh,
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
