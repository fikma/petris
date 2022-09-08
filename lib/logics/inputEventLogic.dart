import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';
import 'package:petris/utils/boardConfig.dart';

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
        if (tetrisBlockModel.blocks.tetrisShape != TetrisShape.o) {
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
    tetrisBlockModel.gestureStartLocalLocation = details.localPosition;
  }

  void pointerMoveHandle(PointerMoveEvent details) {
    var temp =
        details.localPosition - tetrisBlockModel.gestureStartLocalLocation!;
    tetrisBlockModel.vectorLength = temp.distanceSquared;

    if (tetrisBlockModel.vectorLength! >= 800) {
      // gestureDown
      if (isBetween(tetrisBlockModel.vectorRadianDirection!, 0.785, 2.355)) {
        BoardConfig.tickTime = 100;
      }
    }
  }

  void pointerUpHandle(PointerUpEvent details) {
    BoardConfig.tickTime = 700;

    var temp =
        details.localPosition - tetrisBlockModel.gestureStartLocalLocation!;
    tetrisBlockModel.vectorRadianDirection = temp.direction;

    if (tetrisBlockModel.vectorLength! >= 800) {
      // gestureUp
      if (isBetween(tetrisBlockModel.vectorRadianDirection!, -2.355, -0.785)) {
        if (tetrisBlockModel.blocks.tetrisShape != TetrisShape.l) {
          tetrisBlockModel.rotate = true;

          return;
        }
      }

      // gestureLeftRight
      if (isBetween(
        tetrisBlockModel.vectorRadianDirection!,
        -0.785,
        0.785,
      )) {
        tetrisBlockModel.xDirection = const Point(1, 0);
      } else if ((tetrisBlockModel.vectorRadianDirection! >= 2.355) ||
          (tetrisBlockModel.vectorRadianDirection! <= -2.355)) {
        tetrisBlockModel.xDirection = const Point(-1, 0);
      }
    }
  }

  bool isBetween(num value, num min, num max) {
    bool result = false;
    if (value > min && value < max) result = true;
    return result;
  }
}
