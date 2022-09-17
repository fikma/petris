import 'dart:math';

import 'package:flutter/material.dart';

class MainMenuModel {
  Point size = const Point(0, 0);

  Color bgColor = Colors.blue;

  bool visible = true;
  bool isCountDown = false;

  late Function updateCallback;
}
