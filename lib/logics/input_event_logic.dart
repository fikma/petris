import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/main_menu_models.dart';
import 'package:petris/models/single_block_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';

import '../utils/utils.dart';
import 'board_widget_logic.dart';

class InputEventLogic {
  final MainMenuModel mainMenuModel;
  final GamePageModel gamePageModel;
  final BoardWidgetModel boardWidgetModel;
  final TetrisBlockModel tetrisBlockModel;

  int xTemp = 0, yTemp = 0, threshold = -15;

  InputEventLogic({
    required this.mainMenuModel,
    required this.gamePageModel,
    required this.boardWidgetModel,
    required this.tetrisBlockModel,
  });

  KeyEventResult keyBoardInputHandle(FocusNode node, KeyEvent event) {
    if (event is KeyUpEvent && !gamePageModel.gameStatePaused) {
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

  void pointerMoveHandle(PointerMoveEvent details) {
    if (gamePageModel.gameStatePaused) return;

    xTemp += Utils.clamp(details.delta.dx.toInt(), -1, 1);
    // Todo: fix this magic number
    if (xTemp > Utils.abs(threshold) || xTemp < threshold) {
      tetrisBlockModel.xDirection = Point(Utils.clamp(xTemp, -1, 1), 0);
      xTemp = 0;
    }

    yTemp += Utils.clamp(details.delta.dy.toInt(), -1, 1);

    if (yTemp < threshold) {
      tetrisBlockModel.rotate = true;
      yTemp = 0;
    }
    if (kDebugMode) print('$xTemp $yTemp');
  }

  void pauseButtonHandle() {
    if (mainMenuModel.visible) return;

    gamePageModel.gameStatePaused = true;
    mainMenuModel.visible = true;
    mainMenuModel.updateCallback();
  }

  void monochromeButtonHandle() {
    boardWidgetModel.isBlockMonochrome = true;

    for (var x in boardWidgetModel.boardList) {
      for (var y in x) {
        if (y.type != BlockType.board) y.updateCallback();
      }
    }
  }

  void randomColorButtonHandle() {
    boardWidgetModel.isBlockMonochrome = false;

    for (var x in boardWidgetModel.boardList) {
      for (var y in x) {
        if (y.type != BlockType.board) y.updateCallback();
      }
    }
  }

  void resumeButtonCallback() {
    mainMenuModel.visible = false;
    gamePageModel.gameStatePaused = false;

    if (gamePageModel.isGameOver) {
      gamePageModel.isGameOver = false;
      BoardWidgetLogic().resetBoard(
        boardList: boardWidgetModel.boardList,
      );
    }
  }
}
