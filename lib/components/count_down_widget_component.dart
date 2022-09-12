import 'package:petris/components/base_component.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/logics/tetris_block_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/main_menu_widget_model.dart';
import 'package:petris/models/hud_widget_model.dart';
import 'package:petris/utils/board_config.dart';

import '../models/game_page_model.dart';

class CountDownWidgetComponent extends BaseComponent {
  BoardWidgetModel boardWidgetModel;
  GamePageModel gamePageModel;
  MainMenuModel countDownWidgetModel;
  HudWidgetModel hudWidgetModel;

  CountDownWidgetComponent({
    required this.boardWidgetModel,
    required this.gamePageModel,
    required this.countDownWidgetModel,
    required this.hudWidgetModel,
  }) {
    gamePageModel.components.add(this);
  }

  @override
  void update() {
    if (countDownWidgetModel.countStarted) {
      if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
        countDownWidgetModel.text = countDownWidgetModel.counter.toString();
        countDownWidgetModel.updateCallback!();

        if (countDownWidgetModel.counter < 0) {
          countDownWidgetModel.visible = false;
          countDownWidgetModel.updateCallback!();
          countDownWidgetModel.counter = 3;
          countDownWidgetModel.countStarted = false;

          gamePageModel.gameStatePaused = false;
          countDownWidgetModel.nextFocus.requestFocus();

          TetrisBlockLogic().setTetrisBlockColorToBoard(
            tetrisBlocks: hudWidgetModel.tetrisBlocks,
            boardList: hudWidgetModel.boardList,
          );

          BoardWidgetLogic().resetBoard(
            boardList: boardWidgetModel.boardList,
          );

          hudWidgetModel.updateCallback!();
        }

        countDownWidgetModel.counter--;
      }
    }
  }
}
