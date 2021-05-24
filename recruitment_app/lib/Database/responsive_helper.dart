import 'dart:math';

import 'package:flutter/material.dart';

class ResponsiveHelper {
  double _height, _width, _diagonal;

  double get height => _height;
  double get width => _width;

  static ResponsiveHelper of(BuildContext context) => ResponsiveHelper(context);

  ResponsiveHelper(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    this._width = mediaQuery.size.width;
    this._height = mediaQuery.size.height;
    this._diagonal = sqrt(
      pow(_width, 2) + pow(_height, 2),
    );
  }
  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;
}
