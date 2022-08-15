import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/pages/widget/singleBlockWidget.dart';

class BoardWidgetLogic {
  List<List<SingleBlockWidgetModel>> initBoardListModel() {
    List<List<SingleBlockWidgetModel>> data = [];
    for (var xCount = 0; xCount < BoardConfig.xSize; xCount++) {
      List<SingleBlockWidgetModel> temp = [];
      for (var yCount = 0; yCount < BoardConfig.ySize; yCount++) {
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
  Center generateBoard(
    BoardWidgetModel boardWidgetModel,
  ) {
    List<Column> rowTetrisWidgetCollections = [];

    for (var y in boardWidgetModel.boardList) {
      List<SingleBlockWidget> singleBlockWidgetList = [];

      for (var x in y) {
        singleBlockWidgetList.add(SingleBlockWidget(
          model: x,
          boardWidgetModel: boardWidgetModel,
          boardWidgetLogic: this,
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

  void setSingleBlockCallback({
    required BoardWidgetModel boardWidgetModel,
    required int x,
    required int y,
    required Function(String) callback,
  }) {
    var model = boardWidgetModel.boardList[x][y];
    if (model != null) {
      model.updateCallback = callback;

      boardWidgetModel.boardList[x][y] = model;
    }
  }

  void setBoardBlock({
    required BoardWidgetModel boardWidgetModel,
    required TetrisBlockModel tetrisBlockModel,
  }) {
    for (var block in tetrisBlockModel.blocks) {
      if (block.position.y < 0) return;
      boardWidgetModel
          .boardList[block.position.x.toInt()][block.position.y.toInt()]
          .type = TetrisType.tetromino;
      boardWidgetModel
          .boardList[block.position.x.toInt()][block.position.y.toInt()]
          .color = block.color;
    }
  }

  List<dynamic> checkLine({
    required BoardWidgetModel boardWidgetModel,
  }) {
    var result = <dynamic>[];
    var lineResult = <int>[];
    var boolResult = false;
    for (int y = BoardConfig.ySize - 1; y > 0; y--) {
      int xCount = 0;
      for (int x = 0; x < BoardConfig.xSize; x++) {
        if (boardWidgetModel.boardList[x][y].type != TetrisType.board)
          xCount = xCount + 1;
      }

      if (xCount >= BoardConfig.xSize) {
        boolResult = true;
        lineResult.add(y);
      }
    }

    result.add(boolResult);
    result.add(lineResult);

    return result;
  }

  void moveLineDown({
    required BoardWidgetModel boardWidgetModel,
    required List<int> yPositions,
  }) {
    yPositions.sort();
    for (var i in yPositions) {
      for (int y = i; y > 0; y--) {
        for (int x = 0; x <= BoardConfig.xSize - 1; x++) {
          if (y - 1 < 0) return;
          var before = boardWidgetModel.boardList[x][y - 1];

          boardWidgetModel.boardList[x][y].color = before.color;
          boardWidgetModel.boardList[x][y].type = before.type;

          boardWidgetModel.boardList[x][y].updateCallback("update");
        }
      }
    }
  }

  void resetBoard({required BoardWidgetModel boardWidgetModel}) {
    for (int x = 0; x < BoardConfig.xSize - 1; x++) {
      for (int y = 0; y <= BoardConfig.ySize - 1; y++) {
        boardWidgetModel.boardList[x][y].type = TetrisType.board;
        boardWidgetModel.boardList[x][y].color = BoardConfig.boardColor;

        boardWidgetModel.boardList[x][y].updateCallback("string");
      }
    }
  }
}
