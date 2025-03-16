import 'dart:math' as math;
import 'package:flutter/material.dart';

class LoaderAnimation extends CustomPainter {
  final double progress;

  LoaderAnimation({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint =
        Paint()
          ..shader = RadialGradient(
            colors: [Colors.grey.shade400, Colors.grey.shade200],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: size.width / 3,
            ),
          )
          ..style = PaintingStyle.fill;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 3, circlePaint);

    Paint arcPaint =
        Paint()
          ..shader = SweepGradient(
            colors: [Color(0xff034C53), Color(0xff007074), Color(0xff57B4BA)],
            stops: [0.0, 0.5, 1.0],
          ).createShader(
            Rect.fromCircle(center: center, radius: size.width / 2),
          )
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8.0
          ..strokeCap = StrokeCap.round;

    double startAngle = -math.pi / 2;
    double sweepAngle = 2 * math.pi * progress;
    Rect rect = Rect.fromCenter(
      center: center,
      width: size.width * 0.8,
      height: size.height * 0.8,
    );

    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant LoaderAnimation oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
