import 'package:flutter/material.dart';
import 'package:petris/configs/boardConfig.dart';
import 'package:petris/configs/vector.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/pages/widget/singleBlockWidget.dart';

class BoardWidgetLogic {
  BoardWidgetModel boardWidgetModel;
  BoardWidgetLogic(this.boardWidgetModel);

  List<List<SingleBlockWidgetModel>> initBoardListModel() {
    List<List<SingleBlockWidgetModel>> data = [];
    for (var xCount = 0; xCount < BoardConfig.xSize; xCount++) {
      List<SingleBlockWidgetModel> temp = [];
      for (var yCount = 0; yCount < BoardConfig.ySize; yCount++) {
        var model = SingleBlockWidgetModel(
          position: Vector(xCount, yCount),
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

  void setSingleBlockCallback(
    int x,
    int y,
    Function(String) callback,
  ) {
    var model = boardWidgetModel.boardList[x][y];
    if (model != null) {
      model.updateCallback = callback;

      boardWidgetModel.boardList[x][y] = model;
    }
  }
}
