import 'dart:math';

import 'package:petris/components/base_component.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/main_menu_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';

import '../commands/move_tetris_blocks_command.dart';
import '../commands/rotate_tetris_blocks_command.dart';
import '../logics/tetris_block_logic.dart';
import '../utils/board_config.dart';

class TetrisBlocksComponent extends BaseComponent {
  GamePageModel gamePageModel;
  HudWidgetModel hudWidgetModel;
  BoardWidgetModel boardWidgetModel;
  TetrisBlockModel tetrisBlockModel;
  MainMenuModel countDownWidgetModel;

  TetrisBlockLogic tetrisBlockLogic = TetrisBlockLogic();
  BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  TetrisBlocksComponent({
    required this.boardWidgetModel,
    required this.countDownWidgetModel,
    required this.gamePageModel,
    required this.hudWidgetModel,
    required this.tetrisBlockModel,
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
        tetrisBlocks: tetrisBlockModel.blocks,
      );
    }
    // end move tetris block to bottom

    // start rotate logic
    if (tetrisBlockModel.rotate) {
      var rotateCommand = RotateTetrisBlocksCommand(
        tetrisBlocks: tetrisBlockModel.blocks,
      );
      rotateCommand.execute();
      if (TetrisBlockLogic().isBlockOutsideBoardWidth(
        tetrisBlocks: tetrisBlockModel.blocks,
      )) {
        rotateCommand.undo();
      }

      if (TetrisBlockLogic().isBlockCollideWithTetrominoe(
        tetrisBlocks: tetrisBlockModel.blocks,
        boardList: boardWidgetModel.boardList,
      )) {
        rotateCommand.undo();
      }
    }
    // end rotate

    var moveCommand = MoveTetrisBlocksCommand(
      tetrisBlocks: tetrisBlockModel.blocks,
    );
    if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
      moveCommand.execute(tetrisBlockModel.gravity);

      if (tetrisBlockLogic.isBlockCollideWithTetrominoe(
        tetrisBlocks: tetrisBlockModel.blocks,
        boardList: boardWidgetModel.boardList,
      )) {
        moveCommand.undo();

        // start Gameover logic
        if (tetrisBlockLogic.isBlockOutsideBoardHeight(
          tetrisBlocks: tetrisBlockModel.blocks,
          checkTop: true,
        )) {
          gamePageModel.gameStatePaused = true;

          countDownWidgetModel.visible = true;
          countDownWidgetModel.text = "gameOver";
          countDownWidgetModel.updateCallback!();
        }
        // end gameover

        // start logic ketika tetrisBlock collide dengan boardBlock, reset
        boardWidgetLogic.setTetrisBlockTypeToBoard(
          boardList: boardWidgetModel.boardList,
          tetrisBlocks: tetrisBlockModel.blocks,
        );

        tetrisBlockModel.blocks = tetrisBlockLogic.reset(
          tetrisBlocks: tetrisBlockModel.blocks,
        );
      }
      // end logic ketika tetris block collide dengan boardBlock

      if (tetrisBlockLogic.isBlockOutsideBoardHeight(
        tetrisBlocks: tetrisBlockModel.blocks,
      )) {
        moveCommand.undo();
        boardWidgetLogic.setTetrisBlockTypeToBoard(
          boardList: boardWidgetModel.boardList,
          tetrisBlocks: tetrisBlockModel.blocks,
        );

        tetrisBlockModel.blocks = tetrisBlockLogic.reset(
          tetrisBlocks: tetrisBlockModel.blocks,
        );

        return;
      }

      boardWidgetLogic.clear(
        boardList: hudWidgetModel.boardList,
      );

      hudWidgetModel.tetrisBlocks = TetrisBlockLogic().buildTetrominoesByType(
        blockSize: HudConfig.tetrisBlockSize,
        tetrisShape: tetrisBlockModel.blocks.tetrisShape,
        tetrisShapeList: TetrisShapeList,
      );

      if (tetrisBlockModel.blocks.isXFlipped) {
        hudWidgetModel.tetrisBlocks = TetrisBlockLogic().invertBlockTetris(
          hudWidgetModel.tetrisBlocks,
        );
      }

      hudWidgetModel.tetrisBlocks = TetrisBlockLogic().randomizeColor(
        random: Random(),
        tetrisBlocks: hudWidgetModel.tetrisBlocks,
      );
      tetrisBlockLogic.setTetrisBlockColorToBoard(
        boardList: hudWidgetModel.boardList,
        tetrisBlocks: hudWidgetModel.tetrisBlocks,
      );
      hudWidgetModel.updateCallback!();
    }

    // start move tetris blok
    if (tetrisBlockModel.xDirection != const Point(0, 0)) {
      moveCommand.execute(tetrisBlockModel.xDirection);
      if (tetrisBlockLogic.isBlockOutsideBoardWidth(
            tetrisBlocks: tetrisBlockModel.blocks,
          ) ||
          tetrisBlockLogic.isBlockCollideWithTetrominoe(
            tetrisBlocks: tetrisBlockModel.blocks,
            boardList: boardWidgetModel.boardList,
          )) {
        moveCommand.undo();
      }
    }
    // end move tetris block

    // start reset flag untuk xMove, rotate, moveBlockToBottom
    tetrisBlockModel.xDirection = const Point(0, 0);
    tetrisBlockModel.rotate = false;
    tetrisBlockModel.moveBlocksToBottom = false;
    // end reset
  }
}