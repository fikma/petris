import 'package:petris/components/base_component.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/main_menu_widget_model.dart';
import 'package:petris/models/game_page_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';

import '../logics/tetris_block_logic.dart';

class BoardWidgetComponent extends BaseComponent {
  GamePageModel gamePageModel;
  TetrisBlockModel tetrisBlockModel;
  BoardWidgetModel boardWidgetModel;
  MainMenuModel countDownWidgetModel;
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
    priority = 9;
    gamePageModel.components.add(this);
  }
  @override
  void update() {
    if (gamePageModel.gameStatePaused) {
      return;
    }

    if (!boardWidgetModel.boardFocus.hasFocus) {
      boardWidgetModel.boardFocus.requestFocus();
    }
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
