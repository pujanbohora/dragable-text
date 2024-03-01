import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Draggable'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double xAxisPosition = 0.0;
  double yAxisPosition = 0.0;
  // Offset _position = Offset(0, AppBar().preferredSize.height);

  Offset textBorderPosition = Offset.zero;
  double textFontSize = 20.0; // Initial font size
  double borderSize = 1; // Initial border width
  bool isDragAbleItemDropped = false;

  Offset dragWidgetPosition = Offset.zero;

  //change draggable widget position
  double xAxisDragPosition = 0.0;
  double yAxisDragPosition = 0.0;

  //controller
  TextEditingController addTextController = TextEditingController();
  var addTextOnChangeValue = "";

  //show textfield bool
  bool showTextFieldAddedText = true;

  //Text Color
  Color textColorChange = Colors.black;

  //Container height and width

  Offset containerBorderToStretch = Offset.zero;
  double containerWidth = 100;
  double containerHeight = 100;
  double minContainerWidth = 50;
  double minContainerHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            const Text("Edit Text"),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Expanded(flex: 1, child: Text("Font size")),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    onChanged: (text) {
                      setState(() {
                        double textToDouble = double.parse(text);
                        textFontSize = textToDouble;
                      });
                    },
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 1, child: Text("Text Color")),
                Expanded(
                  flex: 3,
                  child: ColorPicker(
                    onColorChanged: (Color value) {
                      setState(() {
                        textColorChange = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          child: Center(
            child: Stack(
              children: <Widget>[
                //DragTarget
                Positioned(
                  top: null,
                  bottom: null,
                  left: null,
                  right: null,
                  child: Center(
                    child: DragTarget(
                      builder: (BuildContext context, List<dynamic> accepted,
                          List<dynamic> rejected) {
                        return Container();
                      },
                      onAccept: (Color color) {
                        setState(() {
                          isDragAbleItemDropped = true;
                        });
                      },
                    ),
                  ),
                ),

                //Show Draggable Widget on complete i.e; (textEditingController)
                Positioned(
                    top: dragWidgetPosition.dy - 56,
                    left: dragWidgetPosition.dx,
                    child: Opacity(
                      opacity: isDragAbleItemDropped && showTextFieldAddedText
                          ? 1
                          : 0,
                      child: Container(
                        height: 100,
                        width: 200,
                        color: Colors.transparent,
                        child: Visibility(
                          visible:
                              isDragAbleItemDropped && showTextFieldAddedText,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        showTextFieldAddedText = false;
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color: Colors.red),
                                        child: const Icon(Icons.close,
                                            color: Colors.white)),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isDragAbleItemDropped = false;
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color: Colors.green),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              TextFormField(
                                controller: addTextController,
                                onChanged: (text) {
                                  setState(() {
                                    addTextOnChangeValue = text;
                                  });
                                },
                                readOnly: !isDragAbleItemDropped,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),

                //Draggable
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        children: [
                          Draggable(
                            data: Colors.grey,
                            feedback: Material(
                              child: GestureDetector(
                                onPanStart: (value) {},
                                onPanUpdate: (value) {},
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  color: Colors.transparent,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            childWhenDragging: const Text("Add Text"),
                            child: const Text("Add Text"),
                            onDragCompleted: () {
                              setState(() {
                                isDragAbleItemDropped = true;
                              });
                            },
                            onDragEnd: (position) {
                              setState(() {
                                dragWidgetPosition = position.offset;
                              });
                            },
                          ),
                        ],
                      ),
                    )),

                Positioned(
                  // top: yAxisPosition,
                  // left: xAxisPosition,
                  top: dragWidgetPosition.dy - 40,
                  left: dragWidgetPosition.dx,
                  child: Visibility(
                    visible: !isDragAbleItemDropped,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanStart: (value) {
                        setState(() {
                          textBorderPosition = value.localPosition;
                        });
                      },
                      onPanUpdate: (value) {
                        setState(() {
                          final dx =
                              value.localPosition.dx - textBorderPosition.dx;
                          final dy =
                              value.localPosition.dy - textBorderPosition.dy;
                          final dragLength = Offset(dx, dy).distance;

                          // Determine the direction of the drag
                          final dragDirection = Offset(dx, dy) / dragLength;

                          // Determine whether to increase or decrease font size based on drag direction
                          final scaleFactor =
                              dragDirection.dy > 0 ? 0.02 : -0.02;

                          // Adjust font size accordingly
                          textFontSize += dragLength * scaleFactor;

                          // Ensure font size doesn't go below a minimum value
                          textFontSize = textFontSize.clamp(10.0, 50.0);
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.resizeUpDown,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: borderSize)),
                          child: GestureDetector(
                            onDoubleTap: () {
                              setState(() {
                                // dragWidgetPosition = const Offset(0, 0);
                                isDragAbleItemDropped = !isDragAbleItemDropped;
                              });
                            },
                            onPanUpdate: (details) {
                              setState(() {
                                if (dragWidgetPosition.dy + details.delta.dy >
                                    AppBar().preferredSize.height) {
                                  dragWidgetPosition += details.delta;
                                  xAxisPosition = dragWidgetPosition.dx;
                                  yAxisPosition = dragWidgetPosition.dy;
                                }
                              });
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                addTextOnChangeValue,
                                style: TextStyle(
                                    fontSize: textFontSize,
                                    color: textColorChange),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //Only Container
                Positioned(
                  // top: 1000,
                  // left: 1000,
                  top: dragWidgetPosition.dy,
                  left: dragWidgetPosition.dx,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanStart: (value) {
                      setState(() {
                        containerBorderToStretch = value.localPosition;
                      });
                    },
                    onPanUpdate: (value) {
                      setState(() {
                        final dx = value.localPosition.dx -
                            containerBorderToStretch.dx;
                        final dy = value.localPosition.dy -
                            containerBorderToStretch.dy;
                        final dragLength = Offset(dx, dy).distance;

                        // Determine the direction of the drag
                        final dragDirection = Offset(dx, dy) / dragLength;

                        // Calculate the scaleFactor based on drag direction
                        final scaleFactor = dragDirection.dy > 0 ? 0.02 : -0.02;

                        // Calculate new width and height
                        double newWidth = containerWidth + (dx * scaleFactor);
                        double newHeight = containerHeight + (dy * scaleFactor);

                        // Update container width and height, ensuring they stay within the constraints
                        containerWidth =
                            newWidth.clamp(minContainerWidth, double.infinity);
                        containerHeight = newHeight.clamp(
                            minContainerHeight, double.infinity);
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeUpDown,
                      child: Container(
                        height: containerHeight,
                        width: containerWidth,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: borderSize)),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            "addTextOnChangeValue",
                            style: TextStyle(
                                fontSize: textFontSize, color: textColorChange),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
