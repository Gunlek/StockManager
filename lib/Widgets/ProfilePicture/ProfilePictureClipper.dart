import 'dart:math';

import 'package:flutter/material.dart';

class ProfilePictureClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double radius = size.shortestSide;

    Path clipPath = Path();
    clipPath.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius / 2,
    ));
    clipPath.close();

    return clipPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
