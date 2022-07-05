import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinningLines extends StatelessWidget {
  final double size;
  final Color color;

  const SpinningLines({Key key, @required this.size, @required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SpinKitSpinningLines(
      color: color,
      size: size,
    );
  }
}
