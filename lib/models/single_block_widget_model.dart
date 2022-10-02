import 'dart:math';

import 'package:flutter/material.dart';

enum BlockType {
  board,
  tetromino,
  crossBom,
  xBom,
  yBom,
  randomizeTetrominosType
}

class SingleBlockWidgetModel {
  Point position;

  late final Function updateCallback;
  final int size;
  Color color;
  Color monoColor = Color(Colors.grey[700]!.value);

  BlockType type;

  bool isPartOfTetrisBlocks = false;

  SingleBlockWidgetModel({
    required this.position,
    required this.size,
    this.color = Colors.black,
    this.type = BlockType.board,
  });
}
