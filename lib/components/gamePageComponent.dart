import 'dart:async';

import 'package:petris/components/baseComponent.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/gamePageModel.dart';

class GamePageComponent extends BaseComponent {
  GamePageModel gamePageModel;
  Timer? gameLoop;

  GamePageComponent({required this.gamePageModel});

  @override
  void update() {
    gamePageModel.stopwatch.start();
    gameLoop = Timer.periodic(BoardConfig.loopDuration, (timer) {
      if (this.gamePageModel.isRunning) {
        for (var element in this.gamePageModel.components) {
          element.update();
        }
      } else {
        print("paused");
      }
      if (gamePageModel.stopwatch.elapsedMilliseconds >= BoardConfig.tickTime) {
        this.gamePageModel.stopwatch.reset();
      }
    });
  }
}
