import 'package:petris/components/baseComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/logics/tetrisBlockLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/hudWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';

import '../models/gamePageModel.dart';

class CountDownWidgetComponent extends BaseComponent {
  BoardWidgetModel boardWidgetModel;
  GamePageModel gamePageModel;
  CountDownWidgetModel countDownWidgetModel;
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
