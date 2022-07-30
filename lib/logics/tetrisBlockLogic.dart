import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/configs/boardConfig.dart';
import 'package:petris/configs/vector.dart';
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
    Vector rotationOrigin =
        tetrisBlockModel.blocks[rotationOriginIndex].position;

    tetrisBlockModel.blocks.asMap().forEach((index, block) {
      int newX, newY;
      if (rotateClockwise) {
        int x = (block.position.y - rotationOrigin.y).toInt();
        int y = (block.position.x - rotationOrigin.x).toInt();

        newX = rotationOrigin.x - x;
        newY = rotationOrigin.y + y;
      } else {
        int x = (block.position.y - rotationOrigin.y).toInt();
        int y = (block.position.x - rotationOrigin.x).toInt();

        newX = rotationOrigin.x + x;
        newY = rotationOrigin.y - y;
      }

      var model = tetrisBlockModel.blocks[index];

      model.position = Vector(newX, newY);

      tetrisBlockModel.blocks[index] = model;
    });
  }

  void moveTo({
    required TetrisBlockModel tetrisBlockModel,
    required Vector direction,
  }) {
    for (var i in tetrisBlockModel.blocks) {
      i.position.x += direction.x;
      i.position.y += direction.y;
    }
  }

  void setTetrisBlockToBoard({
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

  void clear({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var item in tetrisBlockModel.blocks) {
      int x = item.position.x.toInt();
      int y = item.position.y.toInt();
      boardWidgetModel.boardList[x][y].color = BoardConfig.boardColor;
      boardWidgetModel.boardList[x][y].updateCallback("updated!!!!!");
    }
  }

  bool isBlockOutsideBoard({
    required TetrisBlockModel tetrisBlockModel,
    required BoardWidgetModel boardWidgetModel,
  }) {
    for (var block in tetrisBlockModel.blocks) {
      bool outSideLeft = block.position.x < 0;
      bool outSideRight = block.position.x > BoardConfig.xSize - 1;
      bool outSideBottom = block.position.y > BoardConfig.ySize - 1;
      if (outSideLeft || outSideRight || outSideBottom) {
        return true;
      }
    }
    return false;
  }

  TetrisBlockModel reset(TetrisBlockModel tetrisBlockModel) {
    var random = Random();
    tetrisBlockModel.blocks = buildTetrominoes(
      random: random,
      tetrisShape: tetrisShape,
    );

    tetrisBlockModel = randomizeXPosition(
      tetrisBlockModel: tetrisBlockModel,
      random: random,
    );

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

  TetrisBlockModel randomizeXPosition({
    required TetrisBlockModel tetrisBlockModel,
    required Random random,
  }) {
    int xPosition = 0;
    for (var block in tetrisBlockModel.blocks) {
      if (block.position.x > xPosition) {
        xPosition = block.position.x;
      }
    }

    int xMoveTo = random.nextInt(BoardConfig.xSize - xPosition);
    moveTo(
      tetrisBlockModel: tetrisBlockModel,
      direction: Vector(xMoveTo, 0),
    );
    return tetrisBlockModel;
  }

  List<SingleBlockWidgetModel> buildTetrominoes(
      {required Random random, required List<List<List<int>>> tetrisShape}) {
    List<SingleBlockWidgetModel> result = <SingleBlockWidgetModel>[];

    var positionBlueprint = tetrisShape[random.nextInt(tetrisShape.length)];
    for (var position in positionBlueprint) {
      result.add(
        SingleBlockWidgetModel(
          position: Vector(position[0], position[1]),
          size: BoardConfig.blockSize,
        ),
      );
    }
    return result;
  }
}
