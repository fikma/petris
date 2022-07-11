import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../models/singleBlockWidgetModel.dart';

class TetrisBlockLogic {
  void resetTetrisBlock() {}

  static void rotate({
    required TetrisBlockModel tetrisBlockModel,
    bool rotateClockwise = true,
    int rotationOriginIndex = 0,
  }) {
    rotationOriginIndex = (rotationOriginIndex > tetrisBlockModel.blocks.length)
        ? tetrisBlockModel.blocks.length - 1
        : rotationOriginIndex;
    rotationOriginIndex = (rotationOriginIndex < tetrisBlockModel.blocks.length)
        ? rotationOriginIndex
        : 0;
    Point rotationOrigin =
        tetrisBlockModel.blocks[rotationOriginIndex].position;

    tetrisBlockModel.blocks.asMap().forEach((index, block) {
      int x = (block.position.y - rotationOrigin.y).toInt();
      int y = (block.position.x - rotationOrigin.x).toInt();

      num newX = rotationOrigin.x - x;
      num newY = rotationOrigin.y + y;

      var model = tetrisBlockModel.blocks[index];

      model.position = Point(newX, newY);

      tetrisBlockModel.blocks[index] = model;
    });
  }

  static void moveTo({
    required TetrisBlockModel tetrisBlockModel,
    required Point direction,
  }) {
    for (var i = 0; i < tetrisBlockModel.blocks.length; i++) {
      tetrisBlockModel.blocks[i].position += direction;
    }
  }

  static void setTetrisBlockToBoard({
    required TetrisBlockModel tetrisBlockModel,
    required List<List<SingleBlockWidgetModel>> boards,
  }) {
    tetrisBlockModel.blocks.forEach((item) {
      var blockModel = item;
      blockModel.color = Colors.white;
      boards[blockModel.position.x.toInt()][blockModel.position.y.toInt()] =
          blockModel;
    });
  }
}
