import 'dart:math';

import 'package:petris/components/base_component.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/count_down_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/models/main_menu_models.dart';
import 'package:petris/models/tetris_block_model.dart';

import '../commands/move_tetris_blocks_command.dart';
import '../commands/rotate_tetris_blocks_command.dart';
import '../logics/tetris_block_logic.dart';
import '../utils/board_config.dart';

class TetrisBlocksComponent extends BaseComponent {
  final GamePageModel gamePageModel;
  final MainMenuModel mainMenuModel;
  final HudWidgetModel hudWidgetModel;
  final BoardWidgetModel boardWidgetModel;
  final TetrisBlockModel tetrisBlockModel;
  final CountDownWidgetModel countDownWidgetModel;

  TetrisBlockLogic tetrisBlockLogic = TetrisBlockLogic();
  BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  TetrisBlocksComponent({
    required this.gamePageModel,
    required this.mainMenuModel,
    required this.hudWidgetModel,
    required this.boardWidgetModel,
    required this.tetrisBlockModel,
    required this.countDownWidgetModel,
  }) {
    gamePageModel.components.add(this);
  }

  @override
  void update() {
    if (gamePageModel.gameStatePaused) {
      return;
    }

    // start move tetris block to bottom
    if (tetrisBlockModel.moveBlocksToBottom) {
      TetrisBlockLogic().moveTetrisBlocksToBottom(
        boardList: boardWidgetModel.boardList,
        tetrisBlocks: tetrisBlockModel.currentBlocks,
      );
    }
    // end move tetris block to bottom

    // start rotate logic
    if (tetrisBlockModel.rotate) {
      var rotateCommand = RotateTetrisBlocksCommand(
        tetrisBlocks: tetrisBlockModel.currentBlocks,
      );
      rotateCommand.execute();
      if (TetrisBlockLogic().isBlockOutsideBoardWidth(
        tetrisBlocks: tetrisBlockModel.currentBlocks,
      )) {
        rotateCommand.undo();
      }

      if (TetrisBlockLogic().isBlockCollideWithTetrominoe(
        tetrisBlocks: tetrisBlockModel.currentBlocks,
        boardList: boardWidgetModel.boardList,
      )) {
        rotateCommand.undo();
      }
    }
    // end rotate

    var moveCommand = MoveTetrisBlocksCommand(
      tetrisBlocks: tetrisBlockModel.currentBlocks,
    );
    if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
      moveCommand.execute(tetrisBlockModel.gravity);

      if (tetrisBlockLogic.isBlockCollideWithTetrominoe(
        tetrisBlocks: tetrisBlockModel.currentBlocks,
        boardList: boardWidgetModel.boardList,
      )) {
        moveCommand.undo();

        // start Gameover logic
        if (tetrisBlockLogic.isBlockOutsideBoardHeight(
          tetrisBlocks: tetrisBlockModel.currentBlocks,
          checkTop: true,
        )) {
          gamePageModel.gameStatePaused = true;

          mainMenuModel.visible = true;
          mainMenuModel.updateCallback();
        }
        // end gameover

        // start logic ketika tetrisBlock collide dengan boardBlock, reset
        boardWidgetLogic.setTetrisBlockTypeToBoard(
          isMonochrome: boardWidgetModel.isBlockMonochrome,
          boardList: boardWidgetModel.boardList,
          tetrisBlocks: tetrisBlockModel.currentBlocks,
        );

        tetrisBlockModel.currentBlocks =
            tetrisBlockModel.nextBlocks.removeFirst();

        tetrisBlockModel.isTetrisBlocksReseted = true;

        tetrisBlockModel.nextBlocks.add(tetrisBlockLogic.reset(
          tetrisBlocks: tetrisBlockModel.currentBlocks,
        ));
      }
      // end logic ketika tetris block collide dengan boardBlock

      if (tetrisBlockLogic.isBlockOutsideBoardHeight(
        tetrisBlocks: tetrisBlockModel.currentBlocks,
      )) {
        moveCommand.undo();
        boardWidgetLogic.setTetrisBlockTypeToBoard(
          isMonochrome: boardWidgetModel.isBlockMonochrome,
          boardList: boardWidgetModel.boardList,
          tetrisBlocks: tetrisBlockModel.currentBlocks,
        );

        tetrisBlockModel.currentBlocks =
            tetrisBlockModel.nextBlocks.removeFirst();

        tetrisBlockModel.isTetrisBlocksReseted = true;

        tetrisBlockModel.nextBlocks.add(tetrisBlockLogic.reset(
          tetrisBlocks: tetrisBlockModel.currentBlocks,
        ));
      }

      hudWidgetModel.tetrisBlocks = tetrisBlockModel.nextBlocks.first;
      hudWidgetModel.boardList.clear();
      hudWidgetModel.boardList.addAll(boardWidgetLogic.initBoardList(
        blockSize: 10,
        blockColor: HudConfig.boardColor,
        xSize: hudWidgetModel.tetrisBlocks.tetrisSize.x.toInt(),
        ySize: hudWidgetModel.tetrisBlocks.tetrisSize.y.toInt(),
      ));
      tetrisBlockLogic.setTetrisBlockColorToBoard(
        isMonochrome: boardWidgetModel.isBlockMonochrome,
        boardList: hudWidgetModel.boardList,
        tetrisBlocks: hudWidgetModel.tetrisBlocks,
      );
      hudWidgetModel.updateCallback!();
    }

    // start move tetris blok
    if (tetrisBlockModel.xDirection != const Point(0, 0)) {
      moveCommand.execute(tetrisBlockModel.xDirection);
      if (tetrisBlockLogic.isBlockOutsideBoardWidth(
            tetrisBlocks: tetrisBlockModel.currentBlocks,
          ) ||
          tetrisBlockLogic.isBlockCollideWithTetrominoe(
            tetrisBlocks: tetrisBlockModel.currentBlocks,
            boardList: boardWidgetModel.boardList,
          )) {
        moveCommand.undo();
      }
    }
    // end move tetris block

    if (tetrisBlockModel.isTetrisBlocksReseted) {
      tetrisBlockLogic.moveBlockMinTop(
        tetrisBlocks: tetrisBlockModel.currentBlocks,
      );
    }

    // start reset flag untuk xMove, rotate, moveBlockToBottom
    tetrisBlockModel.xDirection = const Point(0, 0);
    tetrisBlockModel.rotate = false;
    tetrisBlockModel.moveBlocksToBottom = false;
    tetrisBlockModel.isTetrisBlocksReseted = false;
    // end reset
  }
}
