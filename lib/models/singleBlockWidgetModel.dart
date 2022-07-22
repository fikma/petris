import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/models/tetrisBlockModel.dart';

class SingleBlockWidgetModel {
  Point position;

  late final Function(String) updateCallback;
  final double size;
  Color color = Colors.black;

  TetrisType type;

  SingleBlockWidgetModel({
    required this.position,
    required this.color,
    required this.size,
    this.type = TetrisType.board,
  });
}
