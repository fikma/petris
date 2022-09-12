import 'dart:math';

import 'package:flutter/material.dart';
import 'package:petris/components/board_widget_component.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/logics/tetris_block_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/main_menu_widget_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/utils/board_config.dart';

import '../../components/tetris_blocks_component.dart';
import '../../models/game_page_model.dart';
import '../../models/tetris_block_model.dart';

class BoardWidget extends StatefulWidget {
  final TetrisBlockModel tetrisBlockModel;
  final GamePageModel gamePageModel;
  final BoardWidgetModel boardWidgetModel;
  final MainMenuModel countDownWidgetModel;
  final HudWidgetModel hudWidgetModel;

  final BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

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

    if (widget.tetrisBlockModel.blocks.isXFlipped) {
      widget.hudWidgetModel.tetrisBlocks = TetrisBlockLogic().invertBlockTetris(
        widget.hudWidgetModel.tetrisBlocks,
      );
    }

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
