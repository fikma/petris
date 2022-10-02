import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';
import 'package:petris/utils/board_config.dart';

class InputEventLogic {
  TetrisBlockModel tetrisBlockModel;
  BoardWidgetModel boardWidgetModel;

  InputEventLogic(this.tetrisBlockModel, this.boardWidgetModel);

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

  void pointerUpHandle(PointerUpEvent details) {
    BoardConfig.tickTime = 700;

    var temp =
        details.localPosition - tetrisBlockModel.gestureStartLocalLocation!;
    tetrisBlockModel.vectorRadianDirection = temp.direction;

    if (tetrisBlockModel.vectorLength! >= 800) {
      // gestureUp
      if (isBetween(tetrisBlockModel.vectorRadianDirection!, -2.355, -0.785)) {
        if (tetrisBlockModel.currentBlocks.tetrisShape != TetrisShape.l) {
          tetrisBlockModel.rotate = true;

          return;
        }
      }
    }
  }

  int clamp(int value, int min, int max) {
    if (value > max) return max;
    if (value < min) return min;

    return value;
  }

  bool isBetween(num value, num min, num max) {
    bool result = false;
    if (value > min && value < max) result = true;
    return result;
  }
}
