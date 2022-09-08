import 'package:flutter/material.dart';
import 'package:petris/components/boardWidgetComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';

import '../../models/gamePageModel.dart';
import '../../models/tetrisBlockModel.dart';

class BoardWidget extends StatefulWidget {
  TetrisBlockModel tetrisBlockModel;
  GamePageModel gamePageModel;
  BoardWidgetModel boardWidgetModel;
  CountDownWidgetModel countDownWidgetModel;

  BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  BoardWidget({
    required this.boardWidgetModel,
    required this.gamePageModel,
    required this.tetrisBlockModel,
    required this.countDownWidgetModel,
  });

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    widget.boardWidgetModel.boardList = widget.boardWidgetLogic.initBoardList(
      BoardConfig.xSize,
      BoardConfig.ySize,
    );

    widget.tetrisBlockModel.blocks = TetrisBlockLogic().reset(
      tetrisBlocks: widget.tetrisBlockModel.blocks,
    );

    BoardWidgetComponent(
      gamePageModel: widget.gamePageModel,
      boardWidgetModel: widget.boardWidgetModel,
      tetrisBlockModel: widget.tetrisBlockModel,
      countDownWidgetModel: widget.countDownWidgetModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.boardWidgetLogic.generateBoard(
      boardList: widget.boardWidgetModel.boardList,
    );
  }
}
