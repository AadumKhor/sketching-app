import 'package:flutter/material.dart';
import 'package:sketching/utils/index.dart';

class Sketcher extends CustomPainter {
  //list of points which are to be painted
  final List<Line> lines;

  Sketcher(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    //properties of the paint used to draw
    Paint paint = Paint()
      ..color = SketchingColors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    // iterate through all the points
    // check if the initial and final points
    // are not null. If not null then draw using
    // canvas function.
    for (int i = 0; i < lines.length; ++i) {
      for (int j = 0; j < lines[i].path.length - 1; ++j) {
        paint.color = lines[i].color;
        paint.strokeWidth = lines[i].width;
        canvas.drawLine(lines[i].path[j], lines[i].path[j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.lines != lines;
  }
}
