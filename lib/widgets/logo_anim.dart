import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoAnim extends AnimatedWidget {
  LogoAnim({
    Key? key,
    this.height,
    this.width,
    this.color,
    required this.animation,
  })   : assert(height != null && width != null),
        super(key: key, listenable: animation);

  final double? height;
  final double? width;
  final Color? color;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40.0,
      width: width ?? 40.0,
      color: color ?? null,
      child: CustomPaint(
        size: Size(width ?? 40.0, height ?? 40.0),
        painter: LogoPaint(
          offset: animation
              .drive(Tween(begin: 0.0, end: 1.0)
                  .chain(CurveTween(curve: Curves.linear)))
              .value,
          color: Colors.red,
        ),
      ),
    );
  }
}

class LogoPaint extends CustomPainter {
  LogoPaint({
    this.color,
    required this.offset,
  })   : logoPaint = Paint()
          ..color = color ?? Colors.red
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10.0,
        super();

  final Color? color;
  final double? offset;
  final Paint logoPaint;

  @override
  void paint(Canvas canvas, Size size) {
    _drawLogo(canvas, size);
  }

  void _drawLogo(Canvas canvas, Size size) {
    Path path = createPath(size);
    PathMetric pathMetric = path.computeMetrics().first;
    Path extracthPath =
        pathMetric.extractPath(0.0, (pathMetric.length * offset!));
    canvas.drawPath(extracthPath, logoPaint);
  }

  Path createPath(Size size) {
    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
