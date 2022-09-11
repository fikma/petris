import 'dart:math';

import 'package:petris/commands/moveTetrisBlocksCommand.dart';
import 'package:petris/components/baseComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/hudWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/utils/boardConfig.dart';

import '../commands/rotateTetrisBlocksCommand.dart';
import '../logics/tetrisBlockLogic.dart';

class BoardWidgetComponent extends BaseComponent {
  GamePageModel gamePageModel;
  TetrisBlockModel tetrisBlockModel;
  BoardWidgetModel boardWidgetModel;
  CountDownWidgetModel countDownWidgetModel;
  HudWidgetModel hudWidgetModel;

  TetrisBlockLogic tetrisBlockLogic = TetrisBlockLogic();
  BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  BoardWidgetComponent({
    required this.gamePageModel,
    required this.boardWidgetModel,
    required this.tetrisBlockModel,
    required this.countDownWidgetModel,
    required this.hudWidgetModel,
  }) {
    priority = 1;
    gamePageModel.components.add(this);
  }
  @override
  void update() {
    if (gamePageModel.gameStatePaused) {
      return;
    }

    boardWidgetLogic.clear(
      boardList: boardWidgetModel.boardList,
    );

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

          boardWidgetLogic.resetBoard(
            boardList: boardWidgetModel.boardList,
          );
          return;
        }
        // end gameover

        boardWidgetLogic.setTetrisBlockTypeToBoard(
          boardList: boardWidgetModel.boardList,
          tetrisBlocks: tetrisBlockModel.blocks,
        );

        tetrisBlockModel.blocks = tetrisBlockLogic.reset(
          tetrisBlocks: tetrisBlockModel.blocks,
        );
      }

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
        blockSize: 20,
        tetrisShape: tetrisBlockModel.blocks.tetrisShape,
        tetrisShapeList: TetrisShapeList,
      );

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

    // todo:
    // refactor move tetris blok seperti di video
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

    // start move tetris block to bottom
    if (tetrisBlockModel.moveBlocksToBottom) {
      TetrisBlockLogic().moveTetrisBlocksToBottom(
        boardList: boardWidgetModel.boardList,
        tetrisBlocks: tetrisBlockModel.blocks,
      );
    }
    // end move tetris block to bottom

    // start reset flag untuk xMove, rotate, moveBlockToBottom
    tetrisBlockModel.xDirection = const Point(0, 0);
    tetrisBlockModel.rotate = false;
    tetrisBlockModel.moveBlocksToBottom = false;
    // end reset

    var checkLineResult = BoardWidgetLogic().checkLine(
      boardList: boardWidgetModel.boardList,
    );
    if (checkLineResult.isLine) {
      boardWidgetLogic.clear(
        boardList: boardWidgetModel.boardList,
      );
      boardWidgetLogic.moveLineDown(
        boardList: boardWidgetModel.boardList,
        yPositions: checkLineResult.lineResults,
      );
    }

    tetrisBlockLogic.setTetrisBlockColorToBoard(
      boardList: boardWidgetModel.boardList,
      tetrisBlocks: tetrisBlockModel.blocks,
    );
  }
}
