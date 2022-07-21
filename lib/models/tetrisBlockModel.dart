import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/configs/boardConfig.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';

class TetrisBlockModel {
  Point gravity = const Point(0, 1);

  List<SingleBlockWidgetModel> blocks = [
    SingleBlockWidgetModel(
      position: Point(0, 0),
      color: Colors.white,
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 1),
      color: Colors.white,
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 2),
      color: Colors.white,
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 3),
      color: Colors.white,
      size: BoardConfig.blockSize,
    ),
  ];
}
