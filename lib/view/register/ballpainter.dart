import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BallPainter extends CustomPainter {
  final double x, y;
  final double cSize;

  BallPainter({required this.x, required this.y, required this.cSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x, y), cSize, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}