import 'dart:math';

import 'package:flutter/material.dart';

class SingleBlockWidgetModel {
  final Point position;

  late final Function updateCallback;
  final double size = 30.0;
  Color color = Colors.black;

  SingleBlockWidgetModel({required this.position});
}
