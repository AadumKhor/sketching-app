import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sketching/utils/index.dart';
import 'package:sketching/widgets/index.dart';

class SketchingScreen extends StatefulWidget {
  const SketchingScreen({Key? key}) : super(key: key);

  @override
  _SketchingScreenState createState() => _SketchingScreenState();
}

class _SketchingScreenState extends State<SketchingScreen>
    implements SketchingMethods {
  static const startingColor = SketchingColors.blue;
  static const backgroundColor = SketchingColors.backgroundDefault;
  static const strokeWidths = [1.0, 2.0, 4.0];

  late List<Line> lines;
  late Line line;
  late Color currentBrushColor;
  late Color currentBackgroundColor;
  late int selectedIndex; // for stroke width

  @override
  void onPanUpdate(DragUpdateDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point = box.globalToLocal(details.globalPosition);
    List<Offset> path = List.from(line.path)..add(point);
    line = Line(path, currentBrushColor, getStrokeWidth());

    setState(() {
      if (lines.isEmpty) {
        lines.add(line);
      } else {
        lines[lines.length - 1] = line;
      }
    });
  }

  @override
  void onPanEnd(DragEndDetails details) {
    setState(() {
      lines.add(line);
    });
  }

  @override
  void onPanStart(DragStartDetails details) {
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);
    setState(() {
      line = Line([point], currentBrushColor, getStrokeWidth());
    });
  }

  @override
  void initState() {
    super.initState();
    lines = [];
    currentBrushColor = startingColor;
    currentBackgroundColor = backgroundColor;
    selectedIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
    lines.clear();
  }

  void changeBrushColor(Color color) {
    setState(() => currentBrushColor = color);
    Navigator.of(context).pop();
  }

  void changeBackgroundColor(Color color) {
    setState(() {
      currentBackgroundColor = color;
    });
    Navigator.of(context).pop();
  }

  double getStrokeWidth() {
    return strokeWidths[selectedIndex] * 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// For future blogs, the Stack widget is suitable xD
      body: Stack(
        alignment: Alignment.center,
        children: [
          SketchingArea(
            onPanEnd: onPanEnd,
            onPanStart: onPanStart,
            onPanUpdate: onPanUpdate,
            lines: lines,
            backgroundColor: currentBackgroundColor,
          ),
          SketchingColorPicker(
              currentColor: currentBrushColor,
              onTapColorPicker: () {
                showAboutDialog(context: context, children: [
                  SingleChildScrollView(
                    child: MaterialPicker(
                      pickerColor: currentBrushColor,
                      onColorChanged: (Color color) => changeBrushColor(color),
                    ),
                  )
                ]);
              }),
          SketchingColorPicker(
              currentColor: currentBackgroundColor,
              paddingTop: 100.0,
              onTapColorPicker: () {
                showAboutDialog(context: context, children: [
                  SingleChildScrollView(
                    child: MaterialPicker(
                      pickerColor: currentBackgroundColor,
                      onColorChanged: (Color color) =>
                          changeBackgroundColor(color),
                    ),
                  )
                ]);
              }),
          SketchingStrokeWidth(
              onTapStrokeWidth: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              selectedIndex: selectedIndex,
              strokeWidths: strokeWidths)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SketchingColors.red,
        child: const Icon(Icons.refresh),
        tooltip: 'Clear Screen',
        onPressed: () {
          setState(() {
            lines = [];
          });
        },
      ),
    );
  }
}
