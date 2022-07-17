import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';

class TetrisBlockModel {
  List<SingleBlockWidgetModel> blocks = [
    SingleBlockWidgetModel(
      position: Point(0, 0),
      color: Colors.white,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 1),
      color: Colors.white,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 2),
      color: Colors.white,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 3),
      color: Colors.white,
    ),
  ];
}
