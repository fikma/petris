import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:petris/commands/moveComponentCommand.dart';
import 'package:petris/commands/rotateComponent.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

class InputLogic {
  TetrisBlockModel tetrisBlockModel;
  BoardWidgetModel boardWidgetModel;

  InputLogic(this.tetrisBlockModel, this.boardWidgetModel);

  KeyEventResult keyBoardInputHandle(FocusNode node, KeyEvent event) {
    if (event is KeyUpEvent) {
      TetrisBlockLogic().clear(
        tetrisBlockModel: tetrisBlockModel,
        boardWidgetModel: boardWidgetModel,
      );
      var component = MoveComponentCommand(tetrisBlockModel);
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        component.execute(Point(1, 0));

        bool condition1 = TetrisBlockLogic().isBlockOutsideBoardWidth(
          tetrisBlockModel: tetrisBlockModel,
          boardWidgetModel: boardWidgetModel,
        );

        if (condition1) {
          component.undo();
        }

        bool condition2 = TetrisBlockLogic().isBlockCollideWithTetrominoe(
          tetrisBlockModel: tetrisBlockModel,
          boardWidgetModel: boardWidgetModel,
        );

        if (condition2) {
          component.undo();
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        component.execute(Point(-1, 0));

        bool condition1 = TetrisBlockLogic().isBlockOutsideBoardWidth(
          tetrisBlockModel: tetrisBlockModel,
          boardWidgetModel: boardWidgetModel,
        );

        if (condition1) {
          component.undo();
        }

        bool condition2 = TetrisBlockLogic().isBlockCollideWithTetrominoe(
          tetrisBlockModel: tetrisBlockModel,
          boardWidgetModel: boardWidgetModel,
        );

        if (condition2) {
          component.undo();
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
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
        ;
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
}
