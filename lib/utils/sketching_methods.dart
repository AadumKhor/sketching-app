import 'package:flutter/material.dart';

abstract class SketchingMethods {
  void onPanUpdate(DragUpdateDetails details);
  void onPanEnd(DragEndDetails details);
  void onPanStart(DragStartDetails details);
}
