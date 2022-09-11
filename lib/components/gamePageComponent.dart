import 'dart:async';

import 'package:petris/components/baseComponent.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/gamePageModel.dart';

class GamePageComponent extends BaseComponent {
  Timer? gameLoop;
  GamePageModel gamePageModel;

  GamePageComponent({
    required this.gamePageModel,
  });

  @override
  void update() {
    gamePageModel.stopwatch.start();
    gameLoop = Timer.periodic(BoardConfig.loopDuration, (timer) {
      for (var element in gamePageModel.components.reversed) {
        element.update();
      }
      gamePageModel.components.sort((a, b) {
        return a.priority.compareTo(b.priority);
      });
      if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
        gamePageModel.stopwatch.reset();
      }
    });
  }
}
