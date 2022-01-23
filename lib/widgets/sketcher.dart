import 'package:flutter/material.dart';

class Sketcher extends CustomPainter {
  //list of points which are to be painted
  final List<Offset?> points;

  Sketcher(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    //properties of the paint used to draw
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // iterate through all the points
    // check if the initial and final points
    // are not null. If not null then draw using
    // canvas function.
    for (int i = 0; i < points.length - 1; ++i) {
      if (points[i] == null) continue;
      if (points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.points != points;
  }
}
