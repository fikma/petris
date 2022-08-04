import 'package:flutter/foundation.dart';
import 'package:petris/configs/vector.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';

enum TetrisType {
  board,
  tetromino,
  crossBom,
  xBom,
  yBom,
  randomizeTetrominosType
}

List<List<List<int>>> tetrisShape = [
  [
    [0, 0],
    [0, 1],
    [0, 2],
    [0, 3],
  ], // I
  [
    [0, 0],
    [0, 1],
    [1, 1],
    [1, 2],
  ], // N
  [
    [0, 0],
    [0, 1],
    [0, 2],
    [1, 2],
  ], // L
  [
    [0, 0],
    [1, 0],
    [2, 0],
    [1, 1],
  ], // T
  [
    [0, 0],
    [1, 0],
    [0, 1],
    [1, 1],
  ], // o
];

class TetrisBlockModel {
  Vector gravity = Vector(0, 1);

  late List<SingleBlockWidgetModel> blocks;

  void display() {
    if (kDebugMode) {
      for (var x in blocks) {
        print('${x.position.x}:${x.position.y}');
      }
    }
  }
}
