import 'dart:ui';
import 'package:flutter/material.dart';

class TransitionAnim extends StatelessWidget {
  TransitionAnim({
    Key? key,
    this.animation,
  })  : assert(animation != null),
        super(key: key);

  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return IgnorePointer(
      ignoring: true,
      child: CustomPaint(
        size: Size(size.width, size.height),
        painter: TransitionPainter(animation: animation),
      ),
    );
  }
}

class TransitionPainter extends CustomPainter {
  /// Consturctor [TransitionPainter].
  TransitionPainter({
    required Animation<double>? animation,
    this.firstColor,
    this.secondColor,
    this.thirdColor,
  })  : firstPaint = Paint()
          ..color = firstColor ?? Colors.red
          ..style = PaintingStyle.fill,
        secondPaint = Paint()
          ..color = secondColor ?? Colors.orange
          ..style = PaintingStyle.fill,
        thirdPaint = Paint()
          ..color = thirdColor ?? Colors.yellow
          ..style = PaintingStyle.fill,
        firstAnimation = CurvedAnimation(
          parent: animation!,
          curve: Interval(0.0, 0.8, curve: Curves.elasticOut),
        ),
        secondAnimation = CurvedAnimation(
          parent: animation,
          curve: Interval(0.0, 0.9, curve: Curves.elasticOut),
        ),
        thirdAnimation = CurvedAnimation(
          parent: animation,
          curve: Interval(0.0, 0.8, curve: Curves.elasticOut),
        ),
        liquidAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
        super(repaint: animation);

  /// Big one paint.
  final Paint firstPaint;

  /// Medium one paint.
  final Paint secondPaint;

  /// Small one paint.
  final Paint thirdPaint;

  /// [Color] painting.
  final Color? firstColor;
  final Color? secondColor;
  final Color? thirdColor;

  /// [Animation] double each one.
  final Animation<double>? liquidAnimation;
  final Animation<double>? firstAnimation;
  final Animation<double>? secondAnimation;
  final Animation<double>? thirdAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBigOnePaint(canvas, size);
    _drawMediumOnePaint(canvas, size);
    _drawSmallOnePaint(canvas, size);
  }

  void _drawBigOnePaint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.lineTo(
      0,
      lerpDouble(0.0, size.height, firstAnimation!.value)!,
    );
    path.quadraticBezierTo(
      lerpDouble(size.width / 3, size.width / 2, firstAnimation!.value)!,
      lerpDouble(size.height / 1.5, size.height, firstAnimation!.value)!,
      lerpDouble(size.width, size.width / 1.8, firstAnimation!.value)!,
      lerpDouble(size.height / 2, size.height / 1.3, firstAnimation!.value)!,
    );
    path.quadraticBezierTo(
      lerpDouble(size.width, size.width / 2, firstAnimation!.value)!,
      lerpDouble(size.height / 2, size.height / 2, firstAnimation!.value)!,
      lerpDouble(size.width, size.width, firstAnimation!.value)!,
      lerpDouble(size.height / 2, size.height / 2, firstAnimation!.value)!,
    );

    canvas.drawPath(path, firstPaint);
  }

  void _drawMediumOnePaint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height / 4);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 4);
    path.quadraticBezierTo(
      lerpDouble(size.width / 4, size.width / 6, secondAnimation!.value)!,
      lerpDouble(size.height / 1.4, size.height / 1.4, secondAnimation!.value)!,
      lerpDouble(size.width / 2, size.width / 2, secondAnimation!.value)!,
      lerpDouble(size.height / 3, size.height / 2, secondAnimation!.value)!,
    );
    path.quadraticBezierTo(
      lerpDouble(size.width / 1.6, size.width / 1.5, secondAnimation!.value)!,
      lerpDouble(size.height / 8, size.height / 3, secondAnimation!.value)!,
      lerpDouble(size.width, size.width, secondAnimation!.value)!,
      lerpDouble(size.height / 4, size.height / 4, secondAnimation!.value)!,
    );
    canvas.drawPath(path, secondPaint);
  }

  void _drawSmallOnePaint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0.0, 0.0);
    path.quadraticBezierTo(
      lerpDouble(0.0, size.width / 10, thirdAnimation!.value)!,
      lerpDouble(0.0, size.height / 4, thirdAnimation!.value)!,
      lerpDouble(0.0, size.width / 3, thirdAnimation!.value)!,
      lerpDouble(0.0, size.height / 6, thirdAnimation!.value)!,
    );

    path.quadraticBezierTo(
      lerpDouble(0.0, size.width / 2.5, thirdAnimation!.value)!,
      lerpDouble(0.0, size.height / 8, thirdAnimation!.value)!,
      lerpDouble(0.0, size.width / 1.4, thirdAnimation!.value)!,
      lerpDouble(0.0, size.height / 6.5, thirdAnimation!.value)!,
    );

    path.quadraticBezierTo(
      lerpDouble(0.0, size.width, thirdAnimation!.value)!,
      lerpDouble(0.0, size.height / 7, thirdAnimation!.value)!,
      lerpDouble(0.0, size.width, thirdAnimation!.value)!,
      lerpDouble(0.0, 0, thirdAnimation!.value)!,
    );
    canvas.drawPath(path, thirdPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
