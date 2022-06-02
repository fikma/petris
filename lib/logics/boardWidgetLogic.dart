import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';
import 'package:petris/pages/widget/singleBlockWidget.dart';

class BoardWidgetLogic {
  List<List<SingleBlockWidgetModel>> initializedBoardListModel() {
    List<List<SingleBlockWidgetModel>> data = [];
    for (var baris = 0; baris < 20; baris++) {
      List<SingleBlockWidgetModel> temp = [];
      for (var kolom = 0; kolom < 10; kolom++) {
        var model = SingleBlockWidgetModel(
          position: Point(baris, kolom),
        );
        temp.add(model);
      }
      data.add(temp);
    }

    return data;
  }

  // column yang berisi children kumpulan row
  Column generateBoard(BuildContext? context) {
    List<Row> rowTetrisWidgetCollections = [];

    var modelCollection =
        GamePageInheritedWidget.of(context!)?.getBoardWidgetModel.boardList;
    if (modelCollection != null) {
      // ignore: avoid_function_literals_in_foreach_calls
      modelCollection.forEach((rowModel) {
        List<SingleBlockWidget> temp = [];
        rowModel.forEach((columnModel) {
          temp.add(SingleBlockWidget(model: columnModel));
        });
        Row barisWidget = Row(
          children: temp,
        );
        rowTetrisWidgetCollections.add(barisWidget);
      });
    }

    Column column = Column(
      children: rowTetrisWidgetCollections,
    );

    return column;
  }

  void setSingleBlockCallback(
    int x,
    int y,
    VoidCallback callback,
    List<List<SingleBlockWidgetModel>>? data,
  ) {
    // if (context != null) {
    //   var model = GamePageInheritedWidget.of(context)
    //       ?.getBoardWidgetModel
    //       .boardList[x as int][y as int];
    //   model?.update = callback;
    // }
    var model = data![x][y];
    if (model != null) {
      model.updateCallback = callback;

      data[x][y] = model;
    }
  }
}
