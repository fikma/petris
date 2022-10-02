import 'dart:async';

import 'package:petris/components/base_component.dart';
import 'package:petris/logics/board_widget_logic.dart';
import 'package:petris/models/board_widget_model.dart';
import 'package:petris/models/tetris_block_model.dart';
import 'package:petris/utils/board_config.dart';
import 'package:petris/models/game_page_model.dart';

import '../logics/tetris_block_logic.dart';

class GamePageComponent implements BaseComponent {
  Timer? gameLoop;
  final GamePageModel gamePageModel;
  final BoardWidgetModel boardWidgetModel;
  final TetrisBlockModel tetrisBlockModel;

  final TetrisBlockLogic tetrisBlockLogic = TetrisBlockLogic();

  final BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  GamePageComponent({
    required this.gamePageModel,
    required this.boardWidgetModel,
    required this.tetrisBlockModel,
  });

  @override
  void update() {
    var isComponentSorted = false;
    gamePageModel.stopwatch.start();
    gameLoop = Timer.periodic(BoardConfig.loopDuration, (timer) {
      boardWidgetLogic.clear(
        boardList: boardWidgetModel.boardList,
      );

      for (var element in gamePageModel.components) {
        element.update();
      }

      if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
        if (!isComponentSorted) {
          gamePageModel.components.sort((a, b) {
            return a.priority.compareTo(b.priority);
          });
          isComponentSorted = true;
        }
        gamePageModel.stopwatch.reset();
      }

      // Todo: hanya block yang berubah warna yang harusnya berubah.
      tetrisBlockLogic.setTetrisBlockColorToBoard(
        isMonochrome: boardWidgetModel.isBlockMonochrome,
        boardList: boardWidgetModel.boardList,
        tetrisBlocks: tetrisBlockModel.currentBlocks,
      );
    });
  }

  @override
  int priority = 0;
}
