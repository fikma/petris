import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/pages/widget/singleBlockWidget.dart';
import 'package:petris/utils/lineCheckResultWrapper.dart';

class BoardWidgetLogic {
  //
  List<List<SingleBlockWidgetModel>> initBoardList(int xSize, int ySize) {
    List<List<SingleBlockWidgetModel>> data = [];
    for (var xCount = 0; xCount < xSize; xCount++) {
      List<SingleBlockWidgetModel> temp = [];
      for (var yCount = 0; yCount < ySize; yCount++) {
        var model = SingleBlockWidgetModel(
          position: Point(xCount, yCount),
          color: Colors.black,
          size: BoardConfig.blockSize,
        );
        temp.add(model);
      }
      data.add(temp);
    }

    return data;
  }

  // column yang berisi children kumpulan row
  Center generateBoard({
    required List<List<SingleBlockWidgetModel>> boardList,
  }) {
    List<Column> rowTetrisWidgetCollections = [];

    for (var y in boardList) {
      List<SingleBlockWidget> singleBlockWidgetList = [];

      for (var x in y) {
        singleBlockWidgetList.add(SingleBlockWidget(
          singleBlockWidgetModel: x,
        ));
      }

      rowTetrisWidgetCollections.add(Column(
        children: singleBlockWidgetList,
      ));
    }

    Row baris = Row(
      children: rowTetrisWidgetCollections,
    );

    return Center(
      child: Container(
        width: BoardConfig.blockSize * BoardConfig.xSize,
        height: BoardConfig.blockSize * BoardConfig.ySize,
        color: Colors.blue,
        child: baris,
      ),
    );
  }

  void setBoardBlock({
    required List<List<SingleBlockWidgetModel>> boardList,
    required List<SingleBlockWidgetModel> tetrisBlocks,
  }) {
    for (var block in tetrisBlocks) {
      if (block.position.y < 0) return;
      boardList[block.position.x.toInt()][block.position.y.toInt()].type =
          BlockType.tetromino;
      boardList[block.position.x.toInt()][block.position.y.toInt()].color =
          block.color;
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

          boardList[x][y].updateCallback("update");
        }
      }
    }
  }

  void resetBoard({required List<List<SingleBlockWidgetModel>> boardList}) {
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
          two.updateCallback("rerender");
        }
      }
    }
  }
}
