import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/commands/moveTetrisBlocksCommand.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../models/singleBlockWidgetModel.dart';

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

  void setTetrisBlockToBoard({
    required List<SingleBlockWidgetModel> tetrisBlocks,
    required List<List<SingleBlockWidgetModel>> boardList,
  }) {
    for (var item in tetrisBlocks) {
      if (item.position.y >= 0 && item.position.y <= BoardConfig.ySize - 1) {
        boardList[item.position.x.toInt()][item.position.y.toInt()].color =
            item.color;
        boardList[item.position.x.toInt()][item.position.y.toInt()]
            .updateCallback("updated!!!!!");
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
    required TetrisBlockModel tetrisBlockModel,
  }) {
    var random = Random();
    tetrisBlockModel.blocks = buildTetrominoes(
      random: random,
      tetrisShapeList: TetrisShapeList,
      tetrisBlockModel: tetrisBlockModel,
    );

    if (random.nextInt(5) >= 2) {
      tetrisBlockModel.blocks = invertBlockTetris(tetrisBlockModel);
    }

    tetrisBlockModel.blocks = moveBlockMinTop(tetrisBlockModel.blocks);

    tetrisBlockModel.blocks = randomizeXPosition(
      tetrisBlockModel: tetrisBlockModel,
      random: random,
    );

    tetrisBlockModel.blocks = randomizeColor(
      tetrisBlockModel: tetrisBlockModel,
      random: random,
    );

    return tetrisBlockModel.blocks;
  }

  TetrisBlockList<SingleBlockWidgetModel> randomizeColor({
    required TetrisBlockModel tetrisBlockModel,
    required Random random,
  }) {
    var color = Colors.primaries[random.nextInt(Colors.primaries.length)];
    for (var x = 0; x < tetrisBlockModel.blocks.length; x++) {
      tetrisBlockModel.blocks[x].color = color;
    }

    return tetrisBlockModel.blocks;
  }

  TetrisBlockList<SingleBlockWidgetModel> randomizeXPosition({
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
    moveTo(direction: Point(xMoveTo, 0), tetrisBlocks: tetrisBlockModel.blocks);
    return tetrisBlockModel.blocks;
  }

  TetrisBlockList<SingleBlockWidgetModel> buildTetrominoes({
    Random? random,
    TetrisShape? tetrisShape,
    required List<List<dynamic>> tetrisShapeList,
    required TetrisBlockModel tetrisBlockModel,
  }) {
    TetrisBlockList<SingleBlockWidgetModel> result = TetrisBlockList();

    // start logic untuk test
    if (tetrisShape != null) {
      for (var item in tetrisShapeList) {
        if (TetrisShape.values[item[0]] == tetrisShape) {
          for (var index = 1; index < item.length; index++) {
            result.add(
              SingleBlockWidgetModel(
                  position: Point(
                    item[index][0],
                    item[index][1],
                  ),
                  size: BoardConfig.blockSize,
                  type: BlockType.tetromino),
            );
          }
        }
      }

      return result;
    }
    // end logic untuk test

    var positionBlueprint =
        tetrisShapeList[random!.nextInt(tetrisShapeList.length)];
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
      TetrisBlockModel tetrisBlockModel) {
    var xOffset = 0;
    for (var item in tetrisBlockModel.blocks) {
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
      tetrisBlocks: tetrisBlockModel.blocks,
    );

    return tetrisBlockModel.blocks;
  }

  TetrisBlockList<SingleBlockWidgetModel> moveBlockMinTop(
      TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks) {
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
