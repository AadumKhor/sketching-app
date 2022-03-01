import 'package:flutter/material.dart';
import 'package:sketching/utils/index.dart';
import 'package:sketching/widgets/sketcher.dart';

class SketchingArea extends StatelessWidget {
  final List<Line> lines;
  final PanUpdate onPanUpdate;
  final PanEnd onPanEnd;
  final PanStart onPanStart;
  final Color? backgroundColor;

  const SketchingArea(
      {Key? key,
      this.backgroundColor = SketchingColors.backgroundDefault,
      required this.onPanEnd,
      required this.onPanStart,
      required this.onPanUpdate,
      required this.lines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) => onPanUpdate(details),
      onPanEnd: (DragEndDetails details) => onPanEnd(details),
      onPanStart: (DragStartDetails details) => onPanStart(details),
      child: RepaintBoundary(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: backgroundColor,
            child: CustomPaint(
              painter: Sketcher(lines),
            )),
      ),
    );
  }
}

typedef PanUpdate = void Function(DragUpdateDetails details);
typedef PanEnd = void Function(DragEndDetails details);
typedef PanStart = void Function(DragStartDetails details);
