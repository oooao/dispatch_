import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharityPage extends StatefulWidget {
  const CharityPage({super.key});

  @override
  _CharityPageState createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      appBar: AppBar(
        title: Image.asset('assets/images/TextLogo.png'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: Image.asset('assets/images/charitable_image1.png'),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '吉時行善',
                style: TextStyle(
                    color: Color(0xff0069ab),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 3.5,
                    fontFamily: 'MicrosoftYaHei'),
              ),
            ),
            Text(
              '吉時上工成立多年，始終秉持著回饋社會的心，並相信真正的快樂，來自於及時行善，手心向上是為了贏得客戶的信任及支持；手心向下則是我們對偏鄉孩童及落勢族群的重視。我們是造家的產業，而家的組成是以人為本，客戶與我們合作完成後的平台回饋，公司方會自動從中撥款給慈善基金會（客戶端能自由選擇），讓我們一起發展善的循環。',
              softWrap: true,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontFamily: 'MicrosoftYaHei',
                  letterSpacing: 3.6,
                  height: 2,
                  color: Color(0xff0069ab),
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/images/charitable_boy.png',
                    width: 150,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
