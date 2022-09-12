import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/components/boardWidgetComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/hudWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';

import '../../components/TetrisBlocksComponent.dart';
import '../../models/gamePageModel.dart';
import '../../models/tetrisBlockModel.dart';

class BoardWidget extends StatefulWidget {
  TetrisBlockModel tetrisBlockModel;
  GamePageModel gamePageModel;
  BoardWidgetModel boardWidgetModel;
  CountDownWidgetModel countDownWidgetModel;
  HudWidgetModel hudWidgetModel;

  BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  BoardWidget({
    Key? key,
    required this.boardWidgetModel,
    required this.gamePageModel,
    required this.tetrisBlockModel,
    required this.countDownWidgetModel,
    required this.hudWidgetModel,
  }) : super(key: key);

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  void initState() {
    super.initState();

    widget.boardWidgetModel.boardList = widget.boardWidgetLogic.initBoardList(
      blockSize: BoardConfig.blockSize,
      xSize: BoardConfig.xSize,
      ySize: BoardConfig.ySize,
      blockColor: BoardConfig.boardColor,
    );

    widget.tetrisBlockModel.blocks = TetrisBlockLogic().reset(
      tetrisBlocks: widget.tetrisBlockModel.blocks,
    );

    widget.hudWidgetModel.tetrisBlocks =
        TetrisBlockLogic().buildTetrominoesByType(
      blockSize: 20,
      tetrisShape: widget.tetrisBlockModel.blocks.tetrisShape,
      tetrisShapeList: TetrisShapeList,
    );

    widget.hudWidgetModel.tetrisBlocks = TetrisBlockLogic().randomizeColor(
      random: Random(),
      tetrisBlocks: widget.hudWidgetModel.tetrisBlocks,
    );

    BoardWidgetComponent(
      gamePageModel: widget.gamePageModel,
      boardWidgetModel: widget.boardWidgetModel,
      tetrisBlockModel: widget.tetrisBlockModel,
      countDownWidgetModel: widget.countDownWidgetModel,
      hudWidgetModel: widget.hudWidgetModel,
    );

    TetrisBlocksComponent(
      gamePageModel: widget.gamePageModel,
      tetrisBlockModel: widget.tetrisBlockModel,
      boardWidgetModel: widget.boardWidgetModel,
      countDownWidgetModel: widget.countDownWidgetModel,
      hudWidgetModel: widget.hudWidgetModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.boardWidgetLogic.generateBoard(
      boardList: widget.boardWidgetModel.boardList,
      xGridSize: BoardConfig.xSize,
      yGridSize: BoardConfig.ySize,
    );
  }
}
