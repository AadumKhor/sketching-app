import 'package:flutter/material.dart';
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
  }

  @override
  void dispose() {
    super.dispose();
    points.clear();
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
