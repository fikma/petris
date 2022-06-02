import 'package:flutter/material.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../models/singleBlockWidgetModel.dart';

class TetrisBlockLogic {
  void resetTetrisBlock() {}

  void setTetrisBlockToBoard({
    required TetrisBlockModel tetrisBlockModel,
    required List<List<SingleBlockWidgetModel>>? boards,
  }) {
    if (boards != null) {
      tetrisBlockModel.blocks.forEach((item) {
        var blockModel = item;
        blockModel.color = Colors.grey;
        boards[blockModel.position.x.toInt()][blockModel.position.y.toInt()] =
            item;
      });
    }
  }
}
