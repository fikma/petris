import 'dart:math';

import 'package:petris/commands/moveComponentCommand.dart';
import 'package:petris/components/baseComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/utils/boardConfig.dart';

import '../logics/tetrisBlockLogic.dart';

class BoardWidgetComponent extends BaseComponent {
  TetrisBlockModel tetrisBlockModel;
  BoardWidgetModel boardWidgetModel;
  CountDownWidgetModel countDownWidgetModel;
  GamePageModel gamePageModel;

  TetrisBlockLogic tetrisBlockLogic = TetrisBlockLogic();

  BoardWidgetComponent({
    required this.gamePageModel,
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

    tetrisBlockLogic.clear(
      boardWidgetModel: boardWidgetModel,
      tetrisBlockModel: tetrisBlockModel,
    );

    var moveCommand = MoveComponentCommand(tetrisBlockModel);
    if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
      moveCommand.execute(tetrisBlockModel.gravity);
      if (tetrisBlockLogic.isBlockOutsideBoardHeight(
        tetrisBlockModel: tetrisBlockModel,
        boardWidgetModel: boardWidgetModel,
      )) {
        moveCommand.undo();
        BoardWidgetLogic().setBoardBlock(
          boardWidgetModel: boardWidgetModel,
          tetrisBlockModel: tetrisBlockModel,
        );

        tetrisBlockModel = tetrisBlockLogic.reset(
          tetrisBlockModel: tetrisBlockModel,
        );
      }

      if (tetrisBlockLogic.isBlockCollideWithTetrominoe(
        tetrisBlockModel: tetrisBlockModel,
        boardWidgetModel: boardWidgetModel,
      )) {
        moveCommand.undo();

        // Gameover logic
        if (tetrisBlockLogic.isBlockOutsideBoardHeight(
          tetrisBlockModel: tetrisBlockModel,
          boardWidgetModel: boardWidgetModel,
          checkTop: true,
        )) {
          print("gameOver");
          gamePageModel.gameStatePaused = true;

          countDownWidgetModel.visible = true;
          countDownWidgetModel.text = "gameOver";
          countDownWidgetModel.updateCallback!();
          BoardWidgetLogic().resetBoard(
            boardWidgetModel: boardWidgetModel,
          );
          return;
        }

        tetrisBlockLogic.clear(
            boardWidgetModel: boardWidgetModel,
            tetrisBlockModel: tetrisBlockModel);

        BoardWidgetLogic().setBoardBlock(
          boardWidgetModel: boardWidgetModel,
          tetrisBlockModel: tetrisBlockModel,
        );

        tetrisBlockModel = tetrisBlockLogic.reset(
          tetrisBlockModel: tetrisBlockModel,
        );
      }
    }

    // todo:
    // refactor move tetris blok seperti di video
    if (tetrisBlockModel.xDirection != Point(0, 0)) {
      moveCommand.execute(tetrisBlockModel.xDirection);
      if (tetrisBlockLogic.isBlockOutsideBoardWidth(
            tetrisBlockModel: tetrisBlockModel,
            boardWidgetModel: boardWidgetModel,
          ) ||
          tetrisBlockLogic.isBlockCollideWithTetrominoe(
            tetrisBlockModel: tetrisBlockModel,
            boardWidgetModel: boardWidgetModel,
          )) {
        moveCommand.undo();
      }
    }

    // reset flag untuk xMove dan rotate
    tetrisBlockModel.xDirection = Point(0, 0);

    var checkLineResult = BoardWidgetLogic().checkLine(
      boardWidgetModel: boardWidgetModel,
    );
    if (checkLineResult[0] as bool) {
      TetrisBlockLogic().clear(
        boardWidgetModel: boardWidgetModel,
        tetrisBlockModel: tetrisBlockModel,
      );
      BoardWidgetLogic().moveLineDown(
        boardWidgetModel: boardWidgetModel,
        yPositions: checkLineResult[1],
      );
    }

    tetrisBlockLogic.setTetrisBlockToBoard(
      boardWidgetModel: boardWidgetModel,
      tetrisBlockModel: tetrisBlockModel,
    );
  }
}
