import 'package:flutter/material.dart';

class SketchingStrokeWidth extends StatelessWidget {
  final List<double> strokeWidths;
  final int selectedIndex;
  final OnTapStrokeWidth onTapStrokeWidth;

  const SketchingStrokeWidth(
      {Key? key,
      required this.onTapStrokeWidth,
      required this.selectedIndex,
      required this.strokeWidths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

typedef OnTapStrokeWidth = void Function(int);
