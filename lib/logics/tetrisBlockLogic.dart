import 'dart:math';

import 'package:petris/configs/boardConfig.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

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
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var item in tetrisBlockModel.blocks) {
      boardWidgetModel
          .boardList[item.position.x.toInt()][item.position.y.toInt()]
          .color = item.color;
      boardWidgetModel.boardList[item.position.x.toInt()]
              [item.position.y.toInt()]
          .updateCallback("updated!!!!!");
    }
  }

  static void clear({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var item in tetrisBlockModel.blocks) {
      int x = item.position.x.toInt();
      int y = item.position.y.toInt();
      boardWidgetModel.boardList[x][y].color =
          boardWidgetModel.boardList[0][0].color;
      boardWidgetModel.boardList[x][y].updateCallback("updated!!!!!");
    }
  }

  static bool isBlockOutsideBoard(TetrisBlockModel tetrisBlockModel) {
    for (var block in tetrisBlockModel.blocks) {
      bool outSideLeft = block.position.x < BoardConfig.xSize;
      bool outSideRight = block.position.x > BoardConfig.xSize - 1;
      if (outSideLeft || outSideRight) {
        return true;
      }
    }
    return false;
  }
}
