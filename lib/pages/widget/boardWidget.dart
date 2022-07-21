import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/components/boardWidgetComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/pages/widget/gamePageInheritedWidget.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  late final BoardWidgetModel boardWidgetModel;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var gamePageModel = GamePageInheritedWidget.of(context)!.getGamePageModel;

    boardWidgetModel = GamePageInheritedWidget.of(context)!.getBoardWidgetModel;
    boardWidgetModel.boardList = BoardWidgetLogic.initBoardListModel();

    var tetrisBlock = GamePageInheritedWidget.of(context)!.getTetrisBlockModel;

    TetrisBlockLogic.moveTo(
        direction: const Point(4, 4), tetrisBlockModel: tetrisBlock);

    BoardWidgetComponent(
      gamePageModel: gamePageModel,
      tetrisBlockModel: tetrisBlock,
      boardWidgetModel: boardWidgetModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BoardWidgetLogic.generateBoard(boardWidgetModel);
  }
}
