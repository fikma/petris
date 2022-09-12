import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/commands/move_tetris_blocks_command.dart';
import 'package:petris/utils/board_config.dart';
import 'package:petris/models/tetris_block_model.dart';

import '../models/single_block_widget_model.dart';

class TetrisBlockLogic {
  List<SingleBlockWidgetModel> rotate({
    required List<SingleBlockWidgetModel> tetrisBlocks,
    bool rotateClockwise = true,
    int rotationOriginIndex = 0,
  }) {
    rotationOriginIndex = (rotationOriginIndex > tetrisBlocks.length)
        ? tetrisBlocks.length - 1
        : rotationOriginIndex;
    rotationOriginIndex =
        (rotationOriginIndex < tetrisBlocks.length) ? rotationOriginIndex : 0;
    Point rotationOrigin = tetrisBlocks[rotationOriginIndex].position;

    tetrisBlocks.asMap().forEach((index, block) {
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

      var model = tetrisBlocks[index];

      model.position = Point(newX, newY);

      tetrisBlocks[index] = model;
    });

    return tetrisBlocks;
  }

  List<SingleBlockWidgetModel> moveTo({
    required List<SingleBlockWidgetModel> tetrisBlocks,
    required Point direction,
  }) {
    for (var i in tetrisBlocks) {
      i.position += direction;
    }

    return tetrisBlocks;
  }

  void setTetrisBlockColorToBoard({
    required TetrisBlockList tetrisBlocks,
    required List<List<SingleBlockWidgetModel>> boardList,
  }) {
    for (var item in tetrisBlocks) {
      if (item.position.y >= 0 && item.position.y <= BoardConfig.ySize - 1) {
        boardList[item.position.x.toInt()][item.position.y.toInt()].color =
            item.color;
        // if (boardList[item.position.x.toInt()][item.position.y.toInt()]
        //         .updateCallback !=
        //     null) {
        //   boardList[item.position.x.toInt()][item.position.y.toInt()]
        //       .updateCallback("updated!!!!!");
        // }
      }
    }
  }

  bool isBlockOutsideBoardWidth({
    required List<SingleBlockWidgetModel> tetrisBlocks,
  }) {
    for (var block in tetrisBlocks) {
      bool outSideLeft = block.position.x < 0;
      bool outSideRight = block.position.x > BoardConfig.xSize - 1;

      if (outSideLeft || outSideRight) {
        return true;
      }
    }
    return false;
  }

  bool isBlockOutsideBoardHeight({
    required List<SingleBlockWidgetModel> tetrisBlocks,
    bool? checkTop,
  }) {
    for (var block in tetrisBlocks) {
      if (checkTop != null) {
        if (block.position.y < 0) return true;
      }
      if (block.position.y > BoardConfig.ySize - 1) return true;
    }
    return false;
  }

  bool isBlockCollideWithTetrominoe({
    required List<SingleBlockWidgetModel> tetrisBlocks,
    required List<List<SingleBlockWidgetModel>> boardList,
  }) {
    var result = false;
    for (var block in tetrisBlocks) {
      if (block.position.y < 0 || block.position.y > BoardConfig.ySize - 1) {
        continue;
      }
      if (block.position.x < 0 || block.position.x > BoardConfig.xSize - 1) {
        continue;
      }
      var boardBlock =
          boardList[block.position.x.toInt()][block.position.y.toInt()];

      bool collided = (boardBlock.type != BlockType.board);

      if (collided) result = true;
    }

    return result;
  }

  TetrisBlockList<SingleBlockWidgetModel> reset({
    required TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks,
  }) {
    var random = Random();
    tetrisBlocks = buildTetrominoes(
      tetrisShapeList: TetrisShapeList,
      blockSize: BoardConfig.blockSize,
    );

    if (random.nextInt(5) >= 2) {
      tetrisBlocks = invertBlockTetris(tetrisBlocks);
      tetrisBlocks.isXFlipped = true;
    }

    tetrisBlocks.tetrisSize = getTetrisBlocksSize(tetrisBlocks: tetrisBlocks);

    tetrisBlocks = randomizeColor(
      tetrisBlocks: tetrisBlocks,
      random: random,
    );

    return tetrisBlocks;
  }

  Point getTetrisBlocksSize({
    required TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks,
  }) {
    num x = 0, y = 0;
    for (var block in tetrisBlocks) {
      x = (block.position.x > x) ? block.position.x : x;
      y = (block.position.y > y) ? block.position.y : y;
    }
    var result = Point(x, y);
    return result;
  }

