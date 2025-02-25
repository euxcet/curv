import 'dart:math';

import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = Color(0xffFF6161).withAlpha(50)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    Paint paint1Fill = Paint()
      ..color = Color(0xffFF6161)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    // 绘制半圆，起始角度为 180°，结束角度为 360°，半径为 size.width / 2
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    canvas.drawArc(rect, 3.14, 3.14, false, paint1); // 绘制半圆

    canvas.drawArc(rect, 3.14, 3.14 / 2, false, paint1Fill); // 绘制半圆

    Paint paint2 = Paint()
      ..color = Colors.blue.withAlpha(50)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    Paint paint2Fill = Paint()
      ..color = Colors.blue
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    // 绘制半圆，起始角度为 180°，结束角度为 360°，半径为 size.width / 2
    Rect rect2 = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2 - 25);
    canvas.drawArc(rect2, 3.14, 3.14, false, paint2); // 绘制半圆
    canvas.drawArc(rect2, 3.14, 3.14 * 0.7, false, paint2Fill); // 绘制半圆

    Paint paint3 = Paint()
      ..color = Color(0xffC34DC5).withAlpha(50)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    Paint paint3Fill = Paint()
      ..color = Color(0xffC34DC5)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    // 绘制半圆，起始角度为 180°，结束角度为 360°，半径为 size.width / 2
    Rect rect3 = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2 - 50);
    canvas.drawArc(rect3, 3.14, 3.14, false, paint3); // 绘制半圆
    canvas.drawArc(rect3, 3.14, 3.14 * 0.7, false, paint3Fill); // 绘制半圆
  }

  // 根据角度和半径计算圆上的点
  Offset _getPointOnCircle(Offset center, double radius, double angle) {
    double x = center.dx + radius * cos(angle);
    double y = center.dy + radius * sin(angle);
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 如果不需要重新绘制，可以返回 false
  }
}
