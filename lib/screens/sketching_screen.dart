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
  late List<Offset?> points;
  static const startingColor = SketchingColors.blue;
  static const backgroundColor = SketchingColors.backgroundDefault;
  late Color currentBrushColor;
  late Color currentBackgroundColor;

  @override
  void onPanUpdate(DragUpdateDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point = box.globalToLocal(details.globalPosition);
    setState(() {
      points = List.from(points)..add(point);
    });
  }

  @override
  void onPanEnd(DragEndDetails details) {
    points.add(null);
  }

  @override
  void onPanStart(DragStartDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset point = box.globalToLocal(details.globalPosition);
    setState(() {
      points = [point];
    });
  }

  @override
  void initState() {
    super.initState();
    points = [];
    currentBrushColor = startingColor;
    currentBackgroundColor = backgroundColor;
  }

  @override
  void dispose() {
    super.dispose();
    points.clear();
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
            points: points,
            brushColor: currentBrushColor,
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
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SketchingColors.red,
        child: const Icon(Icons.refresh),
        tooltip: 'Clear Screen',
        onPressed: () {
          setState(() {
            points = [];
          });
        },
      ),
    );
  }
}