  TetrisBlockList<SingleBlockWidgetModel> randomizeColor({
    required TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks,
    required Random random,
  }) {
    var color = Colors.primaries[random.nextInt(Colors.primaries.length)];
    for (var x = 0; x < tetrisBlocks.length; x++) {
      tetrisBlocks[x].color = color;
    }

    return tetrisBlocks;
  }

  TetrisBlockList<SingleBlockWidgetModel> randomizeXPosition({
    required TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks,
    required Random random,
  }) {
    int xPosition = 0;
    for (var block in tetrisBlocks) {
      if (block.position.x > xPosition) {
        xPosition = block.position.x.toInt();
      }
    }

    int xMoveTo = random.nextInt(BoardConfig.xSize - xPosition);
    moveTo(direction: Point(xMoveTo, 0), tetrisBlocks: tetrisBlocks);
    return tetrisBlocks;
  }

  TetrisBlockList<SingleBlockWidgetModel> buildTetrominoesByType({
    required TetrisShape tetrisShape,
    required List<List<dynamic>> tetrisShapeList,
    required int blockSize,
  }) {
    TetrisBlockList<SingleBlockWidgetModel> result = TetrisBlockList();

    // start logic untuk test
    for (var item in tetrisShapeList) {
      if (TetrisShape.values[item[0]] == tetrisShape) {
        for (var index = 1; index < item.length; index++) {
          result.add(
            SingleBlockWidgetModel(
              position: Point(
                item[index][0],
                item[index][1],
              ),
              size: blockSize,
              type: BlockType.tetromino,
            ),
          );
        }
      }
    }
    // end logic untuk test
    return result;
  }

  TetrisBlockList<SingleBlockWidgetModel> buildTetrominoes({
    required List<List<dynamic>> tetrisShapeList,
    required int blockSize,
  }) {
    TetrisBlockList<SingleBlockWidgetModel> result = TetrisBlockList();

    var positionBlueprint =
        tetrisShapeList[Random().nextInt(tetrisShapeList.length)];
    result.tetrisShape = TetrisShape.values[positionBlueprint[0]];

    for (var index = 1; index < positionBlueprint.length; index++) {
      result.add(
        SingleBlockWidgetModel(
          position: Point(
            positionBlueprint[index][0],
            positionBlueprint[index][1],
          ),
          size: BoardConfig.blockSize,
          type: BlockType.tetromino,
        ),
      );
    }

    return result;
  }

  TetrisBlockList<SingleBlockWidgetModel> invertBlockTetris(
      TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks) {
    var xOffset = 0;
    for (var item in tetrisBlocks) {
      var newPosition =
          Offset(item.position.x.toDouble(), item.position.y.toDouble())
              .scale(-1, 1);
      item.position = Point(newPosition.dx, newPosition.dy);

      if (item.position.x < xOffset) {
        xOffset = item.position.x.toInt();
      }
    }
    moveTo(
      direction: Point(xOffset.abs(), 0),
      tetrisBlocks: tetrisBlocks,
    );

    return tetrisBlocks;
  }

  TetrisBlockList<SingleBlockWidgetModel> moveBlockMinTop({
    required TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks,
  }) {
    int lengthOfY = 0;
    for (var block in tetrisBlocks) {
      lengthOfY =
          (block.position.y > lengthOfY) ? block.position.y.toInt() : lengthOfY;
    }

    TetrisBlockLogic().moveTo(
      direction: Point(0, -(lengthOfY + 1)),
      tetrisBlocks: tetrisBlocks,
    );

    return tetrisBlocks;
  }

  void moveTetrisBlocksToBottom({
    required List<List<SingleBlockWidgetModel>> boardList,
    required List<SingleBlockWidgetModel> tetrisBlocks,
  }) {
    while (true) {
      var moveCommand = MoveTetrisBlocksCommand(tetrisBlocks: tetrisBlocks);
      moveCommand.execute(const Point(0, 1));

      var condition1 = isBlockCollideWithTetrominoe(
        tetrisBlocks: tetrisBlocks,
        boardList: boardList,
      );
      var condition2 = isBlockOutsideBoardHeight(
        tetrisBlocks: tetrisBlocks,
      );

      if (condition1 || condition2) {
        moveCommand.undo();
        break;
      }
    }
  }
}
