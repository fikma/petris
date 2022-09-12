import 'package:petris/components/baseComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/models/countDownWidgetModel.dart';
import 'package:petris/models/gamePageModel.dart';
import 'package:petris/models/hudWidgetModel.dart';
import 'package:petris/models/tetrisBlockModel.dart';

import '../logics/tetrisBlockLogic.dart';

class BoardWidgetComponent extends BaseComponent {
  GamePageModel gamePageModel;
  TetrisBlockModel tetrisBlockModel;
  BoardWidgetModel boardWidgetModel;
  CountDownWidgetModel countDownWidgetModel;
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
