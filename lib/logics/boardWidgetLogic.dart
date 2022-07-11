import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/pages/widget/singleBlockWidget.dart';

class BoardWidgetLogic {
  static List<List<SingleBlockWidgetModel>> initBoardListModel() {
    List<List<SingleBlockWidgetModel>> data = [];
    for (var xCount = 0; xCount < 10; xCount++) {
      List<SingleBlockWidgetModel> temp = [];
      for (var yCount = 0; yCount < 20; yCount++) {
        var model = SingleBlockWidgetModel(
          position: Point(xCount, yCount),
        );
        temp.add(model);
      }
      data.add(temp);
    }

    return data;
  }

  // column yang berisi children kumpulan row
  static Center generateBoard(List<List<SingleBlockWidgetModel>> boardList) {
    List<Column> rowTetrisWidgetCollections = [];

    for (var y in boardList) {
      List<SingleBlockWidget> singleBlockWidgetList = [];

      for (var x in y) {
        singleBlockWidgetList.add(SingleBlockWidget(
          model: x,
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
        width: boardList[0][0].size * 10,
        height: boardList[0][0].size * 20,
        color: Colors.blue,
        child: baris,
      ),
    );
  }

  static void setSingleBlockCallback(
    int x,
    int y,
    VoidCallback callback,
    List<List<SingleBlockWidgetModel>>? data,
  ) {
    var model = data![x][y];
    if (model != null) {
      model.updateCallback = callback;

      data[x][y] = model;
    }
  }
}
