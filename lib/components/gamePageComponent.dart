import 'dart:async';

import 'package:petris/components/baseComponent.dart';
import 'package:petris/utils/boardConfig.dart';
import 'package:petris/models/gamePageModel.dart';

class GamePageComponent extends BaseComponent {
  GamePageModel gamePageModel;

  GamePageComponent({required this.gamePageModel});

  @override
  void update() {
    gamePageModel.timer.start();
    gamePageModel.loop = Timer.periodic(BoardConfig.loopDuration, (timer) {
      if (!gamePageModel.isRunning) {
        for (var element in gamePageModel.components) {
          element.update();
        }
      } else {
        print("paused");
      }
      if (gamePageModel.timer.elapsedMilliseconds >= BoardConfig.tickTime) {
        gamePageModel.timer.reset();
      }
    });
  }
}
