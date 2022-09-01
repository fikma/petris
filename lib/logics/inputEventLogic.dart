import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:petris/commands/moveComponentCommand.dart';
import 'package:petris/commands/rotateCommand.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

class InputEventLogic {
  TetrisBlockModel tetrisBlockModel;
  BoardWidgetModel boardWidgetModel;

  InputEventLogic(this.tetrisBlockModel, this.boardWidgetModel);

  KeyEventResult keyBoardInputHandle(FocusNode node, KeyEvent event) {
    if (event is KeyUpEvent) {
      TetrisBlockLogic().clear(
        tetrisBlockModel: tetrisBlockModel,
        boardWidgetModel: boardWidgetModel,
      );
      var component = MoveComponentCommand(tetrisBlockModel);
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        tetrisBlockModel.xDirection = Point(1, 0);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        tetrisBlockModel.xDirection = Point(-1, 0);
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        _rotateBlock();
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        TetrisBlockLogic().clear(
            boardWidgetModel: boardWidgetModel,
            tetrisBlockModel: tetrisBlockModel);

        TetrisBlockLogic().moveToBottom(
          boardWidgetModel: boardWidgetModel,
          tetrisBlockModel: tetrisBlockModel,
        );
      }

      TetrisBlockLogic().setTetrisBlockToBoard(
        tetrisBlockModel: tetrisBlockModel,
        boardWidgetModel: boardWidgetModel,
      );
    }

    return KeyEventResult.handled;
  }

  void _rotateBlock() {
    var rotateCommand = RotateCommand(tetrisBlockModel);
    rotateCommand.execute();
    if (TetrisBlockLogic().isBlockOutsideBoardWidth(
      tetrisBlockModel: tetrisBlockModel,
      boardWidgetModel: boardWidgetModel,
    )) {
      rotateCommand.undo();
    }

    if (TetrisBlockLogic().isBlockCollideWithTetrominoe(
      tetrisBlockModel: tetrisBlockModel,
      boardWidgetModel: boardWidgetModel,
    )) {
      rotateCommand.undo();
    }
  }

  void pointerDownHandle(PointerDownEvent details) {
    tetrisBlockModel.gestureStartLocalLocation = details.localPosition;
  }

  void pointerUpHandle(PointerUpEvent details) {
    tetrisBlockModel.vectorRadianDirection =
        (details.localPosition - tetrisBlockModel.gestureStartLocalLocation!)
            .direction;

    // gestureRight
    if (isBetween(
      tetrisBlockModel.vectorRadianDirection!,
      -0.785,
      0.785,
    )) {
      tetrisBlockModel.xDirection = Point(1, 0);
    } else if ((tetrisBlockModel.vectorRadianDirection! >= 2.355) ||
        (tetrisBlockModel.vectorRadianDirection! <= -2.355)) {
      tetrisBlockModel.xDirection = Point(-1, 0);
    }

    // gestureUp
    if (isBetween(tetrisBlockModel.vectorRadianDirection!, -2.355, -0.785)) {
      _rotateBlock();
    }
  }

  bool isBetween(num value, num min, num max) {
    bool result = false;
    if (value > min && value < max) result = true;
    return result;
  }
}
