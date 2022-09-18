import 'package:flutter/material.dart';
import 'package:petris/components/board_widget_component.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/logics/tetris_block_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/count_down_widget_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/models/main_menu_models.dart';
import 'package:petris/utils/board_config.dart';

import '../../components/tetris_blocks_component.dart';
import '../../models/game_page_model.dart';
import '../../models/tetris_block_model.dart';

class BoardWidget extends StatefulWidget {
  final GamePageModel gamePageModel;
  final MainMenuModel mainMenuModel;
  final HudWidgetModel hudWidgetModel;
  final BoardWidgetModel boardWidgetModel;
  final TetrisBlockModel tetrisBlockModel;
  final CountDownWidgetModel countDownWidgetModel;

  final BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  BoardWidget({
    super.key,
    required this.mainMenuModel,
    required this.gamePageModel,
    required this.hudWidgetModel,
    required this.tetrisBlockModel,
    required this.boardWidgetModel,
    required this.countDownWidgetModel,
  });

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  void initState() {
    super.initState();

    widget.boardWidgetModel.boardList = widget.boardWidgetLogic.initBoardList(
      xSize: BoardConfig.xSize,
      ySize: BoardConfig.ySize,
      blockSize: BoardConfig.blockSize,
      blockColor: BoardConfig.boardColor,
    );

    widget.tetrisBlockModel.nextBlocks.add(TetrisBlockLogic().reset(
      tetrisBlocks: widget.tetrisBlockModel.currentBlocks,
    ));
    widget.tetrisBlockModel.nextBlocks.add(TetrisBlockLogic().reset(
      tetrisBlocks: widget.tetrisBlockModel.currentBlocks,
    ));

    widget.tetrisBlockModel.currentBlocks =
        widget.tetrisBlockModel.nextBlocks.removeFirst();

    widget.hudWidgetModel.tetrisBlocks =
        widget.tetrisBlockModel.nextBlocks.first;

    BoardWidgetComponent(
      gamePageModel: widget.gamePageModel,
      hudWidgetModel: widget.hudWidgetModel,
      boardWidgetModel: widget.boardWidgetModel,
      tetrisBlockModel: widget.tetrisBlockModel,
      countDownWidgetModel: widget.countDownWidgetModel,
    );

    TetrisBlocksComponent(
      gamePageModel: widget.gamePageModel,
      mainMenuModel: widget.mainMenuModel,
      hudWidgetModel: widget.hudWidgetModel,
      tetrisBlockModel: widget.tetrisBlockModel,
      boardWidgetModel: widget.boardWidgetModel,
      countDownWidgetModel: widget.countDownWidgetModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 4.0,
            // TODO: pindahkan ke model
            color: Colors.black54,
          ),
          // TODO: pindahkan ke model
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: widget.boardWidgetLogic.generateBoard(
        boardList: widget.boardWidgetModel.boardList,
        xGridSize: BoardConfig.xSize,
        yGridSize: BoardConfig.ySize,
        boardWidgetModel: widget.boardWidgetModel,
      ),
    );
  }
}
