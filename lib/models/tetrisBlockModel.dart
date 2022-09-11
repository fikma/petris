import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';

enum TetrisShape {
  i,
  n,
  l,
  t,
  o,
}

// ignore: constant_identifier_names
const List<List<dynamic>> TetrisShapeList = [
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
  Point gravity = const Point(0, 1);
  Point xDirection = const Point(0, 0);
  bool rotate = false;
  bool moveBlocksToBottom = false;

  Offset? gestureStartLocalLocation;

  double? vectorRadianDirection;
  double? vectorLength;

  TetrisBlockList<SingleBlockWidgetModel> blocks =
      TetrisBlockList<SingleBlockWidgetModel>();
}

class TetrisBlockList<E> extends ListBase<E> {
  late TetrisShape tetrisShape;
  List<E> l = [];

  @override
  set length(int newLength) {
    l.length = newLength;
  }

  @override
  int get length => l.length;

  @override
  E operator [](int index) {
    return l[index];
  }

  @override
  void operator []=(int index, E value) {
    l[index] = value;
  }

  @override
  void add(E element) {
    l.add(element);
  }

  @override
  void addAll(Iterable<E> iterable) {
    l.addAll(iterable);
  }

  // TetrisBlockList<SingleBlockWidgetModel> toTetrisBlockList() {
  //   TetrisBlockList<SingleBlockWidgetModel> result = TetrisBlockList();
  //   for (var element in l) {
  //     result.add(element);
  //   }
  //   return result;
  // }
}
