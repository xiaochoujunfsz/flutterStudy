import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      child: HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<Polar> polar =
      ValueNotifier(Polar(len: 0.6, deg: 45 * pi / 180));

  @override
  void dispose() {
    polar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: ColoredBox(
                color: Colors.orange.withOpacity(0.2),
                child: buildDiyChildLayout(),
              ),
            ),
          ),
          buildTools(),
        ],
      ),
    );
  }

  Widget buildDiyChildLayout() {
    return CustomSingleChildLayout(
      delegate: PolarLayoutDelegate(polar: polar),
      child: const SizedBox(
        width: 20,
        height: 20,
        child: ColoredBox(
          color: Colors.blue,
          child: Center(
            child: Text(
              '子',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTools() {
    return ValueListenableBuilder<Polar>(
        valueListenable: polar,
        builder: (_, Polar value, __) => Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Slider(
                    value: value.deg,
                    max: 2 * pi,
                    min: 0,
                    onChanged: (v) {
                      polar.value = Polar(len: value.len, deg: v);
                    },
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Text(
                        "角度: ${(value.deg * 180 / pi).toStringAsFixed(1)}")),
                Expanded(
                  flex: 2,
                  child: Slider(
                      value: value.len,
                      max: 1,
                      min: 0,
                      onChanged: (v) {
                        polar.value = Polar(len: v, deg: value.deg);
                      }),
                ),
                Expanded(child: Text("长度分率:${value.len.toStringAsFixed(1)}")),
              ],
            ));
  }
}

class Polar {
  final double len;
  final double deg;

  Polar({required this.len, required this.deg});
}

class PolarLayoutDelegate extends SingleChildLayoutDelegate {
  final ValueListenable<Polar> polar;

  PolarLayoutDelegate({required this.polar}) : super(relayout: polar);

  @override
  bool shouldRelayout(PolarLayoutDelegate oldDelegate) =>
      oldDelegate.polar != polar;

  @override
  Size getSize(BoxConstraints constraints) {
    final radius = constraints.biggest.shortestSide;
    return Size(radius, radius);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double r = size.width / 2 * polar.value.len;
    Offset center = Offset(size.width / 2, size.height / 2);
    Offset offset = Offset(r * cos(polar.value.deg), r * sin(polar.value.deg));
    Offset childSizeOffset = Offset(childSize.width / 2, childSize.height / 2);
    return center + offset - childSizeOffset;
  }
}
