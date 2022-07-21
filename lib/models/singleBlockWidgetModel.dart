import 'dart:math';

import 'package:flutter/material.dart';

class SingleBlockWidgetModel {
  Point position;

  late final Function(String) updateCallback;
  final double size;
  Color color = Colors.black;

  SingleBlockWidgetModel(
      {required this.position, required this.color, required this.size});
}
