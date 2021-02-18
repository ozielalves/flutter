import 'package:flutter/material.dart';

class TopRightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(206 * _xScaling, 200 * _yScaling);
    path.cubicTo(
      189.262 * _xScaling,
      117.052 * _yScaling,
      159.607 * _xScaling,
      109.029 * _yScaling,
      102.134 * _xScaling,
      95.7411 * _yScaling,
    );
    path.cubicTo(
      39.853 * _xScaling,
      82.589 * _yScaling,
      13.5219 * _xScaling,
      66.313 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      0 * _yScaling,
      206 * _xScaling,
      0 * _yScaling,
      206 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      206 * _xScaling,
      0 * _yScaling,
      206 * _xScaling,
      200 * _yScaling,
      206 * _xScaling,
      200 * _yScaling,
    );
    path.cubicTo(
      206 * _xScaling,
      200 * _yScaling,
      206 * _xScaling,
      200 * _yScaling,
      206 * _xScaling,
      200 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class TopRightClipperBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(212 * _xScaling, 184 * _yScaling);
    path.cubicTo(
      195.262 * _xScaling,
      101.052 * _yScaling,
      165.607 * _xScaling,
      93.029 * _yScaling,
      108.134 * _xScaling,
      79.7411 * _yScaling,
    );
    path.cubicTo(
      45.853 * _xScaling,
      66.589 * _yScaling,
      19.5219 * _xScaling,
      50.313 * _yScaling,
      6 * _xScaling,
      -16 * _yScaling,
    );
    path.cubicTo(
      6 * _xScaling,
      -16 * _yScaling,
      212 * _xScaling,
      -16 * _yScaling,
      212 * _xScaling,
      -16 * _yScaling,
    );
    path.cubicTo(
      212 * _xScaling,
      -16 * _yScaling,
      212 * _xScaling,
      184 * _yScaling,
      212 * _xScaling,
      184 * _yScaling,
    );
    path.cubicTo(
      212 * _xScaling,
      184 * _yScaling,
      212 * _xScaling,
      184 * _yScaling,
      212 * _xScaling,
      184 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
