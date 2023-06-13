import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'map_root.dart';

class ChinaMap extends StatefulWidget {
  const ChinaMap({Key? key}) : super(key: key);

  @override
  State<ChinaMap> createState() => _ChinaMapState();
}

class _ChinaMapState extends State<ChinaMap> {
  //全国点位详细信息
  final String url =
      "https://geo.datav.aliyun.com/areas_v2/bound/100000_full.json";
  late Future<MapRoot?> _future;

  @override
  void initState() {
    super.initState();
    _future = getMapRoot();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MapRoot?>(
      future: _future,
      builder: (context, async) {
        if (async.hasData) {
          return CustomPaint(
            size: const Size(500, 400),
            painter: MapPainter(mapRoot: async.data),
          );
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }

  //请求点位信息信息
  Future<MapRoot?> getMapRoot() async {
    try {
      final Response response = await Dio().get(url);
      if (response.data != null) {
        return MapRoot.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class MapPainter extends CustomPainter {
  final MapRoot? mapRoot; //点位信息
  late Paint _paint;
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];
  int colorIndex = 0;

  MapPainter({required this.mapRoot}) {
    _paint = Paint()
      ..strokeWidth = 0.1
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (mapRoot == null) return;
    if (mapRoot!.features == null) return;

    canvas.clipRect(
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));
    canvas.translate(size.width / 2, size.height / 2);
    double dx = mapRoot!.features![0]?.geometry?.coordinates[0][0][0].dx ?? 0;
    double dy = mapRoot!.features![0]?.geometry?.coordinates[0][0][0].dy ?? 0;
    canvas.translate(-dx, -dy);

    double rate = 0.65;

    canvas.translate(-700 * rate, 350 * rate);
    canvas.scale(8 * rate, -10.5 * rate);

    _drawMap(canvas, size);
  }

  @override
  bool shouldRepaint(MapPainter oldDelegate) => oldDelegate.mapRoot != mapRoot;

  void _drawMap(Canvas canvas, Size size) {
    //全国省份循环
    for (int i = 0; i < mapRoot!.features!.length; i++) {
      var features = mapRoot!.features![i];
      if (features == null) return;
      PaintingStyle style;
      Color color;
      Path path = Path();
      if (features.properties?.name == "台湾省" ||
          features.properties?.name == "海南省" ||
          features.properties?.name == "河北省" ||
          features.properties?.name == "") {
        //海南和台湾和九段线
        features.geometry?.coordinates.forEach((List<List<Offset>> lv3) {
          lv3.forEach((List<Offset> lv2) {
            path.moveTo(lv2[0].dx, lv2[0].dy);
            lv2.forEach((Offset lv1) {
              //优化一半点位
              path.lineTo(lv1.dx, lv1.dy);
            });
          });
        });

        if (features.properties?.name == "") {
          style = PaintingStyle.stroke;
          color = Colors.black;
        } else {
          style = PaintingStyle.fill;
          color = colors[colorIndex % 4];
        }
        colorIndex++;
      } else {
        final Offset first =
            features.geometry?.coordinates[0][0][0] ?? Offset.zero;
        path.moveTo(first.dx, first.dy);
        if (features.geometry == null) return;
        for (Offset d in features.geometry!.coordinates.first.first) {
          path.lineTo(d.dx, d.dy);
        }
        style = PaintingStyle.fill;
        color = colors[colorIndex % 4];
        colorIndex++;
      }
      //绘制地图
      canvas.drawPath(
          path,
          _paint
            ..color = color
            ..style = style);
    }
  }
}
