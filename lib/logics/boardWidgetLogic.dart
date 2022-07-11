import 'dart:math';

import 'package:flutter/widgets.dart';
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
  static Row generateBoard(List<List<SingleBlockWidgetModel>> boardList) {
    List<Column> rowTetrisWidgetCollections = [];

    boardList.forEach((y) {
      List<SingleBlockWidget> singleBlockWidgetList = [];

      y.forEach((x) {
        singleBlockWidgetList.add(SingleBlockWidget(
          model: x,
        ));
      });

      rowTetrisWidgetCollections.add(Column(
        children: singleBlockWidgetList,
      ));
    });

    Row baris = Row(
      children: rowTetrisWidgetCollections,
    );

    return baris;
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
