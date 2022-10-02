import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/main_menu_models.dart';
import 'package:petris/models/tetris_block_model.dart';

class InputEventLogic {
  final MainMenuModel mainMenuModel;
  final GamePageModel gamePageModel;
  final BoardWidgetModel boardWidgetModel;
  final TetrisBlockModel tetrisBlockModel;

  InputEventLogic({
    required this.mainMenuModel,
    required this.gamePageModel,
    required this.boardWidgetModel,
    required this.tetrisBlockModel,
  });

  KeyEventResult keyBoardInputHandle(FocusNode node, KeyEvent event) {
    if (event is KeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        tetrisBlockModel.xDirection = const Point(1, 0);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        tetrisBlockModel.xDirection = const Point(-1, 0);
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (tetrisBlockModel.currentBlocks.tetrisShape != TetrisShape.o) {
          tetrisBlockModel.rotate = true;
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        tetrisBlockModel.moveBlocksToBottom = true;
      }
    }

    return KeyEventResult.handled;
  }

  void pointerDownHandle(PointerDownEvent details) {
    tetrisBlockModel.gestureStartLocalLocation = Offset.zero;
  }

  int temporary = 0;

  void pointerMoveHandle(PointerMoveEvent details) {
    temporary += clamp(details.delta.dx.toInt(), -1, 1);
    // Todo: fix this magic number
    if (temporary > 20 || temporary < -20) {
      tetrisBlockModel.xDirection = Point(clamp(temporary, -1, 1), 0);
      temporary = 0;
    }
    var temp =
        details.localPosition - tetrisBlockModel.gestureStartLocalLocation!;
    tetrisBlockModel.vectorLength = temp.distanceSquared;
  }

  void pauseButtonHandle() {
    if (mainMenuModel.visible) return;

    gamePageModel.gameStatePaused = true;
    mainMenuModel.visible = true;
    mainMenuModel.updateCallback();
  }

  int clamp(int value, int min, int max) {
    if (value > max) return max;
    if (value < min) return min;

    return value;
  }
}
