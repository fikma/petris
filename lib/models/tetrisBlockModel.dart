import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';

enum TetrisType {
  board,
  tetromino,
  crossBom,
  xBom,
  yBom,
  randomizeTetrominosType
}

enum TetrisShape {
  i,
  n,
  l,
  t,
  o,
}

List<List<dynamic>> TetrisShapeList = [
  [
    0,
    [0, 0],
    [0, 1],
    [0, 2],
    [0, 3],
  ], // I
  [
    1,
    [0, 0],
    [0, 1],
    [1, 1],
    [1, 2],
  ], // N
  [
    2,
    [0, 0],
    [0, 1],
    [0, 2],
    [1, 2],
  ], // L
  [
    3,
    [0, 0],
    [1, 0],
    [2, 0],
    [1, 1],
  ], // T
  [
    4,
    [0, 0],
    [1, 0],
    [0, 1],
    [1, 1],
  ], // o
];

class TetrisBlockModel {
  Point gravity = Point(0, 1);
  Point xDirection = Point(0, 0);

  Offset? gestureStartLocalLocation;

  double? vectorRadianDirection;
  double? vectorLength;

  late List<SingleBlockWidgetModel> blocks;
  TetrisShape? shape;
}
