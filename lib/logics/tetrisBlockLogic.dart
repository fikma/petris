import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../models/singleBlockWidgetModel.dart';

class TetrisBlockLogic {
  void resetTetrisBlock() {}

  static void moveTo({
    required TetrisBlockModel? tetrisBlockModel,
    required Point direction,
  }) {
    for (var i = 0; i < tetrisBlockModel!.blocks.length; i++) {
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
