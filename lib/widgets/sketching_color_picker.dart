import 'package:flutter/material.dart';
import 'package:sketching/utils/index.dart';

class SketchingColorPicker extends StatelessWidget {
  final Color currentColor;
  final double paddingTop;
  final double paddingRight;
  final Color borderColor;
  final OnTapColorPicker onTapColorPicker;

  const SketchingColorPicker(
      {Key? key,
      this.borderColor = SketchingColors.black,
      required this.currentColor,
      required this.onTapColorPicker,
      this.paddingRight = 10.0,
      this.paddingTop = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop, right: paddingRight),
        child: GestureDetector(
          onTap: onTapColorPicker,
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
                color: currentColor,
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 4.0)),
          ),
        ),
      ),
    );
  }
}

typedef OnTapColorPicker = void Function();
