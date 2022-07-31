import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:petris/commands/moveComponentCommand.dart';
import 'package:petris/commands/rotateComponent.dart';
import 'package:petris/configs/vector.dart';
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
        component.execute(Vector(1, 0));

        if (TetrisBlockLogic().isBlockOutsideBoardWidth(
          tetrisBlockModel: tetrisBlockModel,
          boardWidgetModel: boardWidgetModel,
        )) {
          component.undo();
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        component.execute(Vector(-1, 0));

        if (TetrisBlockLogic().isBlockOutsideBoardWidth(
          tetrisBlockModel: tetrisBlockModel,
          boardWidgetModel: boardWidgetModel,
        )) {
          component.undo();
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        print("arrow Up pressed");
        var rotateCommand = RotateCommand(tetrisBlockModel);
        rotateCommand.execute();
        if (TetrisBlockLogic().isBlockOutsideBoardWidth(
          tetrisBlockModel: tetrisBlockModel,
          boardWidgetModel: boardWidgetModel,
        )) {
          rotateCommand.undo();
        }
        ;
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        print("arrow Down pressed");
      }

      TetrisBlockLogic().setTetrisBlockToBoard(
        tetrisBlockModel: tetrisBlockModel,
        boardWidgetModel: boardWidgetModel,
      );
    }

    return KeyEventResult.handled;
  }
}
