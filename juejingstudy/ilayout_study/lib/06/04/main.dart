import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '附件',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            UploadPanel(),
          ],
        ),
      ),
    );
  }
}

class UploadPanel extends StatefulWidget {
  const UploadPanel({Key? key}) : super(key: key);

  @override
  State<UploadPanel> createState() => _UploadPanelState();
}

class _UploadPanelState extends State<UploadPanel> {
  List<String> images = [];

  List<String> defaultImages = [
    'assets/images/draw_bg3.webp',
    'assets/images/anim_draw.webp',
    'assets/images/draw_bg4.webp',
    'assets/images/base_draw.webp',
    'assets/images/wy_300x200.webp',
    'assets/images/head_icon/icon_0.webp',
    'assets/images/head_icon/icon_1.webp',
    'assets/images/head_icon/icon_2.webp',
    'assets/images/head_icon/icon_3.webp',
  ];

  final double spacing = 8;
  final double lineCount = 5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      double maxWidth = constraints.maxWidth;
      final boxWidth = (maxWidth - spacing * (lineCount - 1)) / lineCount;
      if (images.isEmpty) {
        return _buildAddBox(size: boxWidth);
      }
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [..._buildByImages(boxWidth), _buildAddBox(size: boxWidth)],
      );
    });
  }

  List<Widget> _buildByImages(double boxSize) {
    return images.map((imagePath) {
      ImageProvider image = AssetImage(imagePath);
      return Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: image,
            fit: BoxFit.cover,
            height: boxSize,
            width: boxSize,
          ),
          Positioned(right: 0, top: 0, child: _buildClose(imagePath, boxSize)),
        ],
      );
    }).toList();
  }

  _buildClose(String imagePath, double boxSize) {
    return GestureDetector(
      onTap: () => removeFile(imagePath),
      child: Container(
        alignment: Alignment.topRight,
        width: boxSize / 4,
        height: boxSize / 4,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
        ),
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: boxSize / 5,
        ),
      ),
    );
  }

  Widget _buildAddBox({double size = 60}) {
    return GestureDetector(
      onTap: doAddAction,
      child: Container(
        height: size,
        width: size,
        color: const Color(0xffF3F6F9),
        child: Icon(
          Icons.add,
          size: size / 2,
        ),
      ),
    );
  }

  int _addCounter = 0;

  void doAddAction() {
    images.add(defaultImages[_addCounter % defaultImages.length]);
    _addCounter++;
    setState(() {});
  }

  void removeFile(String imagePath) {
    images.remove(imagePath);
    setState(() {});
  }
}
