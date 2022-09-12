import 'dart:async';

import 'package:petris/components/baseComponent.dart';
import 'package:petris/logics/boardWidgetLogic.dart';
import 'package:petris/models/boardWidgetModel.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/gamePageModel.dart';

class GamePageComponent extends BaseComponent {
  Timer? gameLoop;
  final GamePageModel gamePageModel;
  final BoardWidgetModel boardWidgetModel;

  final BoardWidgetLogic boardWidgetLogic = BoardWidgetLogic();

  GamePageComponent({
    required this.gamePageModel,
    required this.boardWidgetModel,
  });

  @override
  void update() {
    gamePageModel.stopwatch.start();
    gameLoop = Timer.periodic(BoardConfig.loopDuration, (timer) {
      boardWidgetLogic.clear(
        boardList: boardWidgetModel.boardList,
      );

      for (var element in gamePageModel.components) {
        element.update();
      }
      if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
        gamePageModel.components.sort((a, b) {
          return a.priority.compareTo(b.priority);
        });
        gamePageModel.stopwatch.reset();
      }
    });
  }
}
