import 'package:flutter/material.dart';

/// Flutter code sample for [Draggable].

void main() => runApp(const DraggableExampleApp());

class DraggableExampleApp extends StatelessWidget {
  const DraggableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Draggable Sample')),
        body: const DraggableExample(),
      ),
    );
  }
}

class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  int acceptedData = 0;
  int currentIndex = 0;
  List<String> images = [
    "1045782.png",
    "1151519.png",
    "1285341.png",
    "1647775.png",
    "1866475.png",
    "2948404.png",
    "3169476.png",
    "323262.png",
    "339400.png",
    "4611189.png",
    "5098930.png",
    "694730.png"
  ];
  List<String> acceptedCats = [];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Draggable<int>(
              // Data is the value this Draggable stores.
              data: 10,
              feedback: Container(
                width: screenHeight / 2,
                height: screenWidth / 2,
                child: Image.asset('assets/web/' + images[currentIndex]),
              ),
              childWhenDragging: Container(
                width: screenHeight,
                height: screenWidth,
                child: Image.asset('assets/web/' + images[currentIndex + 1]),
              ),
              child: Container(
                width: screenHeight,
                height: screenWidth,
                child: Image.asset('assets/web/' + images[currentIndex]),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  height: 100.0,
                  width: 100.0,
                  color: Color(0xff12d400),
                  child: Center(
                    child: Text('Accept'),
                  ),
                );
              },
              onAccept: (int data) {
                setState(() {
                  currentIndex = (currentIndex + 1) % images.length;
                  acceptedCats
                      .add(images[currentIndex]); // Save accepted filename
                  if (currentIndex == 10) {
                    currentIndex = 0;
                  }
                });
              },
            ),
            const SizedBox(width: 20.0),
            DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  height: 100.0,
                  width: 100.0,
                  color: Color(0xffd40000),
                  child: Center(
                    child: Text('Reject'),
                  ),
                );
              },
              onAccept: (int data) {
                setState(() {
                  currentIndex = (currentIndex + 1) % images.length;
                  if (currentIndex == 10) {
                    currentIndex = 0;
                  }
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Display the list of accepted filenames
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Accepted Cats'),
                      content: Column(
                        children: acceptedCats
                            .map((cat) => ListTile(title: Text(cat)))
                            .toList(),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Show Accepted Cats'),
            ),
          ],
        ),
      ],
    );
  }
}
