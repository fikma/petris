import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/commands/moveComponentCommand.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../models/singleBlockWidgetModel.dart';

class TetrisBlockLogic {
  void rotate({
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
      int newX, newY;
      if (rotateClockwise) {
        int x = (block.position.y - rotationOrigin.y).toInt();
        int y = (block.position.x - rotationOrigin.x).toInt();

        newX = (rotationOrigin.x - x).toInt();
        newY = (rotationOrigin.y + y).toInt();
      } else {
        int x = (block.position.y - rotationOrigin.y).toInt();
        int y = (block.position.x - rotationOrigin.x).toInt();

        newX = (rotationOrigin.x + x).toInt();
        newY = (rotationOrigin.y - y).toInt();
      }

      var model = tetrisBlockModel.blocks[index];

      model.position = Point(newX, newY);

      tetrisBlockModel.blocks[index] = model;
    });
  }

  void moveTo({
    required TetrisBlockModel tetrisBlockModel,
    required Point direction,
  }) {
    for (var i in tetrisBlockModel.blocks) {
      i.position += direction;
    }
  }

  void setTetrisBlockToBoard({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var item in tetrisBlockModel.blocks) {
      if (item.position.y >= 0 && item.position.y <= BoardConfig.ySize - 1) {
        boardWidgetModel
            .boardList[item.position.x.toInt()][item.position.y.toInt()]
            .color = item.color;
        boardWidgetModel.boardList[item.position.x.toInt()]
                [item.position.y.toInt()]
            .updateCallback("updated!!!!!");
      }
    }
  }

  void clear({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var one in boardWidgetModel.boardList) {
      for (var two in one) {
        if (two.type == TetrisType.board) {
          two.color = BoardConfig.boardColor;
          two.updateCallback("rerender");
        }
      }
    }
  }

  bool isBlockOutsideBoardWidth({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var block in tetrisBlockModel.blocks) {
      bool outSideLeft = block.position.x < 0;
      bool outSideRight = block.position.x > BoardConfig.xSize - 1;

      if (outSideLeft || outSideRight) {
        return true;
      }
    }
    return false;
  }

  bool isBlockOutsideBoardHeight({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var block in tetrisBlockModel.blocks) {
      if (block.position.y > BoardConfig.ySize - 1) return true;
    }
    return false;
  }

  bool isBlockCollideWithTetrominoe({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var block in tetrisBlockModel.blocks) {
      if (block.position.y < 0 || block.position.y > BoardConfig.ySize - 1)
        return false;
      var boardBlock = boardWidgetModel.boardList[block.position.x.toInt()]
          [block.position.y.toInt()];

      bool condition1 = (block.type == boardBlock.type);

      if (condition1) return true;
    }

    return false;
  }

  TetrisBlockModel reset({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    var random = Random();
    tetrisBlockModel.blocks = _buildTetrominoes(
      random: random,
      tetrisShape: tetrisShape,
    );

    tetrisBlockModel = tetrisBlockModel = _moveBlockMinTop(tetrisBlockModel);

    tetrisBlockModel = _randomizeXPosition(
      tetrisBlockModel: tetrisBlockModel,
      random: random,
    );

    if (checkGameOver(
      tetrisBlockModel: tetrisBlockModel,
      boardWidgetModel: boardWidgetModel,
    )) {
      BoardWidgetLogic().resetBoard(boardWidgetModel: boardWidgetModel);
    }

    tetrisBlockModel = randomizeColor(
      tetrisBlockModel: tetrisBlockModel,
      random: random,
    );

    return tetrisBlockModel;
  }

  TetrisBlockModel randomizeColor({
    required TetrisBlockModel tetrisBlockModel,
    required Random random,
  }) {
    var color = Colors.primaries[random.nextInt(Colors.primaries.length)];
    for (var x = 0; x < tetrisBlockModel.blocks.length; x++) {
      tetrisBlockModel.blocks[x].color = color;
    }

    return tetrisBlockModel;
  }

  TetrisBlockModel _randomizeXPosition({
    required TetrisBlockModel tetrisBlockModel,
    required Random random,
  }) {
    int xPosition = 0;
    for (var block in tetrisBlockModel.blocks) {
      if (block.position.x > xPosition) {
        xPosition = block.position.x.toInt();
      }
    }

    int xMoveTo = random.nextInt(BoardConfig.xSize - xPosition);
    moveTo(
      tetrisBlockModel: tetrisBlockModel,
      direction: Point(xMoveTo, 0),
    );
    return tetrisBlockModel;
  }

  List<SingleBlockWidgetModel> _buildTetrominoes(
      {required Random random, required List<List<List<int>>> tetrisShape}) {
    List<SingleBlockWidgetModel> result = <SingleBlockWidgetModel>[];

    var positionBlueprint = tetrisShape[random.nextInt(tetrisShape.length)];
    for (var position in positionBlueprint) {
      result.add(
        SingleBlockWidgetModel(
            position: Point(position[0], position[1]),
            size: BoardConfig.blockSize,
            type: TetrisType.tetromino),
      );
    }
    return result;
  }

  TetrisBlockModel _moveBlockMinTop(TetrisBlockModel tetrisBlockModel) {
    int lengthOfY = 0;
    for (var block in tetrisBlockModel.blocks) {
      lengthOfY =
          (block.position.y > lengthOfY) ? block.position.y.toInt() : lengthOfY;
    }

    TetrisBlockLogic().moveTo(
      tetrisBlockModel: tetrisBlockModel,
      direction: Point(0, -(lengthOfY + 1)),
    );

    return tetrisBlockModel;
  }

  bool checkGameOver({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var block in tetrisBlockModel.blocks) {
      if (block.position.y == -1) {
        var blockToCheck = boardWidgetModel.boardList[block.position.x.toInt()]
            [(block.position.y + 1).toInt()];
        var condition1 = (blockToCheck.type != TetrisType.board);

        if (condition1) return true;
      }
    }

    return false;
  }

  void moveToBottom({
    required BoardWidgetModel boardWidgetModel,
    required TetrisBlockModel tetrisBlockModel,
  }) {
    while (true) {
      var moveCommand = MoveComponentCommand(tetrisBlockModel);
      moveCommand.execute(tetrisBlockModel.gravity);

      var condition1 = isBlockCollideWithTetrominoe(
        tetrisBlockModel: tetrisBlockModel,
        boardWidgetModel: boardWidgetModel,
      );
      var condition2 = isBlockOutsideBoardHeight(
        tetrisBlockModel: tetrisBlockModel,
        boardWidgetModel: boardWidgetModel,
      );

      if (condition1 || condition2) {
        moveCommand.undo();
        break;
      }
    }
  }
}
