import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/singleBlockWidgetModel.dart';
import 'package:petris/pages/widget/singleBlockWidget.dart';

class BoardWidgetLogic {
  final BoardWidgetModel model;

  BoardWidgetLogic(this.model);

  // column yang berisi children kumpulan row
  Column generateBoard() {
    List<Row> rowList = []; // digunakan untuk children column

    for (int baris = 0; baris < 20; baris++) {
      List<SingleBlockWidget> barisTetrisData = [];

      for (int kolom = 0; kolom < 10; kolom++) {
        var blockModel = SingleBlockWidgetModel(
          position: Point(baris, kolom),
        );
        barisTetrisData.add(SingleBlockWidget(model: blockModel));
        model.boardList.add(blockModel);
      }

      Row barisTetrisWidget = Row(
        children: barisTetrisData,
      );

      rowList.add(barisTetrisWidget);
    }
    var column = Column(
      children: rowList,
    );

    return column;
  }
}
