import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/configs/boardConfig.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';

enum TetrisType {
  board,
  tetromino,
  crossBom,
  xBom,
  yBom,
  randomizeTetrominosType
}

List<List<SingleBlockWidgetModel>> tetrisShape = [
  [
    SingleBlockWidgetModel(
      position: Point(0, 0),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 1),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 2),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 3),
      size: BoardConfig.blockSize,
    ),
  ], // I shape
  [
    SingleBlockWidgetModel(
      position: Point(0, 0),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 1),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(1, 1),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(1, 2),
      size: BoardConfig.blockSize,
    ),
  ], // n shape
  [
    SingleBlockWidgetModel(
      position: Point(0, 0),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 1),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(0, 2),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(1, 2),
      size: BoardConfig.blockSize,
    ),
  ], // L shape
  [
    SingleBlockWidgetModel(
      position: Point(0, 0),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(1, 0),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(2, 0),
      size: BoardConfig.blockSize,
    ),
    SingleBlockWidgetModel(
      position: Point(1, 1),
      size: BoardConfig.blockSize,
    ),
  ], // T shape
];

class TetrisBlockModel {
  Point gravity = const Point(0, 1);

  List<SingleBlockWidgetModel> blocks = tetrisShape[0];
}
