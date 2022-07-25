import 'package:flutter/material.dart';
import 'package:petris/components/boardWidgetComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';

import '../../models/gamePageModel.dart';
import '../../models/tetrisBlockModel.dart';

class BoardWidget extends StatefulWidget {
  TetrisBlockModel tetrisBlockModel;
  GamePageModel gamePageModel;
  BoardWidgetModel boardWidgetModel;

  BoardWidgetLogic boardWidgetLogic;

  BoardWidget({
    required this.boardWidgetModel,
    required this.gamePageModel,
    required this.tetrisBlockModel,
    required this.boardWidgetLogic,
  });

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.boardWidgetModel.boardList =
        widget.boardWidgetLogic.initBoardListModel();

    TetrisBlockLogic().reset(widget.tetrisBlockModel);

    BoardWidgetComponent(
      gamePageModel: widget.gamePageModel,
      boardWidgetModel: widget.boardWidgetModel,
      tetrisBlockModel: widget.tetrisBlockModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.boardWidgetLogic.generateBoard(widget.boardWidgetModel);
  }
}
