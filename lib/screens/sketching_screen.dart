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
  late Color currentColor;

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
    currentColor = startingColor;
  }

  @override
  void dispose() {
    super.dispose();
    points.clear();
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);
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
          ),
          SketchingColorPicker(
              currentColor: currentColor,
              onTapColorPicker: () {
                showAboutDialog(context: context, children: [
                  SingleChildScrollView(
                    child: MaterialPicker(
                      pickerColor: currentColor,
                      onColorChanged: (Color color) => changeColor(color),
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
