import 'package:flutter/material.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = GamePageInheritedWidget.of(context)?.getBoardWidgetModel;
    model?.boardList = BoardWidgetLogic().initializedBoardListModel();

    TetrisBlockLogic().setTetrisBlockToBoard(
      tetrisBlockModel: TetrisBlockModel(),
      boards: model?.boardList,
    );

    return BoardWidgetLogic().generateBoard(context);
  }
}
