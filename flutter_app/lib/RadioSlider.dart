import 'package:flutter/material.dart';

class RadioSlider extends StatelessWidget {
  const RadioSlider(
      {Key key,
      this.width = 100,
      this.height = 5,
      this.progress = 1,
      this.min = 0,
      this.max = 2})
      : super(key: key);

  final double width;
  final double height;
  final int progress;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _RadioSliderPainter(
            width: width,
            height: height,
            progress: progress,
            min: min,
            max: max),
      ),
    );
  }
}

class _RadioSliderPainter extends CustomPainter {
  _RadioSliderPainter(
      {this.width, this.height, this.progress, this.min, this.max});

  final double width;
  final double height;
  final int progress;
  final int min;
  final int max;

  @override
  void paint(Canvas canvas, Size size) {
    //画底线
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.grey[600];
    canvas.drawLine(Offset(0, height / 2), Offset(width, height / 2), paint);

    //画刻度
    paint..strokeWidth = 2;
    double singleGraduateWidth = width / max - min;
    for (int i = 1; i < max - min; i++) {
      double dx = singleGraduateWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, height), paint);
    }

    //画指针
    paint
      ..strokeWidth = 4
      ..color = Colors.red;
    canvas.drawLine(Offset(singleGraduateWidth * progress, 0),
        Offset(singleGraduateWidth * progress, height), paint);
  }

  @override
  bool shouldRepaint(_RadioSliderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class SliderTest extends StatefulWidget {
  const SliderTest({Key key}) : super(key: key);

  @override
  _SliderTestState createState() => _SliderTestState();
}

class _SliderTestState extends State<SliderTest> {
  double _progress = 20;
  bool isUpdateProgress = false;

  void test(){
    if (!isUpdateProgress) {
      isUpdateProgress = true;
      Future.delayed(Duration(milliseconds: 200),(){
        print("xcjtest--------------------$_progress");
        isUpdateProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 3,
          thumbColor: Color(0xFFF01140),
          activeTrackColor: Colors.white,
          inactiveTrackColor: Color(0xff666666),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
          overlayShape: SliderComponentShape.noOverlay,
        ),
        child: Slider(
          value: _progress,
          min: 0,
          max: 62,
          onChanged: (value) {
            if (value != _progress) {
              _progress = value;
              print("xcjtest---------------------------***$_progress");
              test();
            }
            setState(() {
            });
          },

          onChangeEnd: (value){
            // print("onChangeEnd::$value");
          },
        ),
      ),
    );
  }
}

