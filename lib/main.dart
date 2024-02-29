import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dragable'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double xAxisPosition = 0.0;
  double yAxisPosition = 0.0;
  Offset _position = Offset(0, AppBar().preferredSize.height);

  Offset textBorderPosition = Offset.zero;
  double textFontSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: yAxisPosition,
                left: xAxisPosition,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (value) {
                    setState(() {
                      textBorderPosition = value.localPosition;
                      textBorderPosition = Offset(value.localPosition.dx, value.localPosition.dy);
                    });
                  },
                  onPanUpdate: (value) {
                    setState(() {

                      final dx =
                          value.localPosition.dx - textBorderPosition.dx;
                      final dy =
                          value.localPosition.dy - textBorderPosition.dy;

                      final dragLength = Offset(dx, dy).distance;

                      print("textBorderPosition::${textBorderPosition}");
                      print("dtextBorderPosition::${textBorderPosition}");
                      print("dx: $dx, dy: $dy, dragLength: $dragLength");

                      textFontSize = 20.0 + (dragLength * 0.02);

                      print("FONT SIZE:::${textFontSize}");
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(border: Border.all(width: 40)),
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          _position = const Offset(0, 0);
                        });
                      },
                      onPanUpdate: (details) {
                        setState(() {
                          if (_position.dy + details.delta.dy >
                              AppBar().preferredSize.height) {
                            _position += details.delta;
                            xAxisPosition = _position.dx;
                            yAxisPosition = _position.dy;
                          }
                        });
                      },
                      child: Text(
                        'Drag the text on long press',
                        style: TextStyle(fontSize: textFontSize),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isOnBorder(Offset tapPosition, BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Size size = box.size;
    const double borderWidth = 40.0;

    return tapPosition.dx <= borderWidth ||
        tapPosition.dx >= size.width - borderWidth ||
        tapPosition.dy <= borderWidth ||
        tapPosition.dy >= size.height - borderWidth;
  }

}
