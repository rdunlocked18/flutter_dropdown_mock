import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_mock/core/shared/clip_painter.dart';
import 'package:flutter_dropdown_mock/core/utils/constants.dart';

class BezierContainer extends StatelessWidget {
  final List<Color> gradientColors;
  const BezierContainer({
    super.key,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Pulse(
      child: Transform.rotate(
        angle: -pi / 3.5,
        child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height * Constants.size_0_5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
