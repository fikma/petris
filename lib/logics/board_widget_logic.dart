import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';
import 'package:petris/utils/board_config.dart';
import 'package:petris/models/single_block_widget_model.dart';
import 'package:petris/pages/widget/single_block_widget.dart';
import 'package:petris/utils/line_check_result_wrapper.dart';

class BoardWidgetLogic {
  List<List<SingleBlockWidgetModel>> initBoardList({
    required int xSize,
    required int ySize,
    required int blockSize,
    required Color blockColor,
  }) {
    List<List<SingleBlockWidgetModel>> result = [];
    for (var xCount = 0; xCount < xSize; xCount++) {
      List<SingleBlockWidgetModel> temp = [];
      for (var yCount = 0; yCount < ySize; yCount++) {
        var model = SingleBlockWidgetModel(
          position: Point(xCount, yCount),
          color: blockColor,
          size: blockSize,
        );
        temp.add(model);
      }
      result.add(temp);
    }

    return result;
  }

  // column yang berisi children kumpulan row
  SizedBox generateBoard({
    required List<List<SingleBlockWidgetModel>> boardList,
    required int xGridSize,
    required int yGridSize,
    required BoardWidgetModel boardWidgetModel,
  }) {
    List<Column> rowTetrisWidgetCollections = [];
    var blockSize = 0;

    for (var y in boardList) {
      List<SingleBlockWidget> singleBlockWidgetList = [];

      for (var x in y) {
        singleBlockWidgetList.add(SingleBlockWidget(
          singleBlockWidgetModel: x,
          boardWidgetModel: boardWidgetModel,
        ));

        blockSize = x.size;
      }

      rowTetrisWidgetCollections.add(Column(
        children: singleBlockWidgetList,
      ));
    }

    Row baris = Row(
      children: rowTetrisWidgetCollections,
    );

    return SizedBox(
      width: blockSize * xGridSize * 1.0,
      height: blockSize * yGridSize * 1.0,
      child: baris,
    );
  }

  void setTetrisBlockTypeToBoard({
    required List<List<SingleBlockWidgetModel>> boardList,
    required TetrisBlockList<SingleBlockWidgetModel> tetrisBlocks,
  }) {
    for (var block in tetrisBlocks) {
      if (block.position.y < 0) continue;
      boardList[block.position.x.toInt()][block.position.y.toInt()].type =
          block.type;

      boardList[block.position.x.toInt()][block.position.y.toInt()].color =
          block.color;
      boardList[block.position.x.toInt()][block.position.y.toInt()]
          .isPartOfTetrisBlocks = true;
    }
  }

  LineCheckResultWrapper checkLine({
    required List<List<SingleBlockWidgetModel>> boardList,
  }) {
    LineCheckResultWrapper result = LineCheckResultWrapper();
    var lineResult = <int>[];
    var boolResult = false;
    for (int y = BoardConfig.ySize - 1; y > 0; y--) {
      int xCount = 0;
      for (int x = 0; x < BoardConfig.xSize; x++) {
        if (boardList[x][y].type != BlockType.board) xCount = xCount + 1;
      }

      if (xCount >= BoardConfig.xSize) {
        boolResult = true;
        lineResult.add(y);
      }
    }

    result.isLine = boolResult;
    result.lineResults = lineResult;

    return result;
  }

  void moveLineDown({
    required List<List<SingleBlockWidgetModel>> boardList,
    required List<int> yPositions,
  }) {
    yPositions.sort();
    for (var i in yPositions) {
      for (int y = i; y > 0; y--) {
        for (int x = 0; x <= BoardConfig.xSize - 1; x++) {
          if (y - 1 < 0) return;
          var before = boardList[x][y - 1];

          boardList[x][y].color = before.color;
          boardList[x][y].type = before.type;

          boardList[x][y].updateCallback();
        }
      }
    }
  }

  void resetBoard({
    required List<List<SingleBlockWidgetModel>> boardList,
  }) {
    for (int x = 0; x < BoardConfig.xSize; x++) {
      for (int y = 0; y < BoardConfig.ySize; y++) {
        boardList[x][y].type = BlockType.board;
        boardList[x][y].color = BoardConfig.boardColor;
      }
    }
  }

  void clear({
    required List<List<SingleBlockWidgetModel>> boardList,
  }) {
    for (var one in boardList) {
      for (var two in one) {
        if (two.type == BlockType.board) {
          two.color = BoardConfig.boardColor;
          two.isPartOfTetrisBlocks = false;
          two.updateCallback();
        }
      }
    }
  }
}
