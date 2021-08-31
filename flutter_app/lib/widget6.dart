import 'package:flutter/material.dart';
import 'package:flutter_app/main6.dart';
import 'package:flutter_app/widget4.dart';

import 'DraggableFloatingActionButton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).title),
      ),
      body: Center(
        child: Column(
          children: [
            GradientButton(
              child: Text("single_scroll"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "single_scroll");
              },
            ),
            GradientButton(
              child: Text("my_image_test"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "my_image_test");
              },
            ),
            GradientButton(
              child: Text("draggable_button_test"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "draggable_button_test");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SingleScrollPage extends StatelessWidget {
  const SingleScrollPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("scroll"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              "编号:",
              style: TextStyle(color: Colors.red),
            ),
            Text("头0000000000001 "),
            Text(
                "0000000000001 00000000000010000000000001000000000000100000000000010000000000001000000000000100000000000010000000000001000000000000100000000000010000000000001000000000000尾"),
          ],
        ),
      ),
    );
  }
}

class MyImage extends StatefulWidget {
  const MyImage({Key key, @required this.imageProvider})
      : assert(imageProvider != null),
        super(key: key);

  final ImageProvider imageProvider;

  @override
  _MyImageState createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  ImageStream _imageStream;
  ImageInfo _imageInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //依赖改变时，图片的配置信息可能会发生改变
    _getImage();
  }

  @override
  void didUpdateWidget(covariant MyImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageProvider != oldWidget.imageProvider) {
      _getImage();
    }
  }

  void _getImage() {
    final ImageStream oldImageStream = _imageStream;
    // 调用imageProvider.resolve方法，获得ImageStream。
    _imageStream =
        widget.imageProvider.resolve(createLocalImageConfiguration(context));
    //判断新旧ImageStream是否相同，如果不同，则需要调整流的监听器
    if (_imageStream.key != oldImageStream?.key) {
      final ImageStreamListener listener = ImageStreamListener(_updateImage);
      oldImageStream?.removeListener(listener);
      _imageStream.addListener(listener);
    }
  }

  void _updateImage(ImageInfo image, bool synchronousCall) {
    setState(() {
      _imageInfo = image;
    });
  }

  @override
  void dispose() {
    _imageStream.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawImage(
      image: _imageInfo?.image,
      scale: _imageInfo?.scale ?? 1.0,
    );
  }
}

class MyImageTestPage extends StatelessWidget {
  const MyImageTestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片加载原理与缓存"),
      ),
      body: Column(
        children: [
          MyImage(
              imageProvider: NetworkImage(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"))
        ],
      ),
    );
  }
}

class DraggableFloatingActionTest extends StatelessWidget {
  final GlobalKey _parentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Draggable Floating Action Button"),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
          ),
          Container(
            width: 300,
            height: 300,
            child: Stack(
              key: _parentKey,
              children: [
                Container(color: Colors.cyan),
                Center(
                  child: const Text(
                    "FlutterDev's.com",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                DraggableFloatingActionButton(
                  child: Image.asset("images/icon_car.png",width: 30,height: 30,),
                  alignment: Alignment.centerRight,
                  parentKey: _parentKey,
                  onPressed: () {},
                  xCanDraggable: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

