import 'package:dispatch/view/register/ballpainter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_pickers/image_pickers.dart';

class FormBackground extends StatelessWidget {
  final Widget child;
  const FormBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.sizeOf(context).width);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 2 / 3,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
              bottom: 55.h,
              width: 600.w,
              height: 150.h,
              child: ClipOvalShadow(
                  shadow: BoxShadow(
                    blurStyle: BlurStyle.outer,
                    color: Colors.grey,
                    offset: Offset(0, 1),
                    blurRadius: 10,
                  ),
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    //)
                  ))),
          Positioned(
              child: Container(
            height: MediaQuery.of(context).size.height / 2 + 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              // boxShadow: [
              //   BoxShadow(
              //       offset: Offset(-1, -1) ,
              //       blurStyle: BlurStyle.outer,
              //       spreadRadius: 1,
              //       blurRadius: 1)
              // ]
            ),
          )),
          child,
        ],
      ),
    );
  }
}

class CustomClipperOval extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: new Offset(size.width / 2, size.width / 2),
        radius: size.width / 2 + 3);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class ClipOvalShadow extends StatelessWidget {
  final BoxShadow shadow;

  final Widget child;

  ClipOvalShadow({
    required this.shadow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipOvalShadowPainter(
        shadow: shadow,
      ),
      child: ClipRect(
        child: child,
      ),
    );
  }
}

class _ClipOvalShadowPainter extends CustomPainter {
  final BoxShadow shadow;

  _ClipOvalShadowPainter({
    required this.shadow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    Rect rect = Rect.fromPoints(
      const Offset(0, 0),
      Offset(600.w, 150.w),
    );
    //绘制椭圆
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
