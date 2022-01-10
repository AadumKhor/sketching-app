import 'package:flutter/material.dart';
import 'package:sketching/sketcher.dart';

// Sketching app for Flutter!
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sketching App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Offset?> points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// For future blogs, the Stack widget is suitable xD
      body: Stack(
        children: [sketchArea()],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.refresh),
        tooltip: 'Clear Screen',
        onPressed: () {
          setState(() {
            points.clear();
          });
        },
      ),
    );
  }

  /// Best to have this as a separate widget, but for the purpose of keeping things simple this
  /// is kept here.
  GestureDetector sketchArea() {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        Offset point = box.globalToLocal(details.globalPosition);
        setState(() {
          points = List.from(points)..add(point);
        });
      },
      onPanEnd: (DragEndDetails details) {
        points.add(null);
      },
      /// This method can be uncommented if each time you draw you would want to 
      /// start a new drawing. This will reset the `points` array. 
      /// 
      // onPanStart: (DragStartDetails details) {
      //   RenderBox box = context.findRenderObject() as RenderBox;
      //   Offset point = box.globalToLocal(details.globalPosition);
      //   setState(() {
      //     points = [point];
      //   });
      // },
      child: RepaintBoundary(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.yellow[100],
            child: CustomPaint(
              painter: Sketcher(points),
            )),
      ),
    );
  }
}
