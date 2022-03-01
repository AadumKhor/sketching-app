import 'package:flutter/material.dart';
import 'package:sketching/utils/index.dart';

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
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: List.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        onTapStrokeWidth(index);
                      },
                      child: Container(
                        width: strokeWidths[index] * 10.0,
                        height: strokeWidths[index] * 10.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: SketchingColors.black),
                      )),
                )),
      ),
    );
  }
}

typedef OnTapStrokeWidth = void Function(int);
